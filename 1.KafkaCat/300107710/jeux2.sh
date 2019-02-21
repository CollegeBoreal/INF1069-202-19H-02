#!/bin/bash

function main {
   echo 'Hello world'
   for filename in ./fx*.json; do
     for ((i=0; i<=6; i++)); do
           docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic taux_de_change < ./fx$i.json
    done
done
}

main
