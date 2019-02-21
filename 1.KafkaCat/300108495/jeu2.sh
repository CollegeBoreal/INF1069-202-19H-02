#!/bin/bash

function main {
   echo "Copy de fichier "
   for product in ./*.json; do
    for ((i>=0; i++)); do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic clients_info < ./product$i.json
    done
done
}

main
