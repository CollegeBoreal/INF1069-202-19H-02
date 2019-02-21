#!/bin/bash

function main {
   echo "Copy de fichier "
   for client in ./*.json; do
    for ((i>=0; i++)); do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic clients_info < ./client$i.json
    done
done
}

main
