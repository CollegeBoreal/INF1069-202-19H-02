#!/bin/bash

function main {
   echo "Copy de fichier "
   for client in ./client*.json; do
        docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic clients_info < ./client$.json  
        
    
done
}

main
