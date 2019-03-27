
KAFKACAT

Mon environnement 
1.	Creation de mon repertoire
````
bouchichi@Doha MINGW64 ~/Developer/INF1069-202-19H-02/1.KafkaCat
$ mkdir 300107710 
$ cd 300107710
bouchichi@Doha MINGW64 ~/Developer/INF1069-202-19H-02/1.KafkaCat/300107710
````
2.	Récupérer le fichier docker-compose.yml de D.DEMO
````
bouchichi@Doha MINGW64 ~/Developer/INF1069-202-19H-02/1.KafkaCat/300107710

$ cp ../../D.Demo/docker-compose.yml .
````
3.	Modification du fichier:
````
bouchichi@Doha MINGW64 ~/Developer/INF1069-202-19H-02/1.KafkaCat/300107710

$ nano docker-compose.yml
````
4.	Execution

````
$ docker-compose up -d 
$ docker network ls
$ docker run --tty --network 300107710_default confluentinc/cp-kafkacat kafkacat -b kafka:29092 -L
````
5. Decrire mon environnement
Création de de deux topics:
-	client
-	commande

o  Création des topics
````
$ winpty docker-compose exec kafka bash
root@kafka:/#

    # kafka-topics --zookeeper zookeeper:32181 --topic client --create --partitions 3 --replication-factor 1

Created topic "client".


root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic commande --create --partitions 3 --replication-factor 1

Created topic "commande".
````

o  Création du jeu d'essaie

````
$ nano client.json
````
````
{"client_id":"1001", "client_name":"Jack", "Client_address":{"City":"Toronto", "Street_name":"Church St", "Street_num": 12, "Unit":805}}
{"client_id":"1002", "client_name":"Paul", "Client_address":{"City":"Toronto", "Street_name":"Yonge St", "Street_num":150, "Unit":615}}
{"client_id":"1003", "client_name":"Alfred", "Client_address":{"City":"Toronto", "Street_name":"Danforth Ave", "Street_num":150, "Unit":608}}
{"client_id":"1004", "client_name":"Sandra", "Client_address":{"City":"Toronto", "Street_name":"Spadina Ave", "Street_num":305, "Unit":903}}
{"client_id":"1005", "client_name":"Merinda", "Client_address":{"City":"Toronto", "Street_name":"Yonge St", "Street_num":450, "Unit":702}}
{"client_id":"1006", "client_name":"Jane", "Client_address":{"City":"Toronto", "Street_name":"Bay St", "Street_num":1250, "Unit":615}}

````
 
````
$ nano commande.json
````
````
{"client_id":"1001", "Commande":{"Plat_name":"Tagine", "Quantite":1, "Paiement":"Espèce"}}
{"client_id":"1002", "Commande":{"Plat_name":"Couscous", "Quantité":1, "Paiement":"Visa"}}
{"client_id":"1003", "Commande":{"Plat_name":"Pastilla", "Quantité":1, "Paiement":"Master"}}
{"client_id":"1004", "Commande":{"Plat_name":"Zaalook", "Quantité":1, "Paiement":"Visa"}}
{"client_id":"1005", "Commande":{"Plat_name":"Poulet", "Quantité":1, "Paiement":"Espèce"}}
{"client_id":"1006", "Commande":{"Plat_name":"Poisson", "Quantité":1, "Paiement":"Visa"}}

````

 o  Création du shell script client

````
$ nanao client.sh
````
````

#!/bin/bash

function main {
   echo "Copy de fichier"
   for client in client*.json
   do
     docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic client <  ./$client
   done
}

main

````

 o   Création du shell script commande
 
 ````
$ nanao commande.sh
````

````
#!/bin/bash

function main {
   echo "Copy de fichier"
   for commande in commande*.json
   do
     docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic commande <  ./$commande
   done
}

main

````

6.1  Création de stream commande en KSQL

````
ksql> CREATE STREAM commande \
      (client_id INTEGER, \
       Commande STRUCT< \
       Plat_name STRING,\
       Quantite INTEGER,\
      Paiement STRING>)\
    WITH (KAFKA_TOPIC='commande', VALUE_FORMAT='JSON');
````


````
 Message
----------------
 Stream created
----------------

````

6.1  Création de la table client en KSQL
````
ksql> CREATE TABLE client \
      (client_id INTEGER, \
       client_name STRING, \
       Client_address STRUCT< \
       City STRING,\
       Street_name STRING,\
       Street_num INTEGER,\
      Unit INTEGER >)\
    WITH (KAFKA_TOPIC=' client ', VALUE_FORMAT='JSON', KEY=' client_id ');
````

````
 Message
----------------
 table created
----------------
````

````
bouchichi@Doha MINGW64docker ~/Developer/INF1069-202-19H-02/1.KafkaCat/300107710 (master)
$ sh Commande.sh
Hello world
>>>>>>>>>>>>>>>>
````
[Alt-tag](jeu_commande.png)


````
bouchichi@Doha MINGW64 ~/Developer/INF1069-202-19H-02/1.KafkaCat/300107710 (master)
$ sh client.sh
Copy de fichier
>>>>>>>>>>>>>>>>
````

[Alt-tag](jeu_commande.png)



 
