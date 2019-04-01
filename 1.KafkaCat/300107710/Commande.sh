#!/bin/bash

function main {
   echo "Copy de fichier"
   for commande in Commande*.json
   do
     docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic commande <  ./$commande
   done
}


main



