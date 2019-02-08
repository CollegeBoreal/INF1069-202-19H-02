# Kafka Admin


```
# cat /etc/kafka/kafka.properties  | grep data
```

  log.dirs=/var/lib/kafka/data

```
# ls -l /var/lib/kafka/data/__consumer_offsets-0
```

  total 4548
  -rw-r--r-- 1 root root 10485760 Feb  8 16:40 00000000000000000000.index
  -rw-r--r-- 1 root root  4618596 Feb  8 16:42 00000000000000000000.log
  -rw-r--r-- 1 root root 10485756 Feb  8 16:40 00000000000000000000.timeindex
  -rw-r--r-- 1 root root        8 Feb  6 19:12 leader-epoch-checkpoint
