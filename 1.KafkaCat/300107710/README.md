
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
5.	
o  Decrire mon environnement
Il s,agit des cours de change de la banque du canada et sera composé de deux topics 
-	Devise
-	Taux de change

o  Création des topics
````
$ winpty docker-compose exec kafka bash
root@kafka:/#

    # kafka-topics --zookeeper zookeeper:32181 --topic taux_de_change --create \
    --partitions 3 --replication-factor 1

Created topic "taux_de_change".

root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic devise --create \               
              --partitions 3 --replication-factor 1

Created topic "devise".
````
