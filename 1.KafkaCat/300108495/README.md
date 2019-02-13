
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
==> Creation de fichier JSON :

Vous devez revenir a votre path Develper/INF1069../1.KafkaCat/ID
et vous creez un fichier de json 

```
$ nano client_json 
```
et ajoutez ce code

```

{ "name"   : "John Smith", "sku"    : "20223", "shipTo" : { "name" : "Jane Smith", "address" : "123 Maple Street" }
{ "name"   : "Frank lil", "sku"    : "20224", "shipTo" : { "name" : "Jessi", "address" : "154 Webster" }
{ "name"   : "Lele Pos", "sku"    : "20225", "shipTo" : { "name" : "Amelie", "address" : "18 jane" }
{ "name"   : "John Smith", "sku"    : "20226", "shipTo" : { "name" : "Jane Smith", "address" : "123 Maple Street" }
{ "name"   : "Frank lil", "sku"    : "20227", "shipTo" : { "name" : "Jessi", "address" : "154 Webster" }
{ "name"   : "Lele Pos", "sku"    : "20228", "shipTo" : { "name" : "Amelie", "address" : "18 jane" }
{ "name"   : "John Smith", "sku"    : "20223", "shipTo" : { "name" : "Jane Smith", "address" : "123 Maple Street" }
{ "name"   : "Frank lil", "sku"    : "20224", "shipTo" : { "name" : "Jessi", "address" : "154 Webster" }
{ "name"   : "Lele Pos", "sku"    : "20225", "shipTo" : { "name" : "Amelie", "address" : "18 jane" }
{ "name"   : "Lele Pos", "sku"    : "20228", "shipTo" : { "name" : "Amelie", "address" : "18 jane" }
{ "name"   : "John Smith", "sku"    : "20223", "shipTo" : { "name" : "Jane Smith", "address" : "123 Maple Street" }
{ "name"   : "Frank lil", "sku"    : "20224", "shipTo" : { "name" : "Jessi", "address" : "154 Webster" }

```
==> executer le fichien client.json avec mon topic clients_info, en utilisant kafka_console_producer :

```
$ cat ./client.json | docker exec --interactive kafka kafka-console-producer --b                                                                                            roker-list kafka:9092 --topic clients_info
```



