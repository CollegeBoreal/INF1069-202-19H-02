
# 🔎KAFKACAT 
## 📍 CRÉER SON ENVIRONNEMENT DANS UN REPERTOIRE:
## 1. Copier le fichier de docker-compose.yml d'apres le repertoire D.Demo.
```
$ cp ../../D.Demo/docker-compose.yml  . 

```
## 2. Enlever les applications de musique
```
$ nano docker-compose.yml
```
## 3. Avant de l'executer dans 1.Kafkacat/ID vous devez supprimer votre environnemnet dans D.Demo
```
$ cd ../../D.Demo
$ docker-compose stop 
$ docker-compose rm 
```
## 📍 Executez votre environnement dans 1.KafkaCat/ID :
```
$ cd ../../1.KafkaCat/ID (ex:300105468) 
$ docker-compose up -d 
```
## 1. Connaitre le nom de switch Docker de KafkaCat

```
$ docker network ls
```
## 2. Faire la liste de tout l'environnment
```
$ docker run --tty --network 300105468_default confluentinc/cp-kafkacat kafkacat -b kafka:29092 -L
```

### 3. Accedez a votre bash de Kafaka

```
$ docker-compose exec kafka bash 
```
### 4. Création des topics
```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic chanteurs --create --partitions 3 --replication-factor 1
Created topic "chanteurs"
```
```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic chansons --create --partitions 5 --replication-factor 1
Created topic "chansons"
```
```
$ docker run --interactive \
           --network 300105468_default \
           confluentinc/cp-kafkacat \
            kafkacat -b kafka:29092 \
                    -t my_topic \
                    -K: \
                    -P <<EO
{"Date":"2019-01-08","Open":7.53,"High":7.6,"Low":7.35,"Close":7.41,"Adj Close":7.41,"Volume":3960900}
EOF
```
## 📍 Creation de fichier JSON :

## 1. Vous devez revenir a votre path Develper/INF1069../1.KafkaCat/ID et vous creez un fichier de json
```
$ nano chanson.json 
```
## . Ajouter un code
```
 { "duration":"4 minutes", "id":"140gh", { "frenquence":"500 hrz", "artist":"FKJ"}}
```
en suite vous pouvez ajouter les autres foichiers de chanson$.json avec un des lignes ci-dessous: 
```
{ "duration":"2.5minutes", "id":"180gh", "frenquence":"400 hrz", "artist":"RMB"}
{ "duration":" 3 minutes", "id":"190gh", "frenquence":"350 hrz", "artist":"dont"}
{ "duration":" 3 minutes", "id":"190gh", "frenquence":"350 hrz", "artist":"dont"}
{ "duration":"4 minutes", "id":"140gh", "frenquence":"500 hrz", "artist":"FKJ"}
```
et aussi la même chose pour le fichier de chanteur$.json
```
{ "platform":"spotify", "id":"140gh", "title":"Lying Together", "artist":"FKJ", "album":"Casse T"}
{ "platform":"spotify", "id":"180gh", "title":"dancing Together", "artist":"RMB", "album":"Playing "}
{ "platform":"spotify", "id":"190gh", "title":"Reaggae", "artist":"Lion", "album":"dont"}
{ "platform":"spotify", "id":"200gh", "title":"Nil", "artist":"Formuler", "album":"Labe"}
```
il faut creer des jeux.sh pour chaque topic pour clients_info

``` 
$ nano jeu1.sh
```

Vous allez tapper en suite ce code:


```
#!/bin/bash

function main {
   echo "Copy de fichier"
   for chanteur in chanteur*.json
   do
     docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic chanteurs <  ./$chanteur
   done
}

main
```

## * Faire la même chose pour le topic chanson:
```
#!/bin/bash

function main {
   echo "Copy de fichier"
   for chanson in chanson*.json
   do
     docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic chansons <  ./$chanson
   done
}

main
```
Pour tester votre fichier de json vous devez juste faire:
```
$ sh jeu*.sh
Copy de fichier
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
```
## * Pour voir le resultat vous pouvez voir dans le site http://10.13.237.14:9021/management/clusters

## 📍 Création d'un nouveau Stream:
Premièrement il faut aller premierment au KSQL Bash :
```
$ docker-compose exec ksql-cli ksql http://ksql-server:8088
```
## Creaton d'un nouveau Stream du topic chanteurs
```
ksql> CREATE STREAM ksql_chanteurs (platform string, id string, title string, artist string, album string) WITH (KAFKA_TOPIC='chanteurs', VALUE_FORMAT='JSON');
 Message
----------------
 Stream created
----------------
```
## Pour voir tous les info des chanteurs :

```
ksql> SELECT * FROM ksql_chanteurs ;
1553191380055 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553191381966 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553191383784 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553191387396 | null | spotify | 200gh | Nil | Formuler | La
be
1553191392820 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553191394658 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553191396526 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553191426288 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553191380055 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553194838698 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553194838725 | null | spotify | 200gh | Nil | Formuler | La
be
1553191392820 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553194846274 | null | spotify | 200gh | Nil | Formuler | La
be
1553191398358 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553191426262 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553191380043 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553194877560 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553191380055 | null | spotify | 200gh | Nil | Formuler | La
be
1553191426289 | null | spotify | 200gh | Nil | Formuler | La
be
1553194879406 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553191385563 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553191428065 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553194957307 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553191392807 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553191392820 | null | spotify | 200gh | Nil | Formuler | La
be
1553194838725 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553194962834 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553191400155 | null | spotify | 200gh | Nil | Formuler | La
be
1553707061926 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553194877560 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553707061954 | null | spotify | 200gh | Nil | Formuler | La
be
1553709417450 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553194881249 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553191426289 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553194957295 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553709417478 | null | spotify | 200gh | Nil | Formuler | La
be
1553191429887 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553194957307 | null | spotify | 200gh | Nil | Formuler | La
be
1553191431765 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553709423125 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553194961008 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553191433653 | null | spotify | 200gh | Nil | Formuler | La
be
1553709426138 | null | spotify | 200gh | Nil | Formuler | La
be
1553194838724 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553707061954 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553711918180 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553194840625 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553707063817 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553194842463 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553711922099 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553707069641 | null | spotify | 200gh | Nil | Formuler | La
be
1553194844313 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553194877532 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553711925938 | null | spotify | 200gh | Nil | Formuler | La
be
1553709417477 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553194877560 | null | spotify | 200gh | Nil | Formuler | La
be
1553712016612 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553194883098 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553709419379 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553194884950 | null | spotify | 200gh | Nil | Formuler | La
be
1553712020669 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553709421232 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553194957307 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553712022655 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553711918168 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553194959136 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553712024503 | null | spotify | 200gh | Nil | Formuler | La
be
1553194964669 | null | spotify | 200gh | Nil | Formuler | La
be
1553712309460 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553711918181 | null | spotify | 200gh | Nil | Formuler | La
be
1553707061953 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553712016587 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553707065788 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553712309472 | null | spotify | 200gh | Nil | Formuler | La
be
1553712016613 | null | spotify | 200gh | Nil | Formuler | La
be
1553707067752 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553709417477 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553712313386 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553712309472 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553712875215 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553711918180 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553712311416 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553711920179 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553711923979 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553712315568 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553712881033 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553712016613 | null | spotify | 190gh | Reaggae | Lion | do
nt
1553712875203 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553712889622 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553712018483 | null | spotify | 140gh | Lying Together | FK
J | Casse T
1553712309471 | null | spotify | 180gh | dancing Together |
RMB | Playing
1553712875216 | null | spotify | 200gh | Nil | Formuler | La
be
1553712889635 | null | spotify | 200gh | Nil | Formuler | La
be
1553712882921 | null | spotify | 200gh | Nil | Formuler | La
be
1553712317422 | null | spotify | 200gh | Nil | Formuler | La
be
1553712893464 | null | spotify | 180gh | dancing Together | RMB | Playing
1553712875215 | null | spotify | 190gh | Reaggae | Lion | dont
1553712889634 | null | spotify | 190gh | Reaggae | Lion | dont
1553712877171 | null | spotify | 140gh | Lying Together | FKJ | Casse T
1553712895409 | null | spotify | 190gh | Reaggae | Lion | dont
1553712879045 | null | spotify | 180gh | dancing Together | RMB | Playing
1553712889634 | null | spotify | 180gh | dancing Together | RMB | Playing
1553712891592 | null | spotify | 140gh | Lying Together | FKJ | Casse T
1553712897346 | null | spotify | 200gh | Nil | Formuler | Labe
1553713115820 | null | spotify | 190gh | Reaggae | Lion | dont
1553713115820 | null | spotify | 180gh | dancing Together | RMB | Playing
1553713115794 | null | spotify | 140gh | Lying Together | FKJ | Casse T
1553713115821 | null | spotify | 200gh | Nil | Formuler | Labe
1553713118064 | null | spotify | 140gh | Lying Together | FKJ | Casse T
1553713119970 | null | spotify | 180gh | dancing Together | RMB | Playing
1553713121871 | null | spotify | 190gh | Reaggae | Lion | dont
1553713123881 | null | spotify | 200gh | Nil | Formuler | Labe
```
## pour voir les streams 
```
ksql> show streams ;

 Stream Name    | Kafka Topic | Format
---------------------------------------
 KSQL_CHANTEURS | chanteurs   | JSON
---------------------------------------
ksql>
```
## Créer une table d'apres le topic chansons :
```
ksql> CREATE TABLE ksql_chanson (duration bigint, id bigint ,frequence bigint, artist string) WITH  (KAFKA_TOPIC='chansons',VALUE_FORMAT='JSON');
```
Pour voir tous les infos de cette table :

```
ksql> SELECT * FROM ksql_chansons;
```
