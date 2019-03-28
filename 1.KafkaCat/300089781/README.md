# KAFKACAT 
### :stop: Pour commencer, entrer dans le cours et son ID puis s'assurer que Kafka, Zookeeper, KSQL et control center est "UP"
```
$ cd ../../1.KafkaCat/ 300089781  
$ docker-compose up -d 
$ docker network ls
$ docker run --tty --network 300089781_default confluentinc/cp-kafkacat kafkacat -b kafka:29092 -L
```
### :one: Accèder à Kafka bash

```
$ docker-compose exec kafka bash 
```
### :two: Faire la création des topics
```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic repas --create --partitions 3 --replication-factor 1
Created topic "repas"
```
```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic client --create --partitions 3 --replication-factor 1
Created topic "client"
```
### :three: Entrer dans ksql
```
$ docker-compose exec ksql-cli ksql http://ksql-server:8088
```
### :stop: S'assurer que les fichiers json sont créés (client.json, repas.json et pour tous les clients ET repas)
```
*Par exemple, client:

$ nano client.json
```
```
{"client": "Jo", "aime": {"quantity": 1, "name": "Crock Pot Roast"}}
{"client": "Jess", "aime": {"quantity": 1, "name": "Roasted Asparagus"}}
{"client": "Jane", "aime": {"quantity": -1, "name": "Chicken salad"}}
{"client": "Jack", "aime": {"quantity": 2, "name": "Mac N Cheese"}}
{"client": "Johnny", "aime": {"quantity": 1, "name": "French toast"}}
```
### :four: Ouvrir un 2e terminal. Sur le 1er terminal, partir le jeu SH.JEU1.SH (client) et sur 2e terminal, tester :

```
(1er terminal)
toronto:300089781 ameliedubois$ sh jeu1.sh
Client
>>>>>>>>>>>>
```
```
(2e terminal)
ksql> SELECT * FROM client;
1552585858177 | null | Jo | {QUANTITY=1, NAME=Crock Pot Roast}
1552585862330 | null | Jess | {QUANTITY=1, NAME=Roasted Asparagus}
1552585866496 | null | Jane | {QUANTITY=-1, NAME=Chicken salad}
1552585872980 | null | Jo | {QUANTITY=1, NAME=Crock Pot Roast}
...
```
### :five: Regarder le jeu marcher sur Control Center (127.0.0.1:9021) (exemple de mon REPAS)
![alt tag](cc.png)
### :stop: Si Control Center ne fonctionne pas, utiliser kafka consumer:
```
root@kafka:/# kafka-console-consumer --bootstrap-server kafka:9092 --topic repas
```
### :six: Retourner dans le terminal où KSQL est ouvert. Créer le stream 'ksql_repas'
```
ksql> CREATE STREAM ksql_repas (name STRING, \
>                              client STRING, \
>                              eta BIGINT, \
>                              ingredients STRUCT< \
>                              quantity BIGINT, \
>                              name STRING, \
>                              type STRING>) \
>     WITH (VALUE_FORMAT='JSON', \
>     KAFKA_TOPIC='repas');
    ```
	
 Message        
----------------
 Stream created 
----------------    
```    
Pour voir les informations de ksql_repas:
```
ksql> SELECT * FROM KSQL_REPAS;
1553795049562 | null | null | Jane | null | {QUANTITY=3, NAME=skinless, boneless chicken breasts, TYPE=Meat}
1553795049529 | null | null | Jo | null | {QUANTITY=1, NAME= beef roast, TYPE=Meat}
1553795049563 | null | null | Jack | 1553884544 | {QUANTITY=2, NAME=mac n cheese, TYPE=pasta}
1553795049559 | null | null | Jess | null | {QUANTITY=5, NAME=asparagus, TYPE=Produce}
1553795049564 | null | null | Johnny | 1553970944 | {QUANTITY=1, NAME=breakfast, TYPE=bread}
1553795055275 | null | null | Jo | 1553279744 | {QUANTITY=1, NAME= beef roast, TYPE=Meat}
1553795059401 | null | null | Jess | 1553711744 | {QUANTITY=5, NAME=asparagus, TYPE=Produce}
1553795063907 | null | null | Jane | 1553798144 | {QUANTITY=3, NAME=skinless, boneless chicken breasts, TYPE=Meat}
...
```
### :seven: Creer un stream du topic ksql_repas ayant une clé (pour enlever les "null")
```
ksql>  CREATE STREAM repas_with_key \
    WITH (VALUE_FORMAT='AVRO', \
    KAFKA_TOPIC='repas_with_key') AS \
          SELECT name, client, eta, ingredients->quantity, ingredients->name, ingredients->type \
                FROM ksql_repas PARTITION BY client;
 Message                    
----------------------------
 Stream created and running 
----------------------------
```
### :eight: Faire la creation d'une table
```
ksql> CREATE TABLE ksql_repas_table \
      WITH (VALUE_FORMAT='AVRO', \
      KAFKA_TOPIC='repas_with_key', KEY='client');

 Message       
---------------
 Table created 
---------------
```
## Tester le jeu dans les 2 terminals:
```
(1er terminal)
ksql> select * from repas;
1553191266415 | null | Roasted Asparagus | Jess | null | {QUANTITY=5, NAME=asparagus, TYPE=Produce}
1553191266422 | null | French toast | Johnny | 1553970944 | {QUANTITY=1, NAME=breakfast, TYPE=bread}
1553191271821 | null | Crock Pot Roast | Jo | 1553279744 | {QUANTITY=1, NAME= beef roast, TYPE=Meat}
1553191275905 | null | Roasted Asparagus | Jess | 1553711744 | {QUANTITY=5, NAME=asparagus, TYPE=Produce}
1553191279736 | null | Chicken salad | Jane | 1553798144 | {QUANTITY=3, NAME=skinless, boneless chicken breasts, TYPE=Meat}
1553191283758 | null | Mac N Cheese | Jack | 1553884544 | {QUANTITY=2, NAME=mac n cheese, TYPE=pasta}
```
```
(2e terminal)
toronto:300089781 ameliedubois$ sh jeu.sh
foodie
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
```

### inner join problem...
```
ksql> describe repas;

Name                 : REPAS
 Field       | Type                                                                
-----------------------------------------------------------------------------------
 ROWTIME     | BIGINT           (system)                                           
 ROWKEY      | VARCHAR(STRING)  (system)                                           
 NAME        | VARCHAR(STRING)                                                     
 CLIENT      | VARCHAR(STRING)                                                     
 ETA         | BIGINT                                                              
 INGREDIENTS | STRUCT<QUANTITY BIGINT, NAME VARCHAR(STRING), TYPE VARCHAR(STRING)> 
-----------------------------------------------------------------------------------
For runtime statistics and query details run: DESCRIBE EXTENDED <Stream,Table>;
ksql> describe client;

Name                 : CLIENT
 Field   | Type                                          
---------------------------------------------------------
 ROWTIME | BIGINT           (system)                     
 ROWKEY  | VARCHAR(STRING)  (system)                     
 CLIENT  | VARCHAR(STRING)                               
 AIME    | STRUCT<QUANTITY BIGINT, NAME VARCHAR(STRING)> 
---------------------------------------------------------
For runtime statistics and query details run: DESCRIBE EXTENDED <Stream,Table>;
ksql> SELECT * FROM repas INNER JOIN client ON client;
Failed to prepare statement: Field CLIENT is ambiguous.
Caused by: Field CLIENT is ambiguous.
ksql> SELECT * FROM repas INNER JOIN client ON client.client=repas.client;
Source table (CLIENT) key column (AIME) is not the column used in the join criteria (CLIENT).
ksql> SELECT * FROM client INNER JOIN repas ON client.client=repas.client;
Join between invalid operands requested: left type: KTABLE, right type: KSTREAM
```
