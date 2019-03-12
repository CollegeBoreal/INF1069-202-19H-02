
# 🔎KAFKACAT 

```
$ cd ../../1.KafkaCat/ 300105468 
$ docker-compose up -d 
$ docker network ls
$ docker run --tty --network 300105468_default confluentinc/cp-kafkacat kafkacat -b kafka:29092 -L
```
### Accèder à Kafka bash

```
$ docker-compose exec kafka bash 
```
### Faire la création des topics
```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic reggae_music --create --partitions 3 --replication-factor 1
Created topic "reggae_music"
```
```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic rmb_music --create --partitions 5 --replication-factor 1
Created topic "plats"
```
```
$ docker run --interactive \
           --network 300105468_default \
           confluentinc/cp-kafkacat \
            kafkacat -b kafka:29092 \
                    -t my_topic \
                    -K: \
                    -P <<EOF
{"Date":"2019-01-08","Open":7.53,"High":7.6,"Low":7.35,"Close":7.41,"Adj Close":7.41,"Volume":3960900}
EOF
```
