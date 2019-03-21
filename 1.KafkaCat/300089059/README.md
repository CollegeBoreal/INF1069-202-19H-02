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

-Aller sur kafka bash

``` 
docker-compose exec kafka bash 
```
Pour aller sur ksql
```
$ docker-compose exec ksql-cli ksql http://8088
docker-compose exec ksql-cli ksql http://ksql-server:8088


```

-Creer les topics
``` 
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic services --create --partitions 3 --replication-factor 1
Created topic "services" 
```

``` 
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic clients --create --partitions 3 --replication-factor 1
Created topic "clients" 
```
Sortir de kafka pour changer les fichiers séparemment
```
nano services.json
nano clients.json
```
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
