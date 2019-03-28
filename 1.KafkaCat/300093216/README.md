

### ⭕️ ENVIRONNEMENT KAFKA_KSQL

## 1. CRÉER SON ENVIRONNEMENT DANS UN REPERTOIRE:
  ```  cp ../../D.Demo/docker-compose.yml  .```
 
 ##  2. Enlever les applications de la vente
  
  ```vi docker-compose.yml```
  
## 3. Avant de l'executer dans 1.Kafkacat/ID vous devez supprimer votre environnemnet dans D.Demo

 ```$ cd ../../D.Demo
$ docker-compose stop 
$ docker-compose rm 
```
## A . Executez votre environnement dans 1.KafkaCat/ID :

```
$ cd ../../1.KafkaCat/ID (ex:300093216) 
$ docker-compose up -d 
```
## 1. Connaitre le nom de switch Docker de KafkaCat
```
docker network ls
```
## 2. Faire la liste de tout l'environnment
```
docker run --tty --network 300093216_default confluentinc/cp-kafkacat kafkacat -b kafka:29092 -L
```
## 3. Accedez a votre bash de Kafaka
```
docker-compose exec kafka bash 
```

## 4. Création des topics
```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic produits --create --partitions 5 --replication-factor 1
Created topic "produits"
```

```
root@kafka:/# kafka-topics --zookeeper zookeeper:32181 --topic ventes--create --partitions 5 --replication-factor 1
Created topic "ventes"
```

### B. Creation de fichier JSON :

```  
 nano produit.json 
```
## Ajouter un code 
```
{"produit":1, "nom":"church", "style":{"couleur":"violet", "materiel":"cuir"}}

```
en suite vous pouvez ajouter les autres foichiers de produit$.json avec un des lignes ci-dessous:

```
{"produit":2, "nom":"louboutin", "style":{"couleur":"noir", "materiel":"suede"}}
{"produit":3, "nom":"john lobb", "style":{"couleur":"vert", "materiel":"crocodile"}}
{"produit":4, "nom":"prada", "style":{"couleur":"gold", "materiel":"lezard"}}
{"produit":5, "nom":"gucci", "style":{"couleur":"rouge", "materiel":"vernis"}}
```
et aussi la même chose pour le fichier de vente$.json

```
{"produit":1, "quantite":2}
{"produit":2, "quantite":5}
{"produit":3, "quantite":1}
{"produit":4, "quantite":2}
{"produit":5, "quantite":3}

```

il faut creer des jeux.sh pour chaque topic pour produits

```
 nano jeu1.sh
```
Vous allez tapper en suite ce code:

```
#!/bin/bash

function main {
   echo "Copy de fichier"
   for chanteur in produit*.json
   do
     docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic produits <  ./$produit
   done
}
main
```

 Faire la même chose pour le topic vente:
 
 ```
#!/bin/bash

function main {
   echo "Copy de fichier"
   for chanteur in vente*.json
   do
     docker exec --interactive kafka kafka-console-producer --broker-list kafka:9092 --topic ventes <  ./$vente
   done
}

main
```
 
 


main



###1️⃣ - Créer un jeu d'essai que l'on peut éxecuter à souhait comportant : (statique)

  0 - un shell script permettant de lancer les messages
  1 - plusieurs fichiers de données permettant une visibilité sur le flux des messages
  2 - ce jeu d'essai sera de type TABLE 
  3 - Le jeu de données est élaboré (au moins cinq fichiers) 
  
###2️⃣ - Créer un jeu d'essai que l'on peut éxecuter à souhait comportant : (volatile)

  0 - un shell script permettant de lancer les messages
  1 - plusieurs fichiers de données (au moins cinq) permettant une visibilité sur le flux des messages
  2 - ce jeu d'essai sera de type STREAM 
  3 - Le jeu de données est élaboré (au moins cinq fichiers) 
  
  
##🅱️ Flux (KSQL)

###3️⃣ - Créer une TABLE en KSQL

  0 - Créer une commande KSQL permettant la création d'une TABLE
  1 - afficher son contenu en utilisant la commande SELECT
  2 - la création KSQL comporte un objet JSON imbriqué (STRUCT) 
  3 - la création KSQL montre une gestion des dates

###4️⃣ - Créer un STREAM en KSQL

  0 - Créer une commande KSQL permettant la création d'un STREAM
  1 - afficher son contenu en utilisant la commande SELECT
  2 - la création KSQL comporte un objet JSON imbriqué (STRUCT) 
  3 - La commande doit mettre en valeur la clé de la TABLE à lier 
💯 - Présentation [Point en plus]

  0 - Comporte un fichier README.md
  1 - Comporte des commandes bash
  2 - Comporte des commandes KSQL
  3 - Comporte des resultats de requestes KSQL
🆎 - Composition (KSQL JOIN)

  1 - À partir du STREAM ou de la TABLE, créer une jointure
  2 - Afficher le résultat de la jointure
,
