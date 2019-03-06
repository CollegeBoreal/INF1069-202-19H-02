### Créer ton répertoire ...
```
$ cd Developper/INF1069...
$ cd 2. ...
$ mkdir 300089781
$ cd 300089781
```
### Acceder à KSQL bash
```
$ docker-compose exec ksql-cli ksql http://ksql-server:8088
```
### Pour la création d'un stream dans 'playevents'
```
ksql> CREATE STREAM ksql_playevents WITH (KAFKA_TOPIC='play-events', VALUE_FORMAT='AVRO');
```
### Pour décrire ce stream:
```
ksql> DESCRIBE ksql_playevents;
```

### Pour voir, par exemple, une musique qui dure au moins 30 secondes
```
ksql> SELECT * FROM ksql_playevents WHERE DURATION > 30000;
```
### Pour s'assurer que la commande soit continuel et n'arrete pas lorsque nous fermons la fenetre
```
ksql> CREATE STREAM ksql_playevents_min_duration AS SELECT * FROM ksql_playevents WHERE DURATION > 30000;
```
### Créer un stream 'songfeed'
```
ksql> CREATE STREAM ksql_songfeed WITH (KAFKA_TOPIC='song-feed', VALUE_FORMAT='AVRO');
```
### Selectionner les 5 partitions dans le 'song-feed'
```
ksql> SELECT * FROM ksql_songfeed limit 5;
```
### Ensuite, décrire ce stream pour voir ce qui lui est associé
```
ksql> DESCRIBE ksql_songfeed;
```
### Utiliser 'PARTITION BY' pour assigner une clé & utiliser la fonction 'CAST' pour changer le type de champs en string:
```
ksql> CREATE STREAM ksql_songfeedwithkey WITH (KAFKA_TOPIC='KSQL_SONGFEEDWITHKEY', VALUE_FORMAT='AVRO') AS SELECT CAST(ID AS STRING) AS ID, ALBUM, ARTIST, NAME, GENRE FROM ksql_songfeed PARTITION BY ID;
```
### Convertir 'TABLE' avec le champs 'ID' comme clé
```
ksql> CREATE TABLE ksql_songtable WITH (KAFKA_TOPIC='KSQL_SONGFEEDWITHKEY', VALUE_FORMAT='Avro', KEY='ID');
```
### Confirmer que le tout match:
```
ksql> SELECT * FROM ksql_songtable limit 5;
```
### 
```
ksql> CREATE STREAM ksql_songplays AS SELECT plays.SONG_ID AS ID, ALBUM, ARTIST, NAME, GENRE, DURATION, 1 AS KEYCOL FROM ksql_playevents_min_duration plays LEFT JOIN ksql_songtable songtable ON plays.SONG_ID = songtable.ID;

```

