#!/bin/bash

function main {
   echo "Copy de fichier "
   for demandeur in ./demandeur*.json; do
    for ((i=1; i<=4 ;i++)); do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic plats < ./demandeur$i.json
    done
done
}

main
