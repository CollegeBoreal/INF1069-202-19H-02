KAFKACAT

Environement dans un repertoire

 -Récupérer le fichier docker-compose.yml 
 
 ``` 
 $ cp ../../D.Demo/docker-compose.yml .
 ```
 
 -Modifier le fichier
 
 ```
 $ nano docker-compose.yml
 ```
 

Supression de l environnemnet dans D.Demo
```
$ cd ../../D.Demo
$ docker-compose stop 
$ docker-compose rm 
 ```
 
 
 
ENVIRONEMENT

1-Cree le repertoire

```  
MINGW64 ~/Developer/INF1069-202-19H-02/1.KafkaCat
$ mkdir 300089059
$ cd 300089059
$ docker-compose up -d 
 ```
 

 
 -Executer
 
 ``` 
$ docker network ls
$ docker run --tty --network 300089059_default confluentinc/cp-kafkacat kafkacat -b kafka:29092 -L
```

-Aller sur kafka 

``` 
$ docker-compose exec kafka bash 
```
Pour aller sur ksql
```
$ docker-compose exec ksql-cli ksql http://ksql-server:8088

```

-Creer les topics
``` 
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic service --create --partitions 4 --replication-factor 1


Created topic "services" 
```

``` 
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic client --create --partitions 4 --replication-factor 1


Created topic "clients" 
```
Sortir de kafka pour changer les fichiers séparemment
```
$ nano service.json
$ nano clients.json
```
Cree jeu1.sh
``` 
$ nano jeu1.sh
```
Dans nano saisir ce code
```
#!/bin/bash

function main {
        echo "azerty"
for service in ./services*.json 
 do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic services < $service
done
}

main
```

Faire de meme pour jeu2.sh et mettre clients a la place de service

Pour entrer dans ksql:
``` 
docker-compose exec ksql-cli ksql http://ksql-server:8088 
```


Dans 1er terminal faire jeu sh.jeu1.sh et ouvrire un 2eme terminal pour tester :

```
$ sh jeu1.sh
Clients
>>>>>>>>>>>>
```
Idem pour service.


Voir le resultat sur http://10.13.237.12:9021


Création du nouveau Stream

Dans KSQP bash
```
docker-compose exec ksql-cli ksql http://ksql-server:8088
```
infos client
```
ksql> select * from services;
1553798862498 | null | grocery | on
1553798864496 | null | dog | off
1553798866695 | null | cleaning | on
1553798868922 | null | information | on
1553798871019 | null | localisation  | off
```
infos service
```
ksql> select * from clients;
1554315149067 | null | windows | {BIRTHDAY=1258611555, ADDRESS=1234 bay street, PHONE=416 123 4444}
1554315151001 | null | azerty | {BIRTHDAY=1189405155, ADDRESS=189 bay street, PHONE=416 443 6758}
1554315152930 | null | vaio | {BIRTHDAY=1096870755, ADDRESS=123 bay street, PHONE=416 553 9879}
1554315154864 | null | linux | {BIRTHDAY=1128406755, ADDRESS=1768 bay street, PHONE=416 883 3234}
1554315156772 | null | mint | {BIRTHDAY=1224829155, ADDRESS=154 bay street, PHONE=416 993 4487}
```
```
DESCRIBE clients;

Name                 : CLIENTS
 Field       | Type
---------------------------------------------------------------------------------------
 ROWTIME     | BIGINT           (system)
 ROWKEY      | VARCHAR(STRING)  (system)
 CLIENT      | VARCHAR(STRING)
 INFORMATION | STRUCT<BIRTHDAY BIGINT, ADDRESS VARCHAR(STRING), PHONE VARCHAR(STRING)>
```
```
ksql> DESCRIBE services;

Name                 : SERVICES
 Field   | Type
-------------------------------------
 ROWTIME | BIGINT           (system)
 ROWKEY  | VARCHAR(STRING)  (system)
 SERVICE | VARCHAR(STRING)
 STATUT  | VARCHAR(STRING)
-------------------------------------

```

Creer le nouveau Stream du topic CLIENTS
```
ksql> CREATE STREAM clients \
  (client VARCHAR, \
   information STRUCT < \
birthday bigint, address string , phone string > ) \
  WITH (KAFKA_TOPIC='clients', \
        VALUE_FORMAT='JSON');
```
Cree le stream du topic SERVICES
```
ksql> CREATE STREAM services \
  (service VARCHAR, \
  client VARCHAR, \
   statut VARCHAR) \
  WITH (KAFKA_TOPIC='services', \
        VALUE_FORMAT='JSON');
```
voir les streams
```
ksql> show streams ;
```
Si on veut voir les infos sur SERVICES
```
 ksql> select * from SERVICES;
 
```
Decrire le stream
```
describe SERVICES;
```
Creer un stream du topic ksql_clients avec une clé 
```
ksql> CREATE STREAM clients_with_key \
       WITH (VALUE_FORMAT='AVRO', KAFKA_TOPIC='clients-with-key') \
       AS SELECT client , information \
       FROM clients PARTITION BY client ;
```
Creer un stream du topic ksql_services ayant une clé 

```
ksql> CREATE STREAM services_with_key \
       WITH (VALUE_FORMAT='AVRO', KAFKA_TOPIC='services-with-key') \
       AS SELECT service, client , statut \
       FROM services PARTITION BY client ;
 ```

Creer une table 'service'
```
ksql>  CREATE TABLE services_table \
      WITH (VALUE_FORMAT='AVRO', \
  KAFKA_TOPIC='services-with-key', KEY='service');
```

Jointure du stream clients et la table services
```
ksql> select * from services_table s \
      left outer join \
      clients c \ 
      on c.client = s.client;
      ```




