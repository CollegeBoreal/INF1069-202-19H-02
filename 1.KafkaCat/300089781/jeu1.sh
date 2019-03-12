#!/bin/bash

function main {
   echo "Clients "
   for client in ./client*.json; do
    for ((i=1; i<=2 ;i++)); do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic clients < ./client$i.json
    done
done
}

main
