
# 🔎KAFKACAT 

```
$ cd ../../1.KafkaCat/ 3000105468 
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
root@kafka:/# kafka-topics --zookeeper --zookeeper:32181 --topic reggae_music --create --partitions 3 --replication-factor 1
Created topic "reggae_music"
```
```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic dessert --create --partitions 5 --replication-factor 1
Created topic "dessert"
```

