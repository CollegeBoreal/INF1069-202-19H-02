#!/bin/bash

function main {
   echo "Client "
   for client in client*.json
   do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic client < ./$client
done
}
main
