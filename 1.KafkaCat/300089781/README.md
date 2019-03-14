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
{"client": "Jo", "aime": {"quantity": 1, "name": "Crock Pot Roast"}}
{"client": "Jess", "aime": {"quantity": 1, "name": "Roasted Asparagus"}}
{"client": "Jane", "aime": {"quantity": -1, "name": "Chicken salad"}}
```
### Créer le stream "client"
```
ksql> CREATE STREAM client \
      (client STRING, \
       aime STRUCT<, \
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

