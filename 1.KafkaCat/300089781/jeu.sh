#!/bin/bash


function main {
   echo "foodie"
   for repas in repas*.json
   do
	docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic repas < ./$repas
done
}

main
