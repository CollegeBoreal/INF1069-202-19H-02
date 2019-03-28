#!/bin/bash

function main {
   echo "Copy de fichier"
   for chanteur in vente*.json
   do
     docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic ventes <  ./$vente
   done
}

main
