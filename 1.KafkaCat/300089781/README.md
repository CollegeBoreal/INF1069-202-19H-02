# KAFKACAT 

```
$ cd ../../1.KafkaCat/ 300089781  
$ docker-compose up -d 
$ docker network ls
$ docker run --tty --network 300089781_default confluentinc/cp-kafkacat kafkacat -b kafka:29092 -L
```
### Accèder à Kafka bash

```
$ docker-compose exec kafka bash 
```
### Faire la création des topics
```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic repas --create --partitions 3 --replication-factor 1
Created topic "repas"
```
```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic client --create --partitions 3 --replication-factor 1
Created topic "client"
```
### Sortir de kafka pour aller changer les fichiers séparemment, par exemple:
```
$ nano repas1.json
```
```
{"name": "Crock Pot Roast","ingredients": [{"quantity": "1","name": " beef roast","type": "Meat"}}
```
```
$ nano client.json
```
```
{"client": "Jo", "aime": {"quantity": 1, "name": "Crock Pot Roast"}}
{"client": "Jess", "aime": {"quantity": 1, "name": "Roasted Asparagus"}}
{"client": "Jane", "aime": {"quantity": -1, "name": "Chicken salad"}}
```
### Créer le stream "client"
```
ksql> CREATE STREAM client \
      (client STRING, \
       aime STRUCT< \
       quantity BIGINT, \
       name STRING>) \
    WITH (KAFKA_TOPIC='client', VALUE_FORMAT='JSON');
```
## Sur le 1er terminal, partir le jeu SH.JEU1.SH et sur 2e terminal, tester :

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
```
ksql> select client, aime->QUANTITY,aime->NAME from client;
Jo | 1 | Crock Pot Roast
Jess | 1 | Roasted Asparagus
Jane | -1 | Chicken salad
Jo | 1 | Crock Pot Roast
Jess | 1 | Roasted Asparagus
Jane | -1 | Chicken salad
Jo | 1 | Crock Pot Roast
Jane | -1 | Chicken salad
Jo | 1 | Crock Pot Roast
Jane | -1 | Chicken salad
Jane | -1 | Chicken salad
Jo | 1 | Crock Pot Roast
...
```
##Création d'une table 'client'
```
ksql> CREATE TABLE client \
>      (client STRING, \
>       aime STRUCT< \
>       quantity BIGINT, \
>       name STRING>) \
>    WITH (KAFKA_TOPIC='client', VALUE_FORMAT='JSON', KEY='aime');

 Message       
---------------
 Table created 
---------------
ksql> show tables;

 Table Name | Kafka Topic | Format | Windowed 
----------------------------------------------
 CLIENT     | client      | JSON   | false    
----------------------------------------------
```
###Créer le stream 'repas'
```
ksql> CREATE STREAM repas \
      (name STRING, \
       ingredients STRUCT< \
       quantity BIGINT, \
       name STRING, \
       type STRING>) \
    WITH (KAFKA_TOPIC='repas', VALUE_FORMAT='JSON');
 Message        
----------------
 Stream created 
----------------    
```
##Tester le jeu dans les 2 terminals:
```
(1er terminal)
ksql> select * from repas;
1552588012407 | null | Crock Pot Roast | {QUANTITY=1, NAME= beef roast, TYPE=Meat}
1552588418594 | null | Roasted Asparagus | {QUANTITY=5, NAME=asparagus, TYPE=Produce}
1552588199980 | null | Crock Pot Roast | {QUANTITY=1, NAME= beef roast, TYPE=Meat}
1552588208184 | null | Chicken salad | {QUANTITY=3, NAME=skinless, boneless chicken breasts, TYPE=Meat}
1552588211963 | null | Crock Pot Roast | {QUANTITY=1, NAME= beef roast, TYPE=Meat}
1552588220435 | null | Chicken salad | {QUANTITY=3, NAME=skinless, boneless chicken breasts, TYPE=Meat}
1552588225112 | null | Crock Pot Roast | {QUANTITY=1, NAME= beef roast, TYPE=Meat}
1552588233591 | null | Chicken salad | {QUANTITY=3, NAME=skinless, boneless chicken breasts, TYPE=Meat}
1552588237367 | null | Crock Pot Roast | {QUANTITY=1, NAME= beef roast, TYPE=Meat}
1552588443476 | null | Roasted Asparagus | {QUANTITY=5, NAME=asparagus, TYPE=Produce}
```
```
(2e terminal)
toronto:300089781 ameliedubois$ sh jeu.sh
foodie
>>>>>>>>>>>>>>>>>>>>>>>>>>>>
```
