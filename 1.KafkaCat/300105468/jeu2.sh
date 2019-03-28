#!/bin/bash

function main {
   echo "Copy de fichier"
   for chanson in chanson*.json
   do
  docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic chansons <  ./$chanson
done 
}

main
