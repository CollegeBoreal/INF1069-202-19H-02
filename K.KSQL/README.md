
# KSQL



Révision:


## Topics

```
ksql> SHOW TOPICS;
```

```
ksql> PRINT 'my-topic' FROM BEGINNING;
```

## Structure WITH

### Transformation de données WITH (VALUE_FORMAT)

- AVRO

- JSON
    * ( column TYPE, column TYPE, ... )
    * STRUCT

- CSV

### Origine de données WITH (KAFKA_TOPIC)


### Nom des stream-table et de Topics

Par Convention, Utiliser `_`dans les noms de Streams et Tables: Note: ( `-` ne marche pas)

Par Convention, Utiliser `-`dans les noms de Topics


## Create Stream WITH (KAFKA_TOPIC)


* [CREATE STREAM stream_name](https://docs.confluent.io/current/ksql/docs/developer-guide/syntax-reference.html#create-stream)

* [CREATE STREAM stream_name AS SELECT](https://docs.confluent.io/current/ksql/docs/developer-guide/syntax-reference.html#create-stream-as-select)

* Create `Stream-Table`Join from Select

```
ksql> CREATE STREAM enriched_payments AS
           SELECT payment_id, u.country, total
           FROM payments_stream p
           LEFT JOIN users_table u
           ON p.user_id = u.user_id;
```

## Create Table

* [CREATE TABLE table_name](https://docs.confluent.io/current/ksql/docs/developer-guide/syntax-reference.html#create-table)

* [CREATE TABLE table_name AS SELECT](https://docs.confluent.io/current/ksql/docs/developer-guide/syntax-reference.html#create-table-as-select)


---


## Reference:

https://docs.confluent.io/current/ksql/docs/developer-guide/syntax-reference.html

https://docs.confluent.io/current/ksql/docs/troubleshoot-ksql.html

[KSQL shows no data for a query against TABLE if the source messages are not keyed.](https://github.com/confluentinc/ksql/issues/1405)



## Lecture:


[KSQL – The Open Source SQL Streaming Engine for Apache Kafka by Kai Wähner](https://www.youtube.com/watch?v=nA-ZKsXNJCQ)

[Distributed stream processing for everyone with KSQL by Michael Noll](./big_data_fast_data_easy_data_-_distributed_stream_processing_for_everyone_with_ksql_-_michael_noll_-_berlin_buzzwords_2018.pdf)
