#!/bin/bash

function main {
   echo "Copy de fichier "
   for client in ./client*.json; do
      (i=1; i++ ;i++); do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic clients_info < ./client$i.json
    done
done
}

main
