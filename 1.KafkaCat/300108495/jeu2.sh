#!/bin/bash

function main {
   echo "Copy de fichier "
   for product in ./product*.json; do
    for ((i=1; i<=10 ;i++)); do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic products < ./product$i.json
    done
done
}

main
