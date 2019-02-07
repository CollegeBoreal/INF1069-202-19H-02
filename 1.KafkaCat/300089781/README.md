$ docker-compose up -d
$ docker-compose ps
$ docker-compose exec kafka bash
root.../# kafka-topics --zookeeper --zookeeper:32181 --topic repas --create --partitions 3 --replication-factor 1

