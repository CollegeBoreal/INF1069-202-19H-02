#!/bin/bash

function main {
   echo "Copy de fichier"
   for chanteur in chanteur*.json
   do
<<<<<<< HEAD
      docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic chanteurs <  ./$chanteur
  done 
=======
     docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic chanteurs <  ./$chanteur
   done
>>>>>>> 0553fd6a611cd3d9663b4eeb25952e60d62f613e
}

main










