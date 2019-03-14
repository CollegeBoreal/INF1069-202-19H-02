#!/bin/bash

function main {
   echo "Client "
   for client in ./client*.json; do
    for ((i=1; i<=3 ;i++)); do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic client < ./client$i.json
    done
done
}

main
