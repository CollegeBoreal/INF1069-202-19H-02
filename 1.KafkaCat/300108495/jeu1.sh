#!/bin/bash

function main {
   echo "Copy de fichier "
   i=1; 
   for client in ./client*.json; do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic clients_info < ./client$i.json  
        i++;
    
done
}

main
