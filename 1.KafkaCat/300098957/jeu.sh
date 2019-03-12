#!/bin/bash

function main {
   echo "Copy de fichier"
   docker exec --interactive kafka kafka-console-producer \
               --broker-list kafka:9092 \
               --topic my_topic < ./file1.json
}

main


