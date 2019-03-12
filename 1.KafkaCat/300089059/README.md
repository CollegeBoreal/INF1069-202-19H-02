KAFKACAT

ENVIRONEMENT

1-Cree le repertoire

```  
MINGW64 ~/Developer/INF1069-202-19H-02/1.KafkaCat
$ mkdir 300089059
$ cd 300089059
 ```
 
 2-Récupérer le fichier docker-compose.yml 
 
 ``` $ cp ../../D.Demo/docker-compose.yml .```
 
 3-Modifier le fichier
 
 ``` $ nano docker-compose.yml ```
 
 4-Executer
 
 ``` 
$ docker-compose up -d 
$ docker network ls
$ docker run --tty --network 300089059_default confluentinc/cp-kafkacat kafkacat -b kafka:29092 -L
```

5-Aller sur kafka bash

``` 
$ docker-compose exec kafka bash 
```

6-Creer les topics
