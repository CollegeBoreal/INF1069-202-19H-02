
# KafkaCat 

### :one: Créer son environnement dans son repertoire :

Copier le fichier de docker-compose.yml d'apres le repertoire D.Demo.

```
$ cp ../../D.Demo/docker-compose.yml  . 
```

Enlever les applications de musique

```
$ nano docker-compose.yml
```

Rajouter kafkacat.
```
kafkacat:
    image: confluentinc/cp-kafkacat 
    hostname: kafkacat
    container_name: kafkacat
    depends_on:
      - kafka
      
```
