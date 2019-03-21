#!/bin/bash

function main {
   echo "Copy de fichier"
   for i in {1..12}
   do
     cat bus_schedule$i.json
   done
}

main


