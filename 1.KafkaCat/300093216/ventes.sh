#!/bin/bash

function main {
   echo "Copy de fichier"
   for ventes in vente*.json
   do
     docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic ventes <  ./$ventes
   done
}

main                                                                                                                         

