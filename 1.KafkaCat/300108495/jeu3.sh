#!/bin/bash

function main {
   echo "Copy de fichier "
   for artist in ./artist*.json; do
    for ((i=1; i<=4 ;i++)); do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic artists < ./artist$i.json
    done
done
}

main
