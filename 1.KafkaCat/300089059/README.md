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
$docker-compose stop 
 docker-compose rm 
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
docker-compose exec kafka bash 
```
Pour aller sur ksql
```
$ docker-compose exec ksql-cli ksql http://ksql-server:8088

```

-Creer les topics
``` 
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic service --create --partitions 3 --replication-factor 1


Created topic "services" 
```

``` 
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic clients --create --partitions 3 --replication-factor 1


Created topic "clients" 
```
Sortir de kafka pour changer les fichiers séparemment
```
nano service.json
nano clients.json
```
Cree jeu1.sh
``` 
nano jeu1.sh
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

Entrer dans ksql:
``` 
docker-compose exec ksql-cli ksql http://ksql-server:8088 
```
Dans 1er terminal faire jeu sh.jeu1.sh et ouvrire un 2eme terminal pour tester :

```
sh jeu1.sh
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
Creer le nouveau Stream du topic CLIENTS
```
CREATE STREAM clients \
  (client VARCHAR, \
   information STRUCT < \
birthday bigint, address string , phone string > ) \
  WITH (KAFKA_TOPIC='clients', \
        VALUE_FORMAT='JSON');
```
Cree le stream du topic SERVICES
```
CREATE STREAM services \
  (service VARCHAR, \
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
 select * from SERVICES;
 
```
Decrire le stream
```
describe SERVICES;
```

Creer une table 'clients'
```
CREATE TABLE client \
      (client VARCHAR, \
       information STRUCT< \
	Birthday string address string , phone string >) \
    WITH (KAFKA_TOPIC='clients', \ 
	VALUE_FORMAT='JSON', KEY='client');
```







