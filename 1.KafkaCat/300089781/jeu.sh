#!/bin/bash


function main {
   echo "foodie"
   for repas in ./repas*.json; do
   for ((i=1; i<=3; i++)); do
	docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic repas < ./repas$i.json
   done
done
}

main
