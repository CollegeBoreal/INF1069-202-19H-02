#!/bin/bash

function main {
        echo "qwerty"
for service in ./services*.json; do
    for ((i=1; i<=4 ;i++)); do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic services < ./services$1.json
done
done
}
