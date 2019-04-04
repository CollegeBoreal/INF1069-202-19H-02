#!/bin/bash

function main {
   echo "Copy de fichier"
   for chanteur in chanteur*.json
   do
     docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic chanteurs <  ./$chanteur
   done
}

main










