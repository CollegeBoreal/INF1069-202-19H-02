
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
Il s'agit des cours de change de la banque du canada et sera composé de deux topics:
-	Devise
-	Taux de change

o  Création des topics
````
$ winpty docker-compose exec kafka bash
root@kafka:/#

    # kafka-topics --zookeeper zookeeper:32181 --topic taux_de_change --create --partitions 3 --replication-factor 1

Created topic "taux_de_change".


root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic devise --create --partitions 3 --replication-factor 1

Created topic "devise".
````

6.  Création des Streams

6.1  Création de devise
````
file1.json, file2.json, file3.json, …. File6.json
{ "FXAUDCAD":{"label":"AUD/CAD","description":"Taux de change quotidien du dollar australien en dollars canadiens"} }
{ "FXCHFCAD":{"label":"CHF/CAD","description":"Taux de change quotidien du franc suisse en dollars canadiens"} }
{ "FXCNYCAD":{"label":"CNY/CAD","description":"Taux de change quotidien du renminbi chinois en dollars canadiens"} }
{ "FXEURCAD":{"label":"EUR/CAD","description":"Taux de change quotidien de l’euro en dollars canadiens"} }
{ "FXGBPCAD":{"label":"GBP/CAD","description":"Taux de change quotidien de la livre sterling en dollars canadiens"} }
{ "FXUSDCAD":{"label":"USD/CAD","description":"Taux de change quotidien du dollar américain en dollars canadiens"} }
````




````
ksql> CREATE STREAM devise \
      (FXCHFCAD STRING, \
      FXCNYCAD STRING, \
      FXEURCAD STRING, \
      FXGBPCAD STRING,\
      FXUSDCAD STRING) \
WITH (KAFKA_TOPIC='devise', VALUE_FORMAT='JSON');

 Message
----------------
 Stream created
----------------
````

6.2 Création de taux_de_change 
````
fx1.json, fx2.json, fx3.json, …   fx6.json

{ "d":"2017-01-03", "FXAUDCAD":{"v":0.9702}, "FXCNYCAD":{"v":0.1930}, "FXEURCAD":{"v":1.3973}, "FXJPYCAD":{"v":0.01140}, "FXMXNCAD":{"v":0.06439}, "FXNZDCAD":{"v":0.9295}, "FXSEKCAD":{"v":0.1465}, "FXCHFCAD":{"v":1.3064}, "FXGBPCAD":{"v":1.6459}, "FXUSDCAD":{"v":1.3435} }

{ "d":"2017-01-04","FXAUDCAD":{"v":0.9678}, "FXCNYCAD":{"v":0.1920}, "FXEURCAD":{"v":1.3930}, "FXJPYCAD":{"v":0.01134}, "FXMXNCAD":{"v":0.06242}, "FXNZDCAD":{"v":0.9251}, "FXSEKCAD":{"v":0.1460}, "FXCHFCAD":{"v":1.3005}, "FXGBPCAD":{"v":1.6377}, "FXUSDCAD":{"v":1.3315} }

{ "d":"2017-01-05","FXAUDCAD":{"v":0.9708}, "FXCNYCAD":{"v":0.1922}, "FXEURCAD":{"v":1.4008}, "FXJPYCAD":{"v":0.01145}, "FXMXNCAD":{"v":0.06195}, "FXNZDCAD":{"v":0.9285}, "FXSEKCAD":{"v":0.1468}, "FXCHFCAD":{"v":1.3083}, "FXGBPCAD":{"v":1.6400}, "FXUSDCAD":{"v":1.3244} }

{ "d":"2017-01-06","FXAUDCAD":{"v":0.9668}, "FXCNYCAD":{"v":0.1911}, "FXEURCAD":{"v":1.3953}, "FXJPYCAD":{"v":0.01133}, "FXMXNCAD":{"v":0.06213}, "FXNZDCAD":{"v":0.9230}, "FXSEKCAD":{"v":0.1461}, "FXCHFCAD":{"v":1.3020}, "FXGBPCAD":{"v":1.6275}, "FXUSDCAD":{"v":1.3214} }


{ "d":"2017-01-07","FXAUDCAD":{"v":0.9728}, "FXCNYCAD":{"v":0.1907}, "FXEURCAD":{"v":1.3967}, "FXJPYCAD":{"v":0.01138}, "FXMXNCAD":{"v":0.06202}, "FXNZDCAD":{"v":0.9276}, "FXSEKCAD":{"v":0.1460}, "FXCHFCAD":{"v":1.3020}, "FXGBPCAD":{"v":1.6084}, "FXUSDCAD":{"v":1.3240} }

{ "d":"2017-01-08","FXAUDCAD":{"v":0.9732}, "FXCNYCAD":{"v":0.1909}, "FXEURCAD":{"v":1.3970}, "FXJPYCAD":{"v":0.01141}, "FXMXNCAD":{"v":0.06113}, "FXNZDCAD":{"v":0.9236}, "FXSEKCAD":{"v":0.1458}, "FXCHFCAD":{"v":1.3012}, "FXGBPCAD":{"v":1.6075}, "FXUSDCAD":{"v":1.3213} }
````
