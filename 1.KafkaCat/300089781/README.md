# KAFKACAT , JEU DE REPAS
### :hand: Pour commencer, entrer dans le cours et dans son ID puis s'assurer que Kafka, Zookeeper, KSQL et control center est "UP"
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
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic repas --create --partitions 4 --replication-factor 1
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
### :hand: S'assurer que les fichiers json sont créés (client.json, repas.json et pour tous les clients ET repas)
*Par exemple, client:
```
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
### :hand: Si Control Center ne fonctionne pas, utiliser kafka consumer:
```
root@kafka:/# kafka-console-consumer --bootstrap-server kafka:9092 --topic repas
```
### :six: Retourner dans le terminal où KSQL est ouvert. Créer le stream 'ksql_repas'
```
ksql> CREATE STREAM ksql_repas (name STRING, \
                               client STRING, \
                               ingredients STRUCT< \
                               quantity BIGINT, \
                               name STRING, \
                               type STRING>, \
			       eta BIGINT) \
      WITH (VALUE_FORMAT='JSON', \
      KAFKA_TOPIC='repas');
	
 Message        
----------------
 Stream created 
----------------    
```    
*Pour voir les informations de ksql_repas:
```
ksql> SELECT * FROM KSQL_REPAS;
1553797619399 | null | Crock Pot Roast | Jo | {QUANTITY=1, NAME= beef roast, TYPE=Meat} | 1553279744
1553797623235 | null | Roasted Asparagus | Jess | {QUANTITY=5, NAME=asparagus, TYPE=Produce} | 1553711744
1553797626833 | null | Chicken salad | Jane | {QUANTITY=3, NAME=skinless, boneless chicken breasts, TYPE=Meat} | 1553798144
1553797630854 | null | Mac N Cheese | Jack | {QUANTITY=2, NAME=mac n cheese, TYPE=pasta} | 1553884544
1553797634731 | null | French toast | Johnny | {QUANTITY=1, NAME=breakfast, TYPE=bread} | 1553970944
...
```

*Faire la création du stream client:
```
ksql> CREATE STREAM client (client STRING,\ 
		      aime STRUCT< \
		      quantity BIGINT, \
		      name STRING>)
	WITH (KAFKA_TOPIC='client', VALUE_FORMAT='JSON');
	
 Message        
----------------
 Stream created 
----------------
```
*Pour voir les informations de client;
```
ksql> SELECT * FROM CLIENT;
1554311936111 | null | Jess | {QUANTITY=1, NAME=Roasted Asparagus}
1554311936075 | null | Jo | {QUANTITY=1, NAME=Crock Pot Roast}
1554311936120 | null | Johnny | {QUANTITY=1, NAME=French toast}
1554311936118 | null | Jack | {QUANTITY=2, NAME=Mac N Cheese}
1554311936118 | null | Jane | {QUANTITY=-1, NAME=Chicken salad}
1554311942122 | null | Jo | {QUANTITY=1, NAME=Crock Pot Roast}
1554311946075 | null | Jess | {QUANTITY=1, NAME=Roasted Asparagus}
1554311949540 | null | Jane | {QUANTITY=-1, NAME=Chicken salad}
1554311953466 | null | Jack | {QUANTITY=2, NAME=Mac N Cheese}
1554311957026 | null | Johnny | {QUANTITY=1, NAME=French toast}
```

### :seven: Creer un stream du topic ksql_repas ayant une clé (pour enlever les "null")
```
ksql>  CREATE STREAM repas_with_key \
       WITH (VALUE_FORMAT='AVRO', \
       KAFKA_TOPIC='repas_with_key') AS \
          SELECT name, client, ingredients->quantity, ingredients->name, ingredients->type, eta \
                FROM ksql_repas PARTITION BY client;
 Message                    
----------------------------
 Stream created and running 
----------------------------
```
*Pour voir les informations de repas_with_key:
```
1553797754449 | Jo | Crock Pot Roast | Jo | 1 |  beef roast | Meat | 1553279744
1553797758337 | Jess | Roasted Asparagus | Jess | 5 | asparagus | Produce | 1553711744
1553797762840 | Jane | Chicken salad | Jane | 3 | skinless, boneless chicken breasts | Meat | 1553798144
1553797767394 | Jack | Mac N Cheese | Jack | 2 | mac n cheese | pasta | 1553884544
1553797771175 | Johnny | French toast | Johnny | 1 | breakfast | bread | 1553970944
```
### :eight: Faire la creation d'une table
```
ksql>  CREATE TABLE ksql_client_table \
       WITH (VALUE_FORMAT='AVRO', \
       KAFKA_TOPIC='repas_with_key', KEY='client');

 Message       
---------------
 Table created 
---------------
```

*Pour voir les informations de client:
```
1554312085083 | Jo | Crock Pot Roast | Jo | 1553279744 | 1 |  beef roast | Meat
1554312089358 | Jess | Roasted Asparagus | Jess | 1553711744 | 5 | asparagus | Produce
1554312094607 | Jane | Chicken salad | Jane | 1553798144 | 3 | skinless, boneless chicken breasts | Meat
1554312098975 | Jack | Mac N Cheese | Jack | 1553884544 | 2 | mac n cheese | pasta
1554312102690 | Johnny | French toast | Johnny | 1553970944 | 1 | breakfast | bread
```

### :nine: Faire la jointure du stream KSQL_REPAS et la table KSQL_CLIENT_TABLE:
```
ksql> select * from ksql_repas CI \
      left outer join \
      ksql_client_table PR \ 
      on PR.client = CI.client;
1553801884771 | Jo | null | Jo | {QUANTITY=1, NAME= beef roast, TYPE=Meat} | null | 1553801884771 | Jo | null | Jo | 1 |  beef roast | Meat | null
1553801889275 | Jo | Crock Pot Roast | Jo | {QUANTITY=1, NAME= beef roast, TYPE=Meat} | 1553279744 | 1553801889275 | Jo | Crock Pot Roast | Jo | 1 |  beef roast | Meat | 1553279744
1553801893159 | Jess | Roasted Asparagus | Jess | {QUANTITY=5, NAME=asparagus, TYPE=Produce} | 1553711744 | 1553801884817 | Jess | null | Jess | 5 | asparagus | Produce | null
1553801898172 | Jane | Chicken salad | Jane | {QUANTITY=3, NAME=skinless, boneless chicken breasts, TYPE=Meat} | 1553798144 | 1553801898172 | Jane | Chicken salad | Jane | 3 | skinless, boneless chicken breasts | Meat | 1553798144
1553801903170 | Jack | Mac N Cheese | Jack | {QUANTITY=2, NAME=mac n cheese, TYPE=pasta} | 1553884544 | 1553801884824 | Jack | null | Jack | 2 | mac n cheese | pasta | 1553884544
1553801907304 | Johnny | French toast | Johnny | {QUANTITY=1, NAME=breakfast, TYPE=bread} | 1553970944 | 1553801907304 | Johnny | French toast | Johnny | 1 | breakfast | bread | 1553970944
```
### :round_pushpin: S'il y a un problème de partition lors de la création de la jointure, il faut seulement suprimer le topic en question qui a le problème de partition et le recréer avec plus de partitions.
```
$ docker-compose exec kafka bash
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic repas --delete
```

### :round_pushpin: Note à partager: Lorsque la table avec la clé (par exemple KSQL_REPAS_TABLE) est créé, il sera impossible de supprimer le stream KSQL_REPAS. Un message d'erreur va apparaitre:
```
ksql> drop stream ksql_repas;
Cannot drop KSQL_REPAS. 
The following queries read from this source: [CSAS_REPAS_WITH_KEY_3]. 
The following queries write into this source: []. 
You need to terminate them before dropping KSQL_REPAS.
```
*Il va falloir premièrement faire la commande " show queries; "
```
ksql> show queries;

 Query ID              | Kafka Topic    | Query String                                                                                                                                                                                                                                          
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 CSAS_REPAS_WITH_KEY_3 | REPAS_WITH_KEY | CREATE STREAM repas_with_key     WITH (VALUE_FORMAT='AVRO',     KAFKA_TOPIC='repas_with_key') AS           SELECT name, client, ingredients->quantity, ingredients->name, ingredients->type, eta                 FROM ksql_repas PARTITION BY client; 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
For detailed information on a Query run: EXPLAIN <Query ID>;
```
*Copier et coller le QUERY en question et le "drop" par la suite (le ou les streams):
```
ksql> terminate  CSAS_REPAS_WITH_KEY_3;

 Message           
-------------------
 Query terminated. 
-------------------
ksql> drop stream repas_with_key;

 Message                             
-------------------------------------
 Source REPAS_WITH_KEY was dropped.  
-------------------------------------
ksql> drop stream ksql_repas;

 Message                         
---------------------------------
 Source KSQL_REPAS was dropped.  
---------------------------------
```
