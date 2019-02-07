# KafkaCat


```
$ docker network ls
```

```
$ docker run --tty --network 300098957_default confluentinc/cp-kafkacat kafkacat -b kafka:29092 -L
```


https://hub.docker.com/r/confluentinc/cp-kafkacat


https://docs.confluent.io/current/app-development/kafkacat-usage.html#

A l'aide de l'utilitaire KafkaCat créer un environemment permettant de créer des messages 

https://github.com/edenhill/kafkacat


# Load files

```
$ docker-compose exec kafka kafka-console-producer  --broker-list kafka:9092  --topic my_topic  --new-producer < my_file.txt
```
