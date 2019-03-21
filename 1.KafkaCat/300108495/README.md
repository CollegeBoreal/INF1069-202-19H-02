
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
Created topic "clients_info".

root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic products --create --
partitions 3  --replication-factor 1
Created topic "products".
```

### :three: Creation de fichier JSON :

* Vous devez revenir a votre path Develper/INF1069../1.KafkaCat/ID
et vous creez un fichier de json 

```
$ nano client1.json 
```

* ajoutez ce code

```

{ "name"   : "John Smith", "sku"    : "20223", "shipTo" : { "name" : "Jane Smith", "address" : "123 Maple Street" }}

```
et vous pouvez ajouter les autres fichier de client$.json avec un de ces lignes 
```
{ "name"   : "Frank lil", "sku"    : "20224", "shipTo" : { "name" : "Frank", "address" : "154 Webster" }}
{ "name"   : "Lele Pos", "sku"    : "20225", "shipTo" : { "name" : "LeLe", "address" : "18 jane" }}
{ "name"   : "John Smith", "sku"    : "20226", "shipTo" : { "name" : "Jane Smith", "address" : "123 Maple Street" }}
{ "name"   : "Safaa Zaoui", "sku"    : "20227", "shipTo" : { "name" : "Jessi", "address" : "154 Webster" }}
{ "name"   : "LAmelie Dubois", "sku"    : "20228", "shipTo" : { "name" : "Amelie", "address" : "18 jane" }}


```
et la meme chose pour le fichier de product$.json
```
{ "name"   : "Scarf", "sku"    : "20223", "ticket" : { "price" : 25 , "product_date" : "20-02-2019" }}
{ "name"   : "pants", "sku"    : "20224", "ticket" : { "price" : 56 ,"product_date" : "10-02-2019" }}
{ "name"   : "shirt", "sku"    : "20225", "ticket" : { "price" : 13 , "product_date" : "20-02-2019" }}
{ "name"   : "dress-pinky", "sku"   : "20226", "ticket" : { "price" : 189.78 , "product_date" : "20-02-2019" }}
```
il faut creer des jeux.sh pour chaque topic 
pour clients_info

```
$ nano jeu1.sh

```
et vous tappez ce code :
```
#!/bin/bash

function main {
   echo "Copy de fichier "
   for client in ./client*.json; do
        
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic clients_info < ./client$.json
     
done
}

main
```
* meme chose pour le topic de product :
```
$ nano jeu2.sh
```
et taper ce code

```
#!/bin/bash

function main {
   echo "Copy de fichier "
   for product in ./product*.json; do
  
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic products < ./product$.json
 done
}

main
```
afin de tester votre fichier de json vous devez juste faire :

```
$ sh jeu*.sh
Copy de fichier
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

```

* Pour voir le resultat vous pouvez voir dans le site http://10.13.237.13:9021/management/clusters

pour Clients_info
![alt tag](pic1.png)

pour Products
![alt tag](pic2.png)

### Creation d'un nouveau Stream :

Il faut aller premierment au KSQL Bash :

```
$ docker-compose exec ksql-cli ksql http://ksql-server:8088 
```

Creaton d'un nouveau Stream du topic `clients_info` 


```
ksql> CREATE STREAM ksql_clientsinfo (name string, sku bigint, shipTo struct< name string, address string>) WITH (KAFKA_TOPIC='clients_info', VALUE_FORMAT='JSON');

 Message
----------------
 Stream created

```

Pour voir tous  les info des clients :

```
ksql> SELECT * FROM ksql_clientsinfo ;

1553104904755 | null | John Smith | 20223 | {NAME=Jane Smith, ADDRESS=123 Maple Street}
1553104908552 | null | Lele Pos | 20225 | {NAME=Amelie, ADDRESS=18 jane}
1553104912303 | null | Safaa Zaoui | 20227 | {NAME=Safaa Zaoui, ADDRESS=196 wellington st, toronto}
1553104897173 | null | Lele Pos | 20225 | {NAME=Amelie, ADDRESS=18 jane}
1553104918027 | null | Frank lil | 20224 | {NAME=Jessi, ADDRESS=154 Webster}
1553104869991 | null | Amelie Dubois | 20228 | {NAME=Amelie Dubois, ADDRESS=65 gorgia victoria street }

```

ALors pour Decrire ce stream :

```
ksql> DESCRIBE ksql_clientsinfo;

 Field   | Type
-----------------------------------------------------------------
 ROWTIME | BIGINT           (system)
 ROWKEY  | VARCHAR(STRING)  (system)
 NAME    | VARCHAR(STRING)
 SKU     | BIGINT
 SHIPTO  | STRUCT<NAME VARCHAR(STRING), ADDRESS VARCHAR(STRING)>
-----------------------------------------------------------------

```



#### Créer une table d'apres le topic products :

```
ksql> CREATE TABLE ksql_products (name STRING, sku bigint ,ticket STRUCT< price BIGINT, product_date BIGINT>) WITH  (KAFKA_TOPIC='products',VALUE_FORMAT='JSON', KEY='sku');
 
  Message
---------------
 Table created
---------------

```
Pour voir tous les infos de cette table :

```
ksql> SELECT * FROM ksql_products;
```


Pour faire la jointure entre le Stream ``` ksql_clientsinfo```et La table ``` ksql_products``` :
```
SELECT * FROM ksql_products PR \
         LEFT OUTER JOIN \
         ksql_clientsinfo CI \
         ON  PR.sku = CI.sku;

```

