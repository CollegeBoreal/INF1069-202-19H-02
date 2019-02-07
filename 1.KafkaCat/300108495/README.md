
# KafkaCat 

### :one: Créer son environnement dans son repertoire :

Copier le fichier de docker-compose.yml d'apres le repertoire D.Demo.

```
$ cp ../../D.Demo/docker-compose.yml  . 
```

=> Enlever les applications de musique

```
$ nano docker-compose.yml
```

=> Avant de l'executer dans 1.Kafkacat/ID vous devez supprimer votre environnemnet  dans D.Demo

```
$ cd ../../D.Demo
$ docker-compose stop 
$ docker-compose rm 
```
=> Executez votre environnement dans 1.KafkaCat/ID

```
$ cd ../../1.KafkaCat/ ID   
$ docker-compose up -d 
$ docker network ls
$ docker run --tty --network 300108495_default confluentinc/cp-kafkacat kafkacat -b kafka:29092 -L
```
=> Accedez a votre bash de Kafaka

```
$ docker-compose exec kafka bash 
```
=> Creation de Topics

```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic clients_info --create --
partitions 3  --replication-factor 1

root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic artists --create --
partitions 3  --replication-factor 1
```


