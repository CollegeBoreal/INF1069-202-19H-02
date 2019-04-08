

### ⭕️ PROJECT KAFKA_KSQL

## 1. CRÉER SON ENVIRONNEMENT DANS UN REPERTOIRE:
  ```  cp ../../D.Demo/docker-compose.yml  .``` 
 
 ##  2. Enlever les applications de la vente
  
  ```vi docker-compose.yml```
  
## 3. Avant de l'executer dans 1.Kafkacat/ID vous devez supprimer votre environnemnet dans D.Demo

 ```
$ cd Developer/INF1069-202-19H-02/1.KafkaCat/300093216
$ Owner@LAPTOP-D4NC7D4D MINGW64 ~/Developer/INF1069-202-19H-02/1.KafkaCat/300093216 (master)
$ docker-compose stop 
$ docker-compose rm 
```
## A . Executez votre environnement dans 1.KafkaCat/ID :

```
$ cd ../../1.KafkaCat/300093216
$ docker-compose up -d 
```
## 1. Connaitre le nom de switch Docker de KafkaCat
```
docker network ls
```
## 2. Faire la liste de tout l'environnment
```
docker run --tty --network 300093216_default confluentinc/cp-kafkacat kafkacat -b kafka:29092 -L
```
## 3. Accedez a votre bash de Kafaka
```
docker-compose exec kafka bash 
```

## 4. Création des topics
```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic produits --create --partitions 5 --replication-factor 1
Created topic "produits"
```

```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic ventes--create --partitions 5 --replication-factor 1
Created topic "ventes"
```

### B. Creation de fichier JSON :

```  
 nano produit.json 
```
## Ajouter un code 
```
{"code":0001, "produit":1, "nom":"church", "style":{"couleur":"violet", "materiel":"cuir"}}

```
en suite vous pouvez ajouter les autres foichiers de produit$.json avec un des lignes ci-dessous:

```
{"code":0001, "produit":1, "nom":"church", "style":{"couleur":"violet", "materiel":"cuir"}}
{"code":0002, "produit":2, "nom":"louboutin", "style":{"couleur":"noir", "materiel":"suede"}}
{"code":0003, "produit":3, "nom":"john lobb", "style":{"couleur":"vert", "materiel":"crocodile"}}
{"code":0004, "produit":4, "nom":"prada", "style":{"couleur":"gold", "materiel":"lezard"}}
{"code":0005, "produit":5, "nom":"gucci", "style":{"couleur":"rouge", "materiel":"vernis"}}
```
et aussi la même chose pour le fichier de vente$.json

```
{"code":0001, "client":"nathan", "type" : { "produit":1, "quantite":2, "prix":50}}
{"code":0002, "client":"jadon", "type" : { "produit":2, "quantite":5, "prix":70}}
{"code":0003, "client":"brison", "type" : {"produit":3, "quantite":1, "prix":60}}
{"code":0004, "client":"shiloh", "type" : {"produit":4, "quantite":2, "prix":40}}
{"code":0005, "client":"bj", "type" : {"produit":5, "quantite":3, "prix":80}}

```

il faut creer des jeux.sh pour chaque topic pour produits

```
 nano jeu1.sh
```
Vous allez tapper en suite ce code:

```
#!/bin/bash

function main {
   echo "Copy de fichier"
   for produit in produit*.json
   do
     docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic produits <  ./$produit
   done
}

main

```

 Faire la même chose pour le topic vente:
 
```
#!/bin/bash

function main {
   echo "Copy de fichier"
   for vente in vente*.json
   do
     docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic ventes <  ./$vente
   done
}

main

```
 
 Pour tester votre fichier de json vous devez juste faire:
 
 ``` 
Owner@LAPTOP-D4NC7D4D MINGW64 ~/Developer/INF1069-202-19H-02/1.KafkaCat/300093216 (master)
$ sh jeu1.sh
Copy de fichier
>>>>>>>>>>
 ``` 
 
 ## Pour voir le resultat vous pouvez voir dans le site http://10.13.237.15:9021/management/clusters
 
 ##  ♦ PRODUITS 
 
 ![alt tag](image1.png)  
 
 
 ##  ♦ VENTES

![alt tag](Image2.png)

## 🔎 Création d'un nouveau Stream:

Premièrement il faut aller premierment au KSQL Bash :

```  
$ docker-compose exec ksql-cli ksql http://ksql-server:8088

``` 

## 1. Creaton d'un nouveau Stream du topic produits

```  
ksql> CREATE STREAM ksql_produits (PRODUIT STRING, NOM STRING, STYLE STRING, COULEUR STRING, MATERIEL STRING) WITH (KAFKA_TOPIC='produits', VALUE_FORMAT='JSON');

 Message
----------------
 Stream created
----------------

 
``` 
## Pour voir tous les info des produits :

``` 
ksql> SELECT * FROM ksql_produits ;

1554745324372 | null | 1 | church | {"materiel":"cuir","couleur":"violet"} | null | null
1554310451404 | null | 1 | church | {"materiel":"cuir","couleur":"violet"} | null | null
1554745336742 | null | 5 | gucci | {"materiel":"vernis","couleur":"rouge"} | null | null
1554310454698 | null | 2 | louboutin | {"materiel":"suede","couleur":"noir"} | null | null
1554745410350 | null | 1 | church | {"materiel":"cuir","couleur":"violet"} | null | null
1554310463431 | null | 5 | gucci | {"materiel":"vernis","couleur":"rouge"} | null | null
1554746290154 | null | 1 | church | {"materiel":"cuir","couleur":"violet"} | null | null
1554745327480 | null | 2 | louboutin | {"materiel":"suede","couleur":"noir"} | null | null
1554746293152 | null | 2 | louboutin | {"materiel":"suede","couleur":"noir"} | null | null
1554746301561 | null | 5 | gucci | {"materiel":"vernis","couleur":"rouge"} | null | null
1554745330441 | null | 3 | john lobb | {"materiel":"crocodile","couleur":"vert"} | null | null
1554745333685 | null | 4 | prada | {"materiel":"lezard","couleur":"gold"} | null | null

``` 

## pour voir les streams

``` 
ksql> show streams ;
 Stream Name   | Kafka Topic | Format
--------------------------------------
 KSQL_PRODUITS | produits    | JSON
--------------------------------------

``` 
## Pour Décrire le stream

``` 
ksql> DESCRIBE ksql_produits ;

Name                 : KSQL_PRODUITS
 Field    | Type
--------------------------------------
 ROWTIME  | BIGINT           (system)
 ROWKEY   | VARCHAR(STRING)  (system)
 PRODUIT  | VARCHAR(STRING)
 NOM      | VARCHAR(STRING)
 STYLE    | VARCHAR(STRING)
 COULEUR  | VARCHAR(STRING)
 MATERIEL | VARCHAR(STRING)
--------------------------------------
For runtime statistics and query details run: DESCRIBE EXTENDED <Stream,Table>;

``` 
## Créer une table d'apres le topic ventes :

Tout d'abord il s'agit de créer un stream qui s'appelle ``` ksql_ventes``` afin de terminer toutes les colonnes.
``` 
ksql> CREATE STREAM ksql_ventes ( CODE BIGINT , CLIENT STRING , PRODUIT BIGINT , PRIX BIGINT ) WITH  (KAFKA_TOPIC='ventes',VALUE_FORMAT='JSON');

 Message
----------------
 Stream created
----------------
``` 

Pour voir tous les informations de cette table :

``` 
ksql> SELECT * FROM ksql_ventes;

1554310631762 | null | null | null | 4 | null
1554310622276 | null | null | null | 1 | null
1554310625343 | null | null | null | 2 | null
1554310628710 | null | null | null | 3 | null
1554310635446 | null | null | null | 5 | null

``` 
 Description 
 
 
``` 
 ksql> DESCRIBE ksql_ventes ;

Name                 : KSQL_VENTES
 Field   | Type
-------------------------------------
 ROWTIME | BIGINT           (system)
 ROWKEY  | VARCHAR(STRING)  (system)
 CODE    | BIGINT
 CLIENT  | VARCHAR(STRING)
 PRODUIT | BIGINT
 PRIX    | BIGINT
-------------------------------------

``` 

Création de Stream ``` ventes_with_key```  avec un nouveau topic ``` ventes-with-key ``` partition par ID:
``` 
ksql> CREATE STREAM ksql_ventes_with_key \
       WITH (VALUE_FORMAT='AVRO', KAFKA_TOPIC='ventes-with-key') \
       AS SELECT CLIENT , CAST( AS BIGINT) AS CODE, PRODUIT, QUANTITE, PRIX \
       FROM ksql_ventes PARTITION BY CODE ;  
  ``` 
  
Et finalement on crée la table d'après le topic  ``` ventes-with-key ``` :

  ``` 
ksql> CREATE TABLE ksql_ventes_table \
       WITH (VALUE_FORMAT='AVRO',  \
       KAFKA_TOPIC='chansons-with-key', KEY='ID') ;
  ``` 
Pour voir toutes les informations de cette table:

 ``` 
ksql> SELECT * FROM ksql_ventes_table ;
 ``` 
## Pour faire la joincture entre le Stream ksql_produits et la table ksql_ventes_table :

SELECT * FROM ksql_produis CI  \
         LEFT OUTER JOIN \
         ksql_ventes_table PR \
         ON  PR.ID = CI.ID ;
