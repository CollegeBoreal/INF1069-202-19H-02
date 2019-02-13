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
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic dessert --create --partitions 5 --replication-factor 1
Created topic "dessert"
```
```
$ nano ~/my_file.json
```
```
{"name": "Crock Pot Roast","ingredients": [{"quantity": "1","name": " beef roast","type": "Meat"}
```
```
$ cat ~/my_file.json | docker exec \
>                    --interactive kafka kafka-console-producer \
>                    --broker-list kafka:9092 --topic repas
```
