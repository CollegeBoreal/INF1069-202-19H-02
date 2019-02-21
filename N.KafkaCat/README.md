# KafkaCat

* Connaitre le nom de sa switch Docker

```
$ docker network ls
```

* Faire la liste de tout l'environnment

```
$ docker run --tty --network 300098957_default confluentinc/cp-kafkacat kafkacat -b kafka:29092 -L
```

* ecrire sur un topic `-t` topic `-P` Publisher: CTRL-C pour arreter

```
$  docker run --tty --network 300098957_default confluentinc/cp-kafkacat kafkacat \
          -b kafka:29092 -t new_topic -P
```

* lire le topic `-t` topic `-C` Consummer: CTRL-C pour arreter


```
$  docker run --tty --network 300098957_default confluentinc/cp-kafkacat kafkacat \
          -b kafka:29092 -t new_topic -C
```


https://hub.docker.com/r/confluentinc/cp-kafkacat


https://docs.confluent.io/current/app-development/kafkacat-usage.html#

A l'aide de l'utilitaire KafkaCat créer un environemment permettant de créer des messages 

https://github.com/edenhill/kafkacat


# Load files

Essayer avec la commande `kafka-console-producer` et `cat:

```
$ $ cat ~/my_file.json | docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic my_topic
```
