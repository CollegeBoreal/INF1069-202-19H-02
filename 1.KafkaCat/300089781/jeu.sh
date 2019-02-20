#!/bin/bash

function main {
   echo "copy de fichier"
   docker cp file1.json kafka:/tmp/file1.json
}

main
