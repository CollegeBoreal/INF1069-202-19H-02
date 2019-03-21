#!/bin/bash

function main {
   echo "Copy de fichier"
   for produit in produit*.json
   do
     docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic produits <  ./$produits
   done
}

main                                                                                                                         


