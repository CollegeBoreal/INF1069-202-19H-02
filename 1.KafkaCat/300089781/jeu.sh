#!/bin/bash


function main {
   echo "foodie"
for filename in ./repas*.json; do
for ((i ...)); do
	docker exec --interactive kafka kafka-console -producer --broker-list kafka:9092 --topic repas < ./
}

main
