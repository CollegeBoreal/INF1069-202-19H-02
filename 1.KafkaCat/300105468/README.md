
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
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic reggae_music --create --partitions 3 --replication-factor 1
Created topic "reggae_music"
```
```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic Clients --create --partitions 5 --replication-factor 1
Created topic "Clients"
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

