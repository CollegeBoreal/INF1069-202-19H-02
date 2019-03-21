#!/bin/bash

function main {
   echo "Copy de fichier "
   for product in ./product*.json;
   do  
    docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic client < ./$product
  
done
}

main
