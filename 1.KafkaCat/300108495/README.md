
# KafkaCat 

### :one: Créer son environnement dans son repertoire :

* Copier le fichier de docker-compose.yml d'apres le repertoire D.Demo.

```
$ cp ../../D.Demo/docker-compose.yml  . 
```

* Enlever les applications de musique

```
$ nano docker-compose.yml
```

* Avant de l'executer dans 1.Kafkacat/ID vous devez supprimer votre environnemnet  dans D.Demo

```
$ cd ../../D.Demo
$ docker-compose stop 
$ docker-compose rm 
```
### :two:  Executez votre environnement dans 1.KafkaCat/ID :

```
$ cd ../../1.KafkaCat/ ID   
$ docker-compose up -d 
```

* Connaitre le nom de switch Docker de KafkaCat

```
$ docker network ls
```

* Faire la liste de tout l'environnment

```
$ docker run --tty --network 300108495_default confluentinc/cp-kafkacat kafkacat -b kafka:29092 -L
```

* Accedez a votre bash de Kafaka

```
$ docker-compose exec kafka bash 
```

* Creation de Topics

```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic clients_info --create --
partitions 3  --replication-factor 1

root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic products --create --
partitions 3  --replication-factor 1
```

### :three: Creation de fichier JSON :

* Vous devez revenir a votre path Develper/INF1069../1.KafkaCat/ID
et vous creez un fichier de json 

```
$ nano client.json 
```

* ajoutez ce code

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

* executer le fichien client.json avec mon topic clients_info, en utilisant kafka_console_producer :

```
$ cat ./client.json | docker exec --interactive kafka kafka-console-producer --b                                                                                            roker-list kafka:9092 --topic clients_info
```

* Pour voir le resultat vous pouvez voir dans le site http://10.13.237.13:9021/management/clusters

### Creation d'un nouveau Stream :

Il faut aller premierment au KSQL Bash :

```
$ docker-compose exec ksql-cli ksql http://ksql-server:8088 
```

Creaton d'un nouveau Stream du topic `clients_info` 
{ "name"   : "John Smith", "sku"    : "20223", "shipTo" : { "name" : "Jane Smith", "address" : "123 Maple Street" }}

```
ksql> CREATE STREAM ksql_clientsinfo (name string, sku bigint, shipTo struct> name string, address string) WITH (KAFKA_TOPIC='clients_info', VALUE_FORMAT='JSON');
```

Pour voir tous  les info des clients :

```
ksql> SELECT * FROM ksql_clientsinfo ;
```

ALors pour Decrire ce stream :

```
ksql> DESCRIBE ksql_clientsinfo;
```

### Creation d'une table utilisant le topic clients_info :

Créez un STREAM à partir du fil d'actualité Kafka `clients_info` :

Utilisez la PARTITION BY pour affecter une clé et utilisez la fonction CAST pour changer le type de champ en String.

```
ksql> CREATE STREAM ksql_clientsinfowithkey WITH (KAFKA_TOPIC='KSQL_SONGFEEDWITHKEY', VALUE_FORMAT='JSON') AS SELECT CAST(SKU AS STRING) AS SKU, NAME, ADDRESS, SHIPTO FROM ksql_clientsinfo PARTITION BY SKU;

ksql> DESCRIBE ksql_clientsinfowithkey;
```


#### Créer les meilleurs classements musicaux :

```
ksql> CREATE TABLE ksql_products AS SELECT SKU, NAME, PRICE, DATE, COUNT(*) AS COUNT FROM ksql_products GROUP BY SKU, NAME, PRICE, DATE;
```
Pour voir tous les infos de cette table :

```
ksql> SELECT * FROM ksql_products;
```
Pour convertir la table qu'on a cree a un stream :

```
ksql> CREATE STREAM ksql_productsstream (name string, sku bigint, price bigint, date bigint ) WITH (KAFKA_TOPIC='products', VALUE_FORMAT='JSON');
```

Pour metter ce stream global et pas de partition :

```
ksql> CREATE STREAM ksql_productsstream  AS SELECT * from ksql_productsstream WHERE ROWTIME is not null PARTITION BY KEYCOL;
```


