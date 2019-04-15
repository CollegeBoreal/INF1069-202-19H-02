Creation d'un repertoire :
````
$ cd Developer/INF1069../2.Stream
$ mkdir 300107710
$ cd 300107710
````
Creation d'un nouveau Stream :

Il faut aller premierment au KSQL Bash :
````
$ docker-compose exec ksql-cli ksql http://ksql-server:8088 
````
Creaton d'un nouveau Stream du topic play-events
````
ksql> CREATE STREAM ksql_playevents WITH (KAFKA_TOPIC='play-events', VALUE_FORMAT='AVRO');
````
Pour voir tous les chansons jouées pendant au moins 30 secondes
````
ksql> SELECT * FROM ksql_playevents WHERE DURATION > 30000;
````
La requête ci-dessus n'est pas persistante - elle s'arrêtera si cet écran est fermé. 

Pour rendre la requête persistante et rester en cours d'exécution jusqu'à ce qu'elle se termine, donc il faut faire la commande suivante :
````
ksql> CREATE STREAM ksql_playevents_min_duration AS SELECT * FROM ksql_playevents WHERE DURATION > 30000;
````
ALors pour Decrire ce stream :
````
ksql> DESCRIBE ksql_playevents;
````
Creation d'une table utilisant le topic song-feed :

Créez un STREAM à partir du fil d'actualité Kafka song-feed :
````
ksql> CREATE STREAM ksql_songfeed WITH (KAFKA_TOPIC='song-feed', VALUE_FORMAT='AVRO');
ksql> SELECT * FROM ksql_songfeed limit 5;
````
ALors pour Decrire un stream :
````
ksql> DESCRIBE ksql_songfeed;
````
Utilisez la PARTITION BY pour affecter une clé et utilisez la fonction CAST pour changer le type de champ en String.
````
ksql> CREATE STREAM ksql_songfeedwithkey WITH (KAFKA_TOPIC='KSQL_SONGFEEDWITHKEY', VALUE_FORMAT='AVRO') AS SELECT CAST(ID AS STRING) AS ID, ALBUM, ARTIST, NAME, GENRE FROM ksql_songfeed PARTITION BY ID;

ksql> DESCRIBE ksql_songfeedwithkey;
````
Rejoignez les événements de jeu avec la table des chansons :

Creer une table d'apres le stream precedent :
````
ksql> CREATE STREAM ksql_songplays AS SELECT plays.SONG_ID AS ID, ALBUM, ARTIST, NAME, GENRE, DURATION, 1 AS KEYCOL FROM ksql_playevents_min_duration plays LEFT JOIN ksql_songtable songtable ON plays.SONG_ID = songtable.ID;
````
Créer les meilleurs classements musicaux :
````
ksql> CREATE TABLE ksql_songplaycounts AS SELECT ID, NAME, GENRE, KEYCOL, COUNT(*) AS COUNT FROM ksql_songplays GROUP BY ID, NAME, GENRE, KEYCOL;
````
Il serait également bon de voir les statistiques pour les 30 dernières secondes. Créez une autre requête, en ajoutant une clause WINDOW, qui indique le nombre d'événements de lecture pour toutes les chansons, par intervalles de 30 secondes.
````
ksql> CREATE TABLE ksql_songplaycounts30 AS SELECT ID, NAME, GENRE, KEYCOL, COUNT(*) AS COUNT FROM ksql_songplays WINDOW TUMBLING (size 30 seconds) GROUP BY ID, NAME, GENRE, KEYCOL;
````
Pour voir tous les infos de cette table :
````
ksql> SELECT * FROM ksql_songplaycounts30;
````
Pour convertir la table qu'on a cree a un stream :
````
ksql> CREATE STREAM ksql_songplaycountsstream WITH (KAFKA_TOPIC='song-feed', VALUE_FORMAT='AVRO');
````
Pour mettre ce stream global et pas de partition :
````
ksql> CREATE STREAM ksql_songplaycountsstream  AS SELECT * from ksql_songplaaycountsstream WHERE ROWTIME is not null PARTITION BY KEYCOL;
````
