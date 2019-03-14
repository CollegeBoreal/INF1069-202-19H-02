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
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic clients --create --partitions 3 --replication-factor 1
Created topic "clients"
```
### Sortir de kafka pour aller changer les fichiers séparemment
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
{"client": "Jo", "like": {"quantity": 1, "name": "Crock Pot Roast"}}
{"client": "Jess", "like": {"quantity": 1, "name": "Roasted Asparagus"}}
{"client": "Jane", "like": {"quantity": -1, "name": "Chicken salad"}}
```
### Tester le tout sur le terminal (2) ET sur le control center
```
toronto:300089781 ameliedubois$ sh jeu.sh
foodie
>>>>>>>>>>>>>>>>>>>>>>>>toronto:300089781 ameliedubois$ sh jeu1.sh
Clients 
>>>>>>>>>>>>
```
```
 ksql> CREATE STREAM clients (client string, quantity string, name string) WITH (KAFKA_TOPIC='clients', VALUE_FORMAT='JSON');

 Message        
----------------
 Stream created 
----------------
ksql> SELECT * FROM clients;
^CQuery terminated
ksql> DESCRIBE clients;

Name                 : CLIENTS
 Field    | Type                      
--------------------------------------
 ROWTIME  | BIGINT           (system) 
 ROWKEY   | VARCHAR(STRING)  (system) 
 CLIENT   | VARCHAR(STRING)           
 QUANTITY | VARCHAR(STRING)           
 NAME     | VARCHAR(STRING)           
--------------------------------------
For runtime statistics and query details run: DESCRIBE EXTENDED <Stream,Table>;

ksql> show streams;

 Stream Name | Kafka Topic | Format 
------------------------------------
 PLAT        | repas       | JSON   
 CLIENTS     | clients     | JSON   
------------------------------------

ksql> SELECT * FROM clients;
1552500719172 | null | Jo | null | null
1552500726561 | null | Jess | null | null
1552500735352 | null | Jo | null | null

```
```

```
CREATE STREAM client \
      (user STRUCT<\
            client VARCHAR, \
            quantity VARCHAR, \
            name VARCHAR>) \
    WITH (KAFKA_TOPIC='client', VALUE_FORMAT='JSON');
