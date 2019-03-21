#!/bin/bash


function main {
   echo 'Hello world'
   for filename in ./commande*.json; do
     for ((i=0; i<=6; i++)); do
           docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic commande < ./commande$i.json
    done
done
}

main

