#!/bin/bash

function main {
   echo "Copy de fichier "
   for product in ./product*.json; do
    for ((i=1; i<=4 ;i++)); do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic clients_info < ./product$i.json
    done
done
}

main
