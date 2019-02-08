# Kafka Log Files Admin


## Log File Location

```
root@kafka:/# cat /etc/kafka/kafka.properties  | grep data
```

  log.dirs=/var/lib/kafka/data
  
  
## Create a test topic `first_topic``

```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic first_topic \
                           --create --partitions 3 --replication-factor 1
```

  Created topic "first_topic"

## Listing first_topic files

```
root@kafka:/# ls -l /var/lib/kafka/data/first_topic-0/
```

```
  total 4
  -rw-r--r-- 1 root root 10485760 Feb  8 16:57 00000000000000000000.index
  -rw-r--r-- 1 root root        0 Feb  8 16:57 00000000000000000000.log
  -rw-r--r-- 1 root root 10485756 Feb  8 16:57 00000000000000000000.timeindex
  -rw-r--r-- 1 root root        8 Feb  8 16:57 leader-epoch-checkpoint
```
