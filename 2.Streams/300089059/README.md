 COMMANDES KSQL
 
 Faire repertoire
 
 ```
 cd Developper/INF1069etc...
 cd 2.etc...
 mkdir 300089059
 cd 300089059
 ```
 
 Creation d'un Stream
 
 Aller a KSQL bash
 
 ```docker-compose exec ksql-cli ksql http://ksql-server:8088```
 
 
 
 
 
 
 
CREATE STREAM ksql_playevents
```
ksql> CREATE STREAM ksql_playevents WITH (KAFKA_TOPIC='play-events', VALUE_FORMAT='AVRO');
```

Test de la duree
``` 
ksql> CREATE STREAM ksql_playevents_min_duration AS SELECT * FROM ksql_playevents WHERE DURATION > 30000;
```


DESCRIBE ksql_songfeed;

CREATE TABLE ksql_songtable WITH;
