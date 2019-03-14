#!/bin/bash

function main {
        echo "qwerty"
for client in ./clients*.json; do
    for ((i=1; i<=4 ;i++)); do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic clients < ./clients$1.json
done
done
}
