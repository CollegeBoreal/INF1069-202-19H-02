

# ⭕️ Environnement Kafka - KSQL

  0 - Créer votre propre répertoire dans 1.kafkacat et documenter les étapes dans votre fichier README.md
  1 - Utiliser votre propre orchestration pour utiliser l'environnement KSQL (docker-compose.yml)
  2 - créer un topic pour l'utilisation d'une TABLE KSQL (statique)
  3 - créer un topic pour l'utilisation d'un STREAM KSQL (Volatile)
  
  
##🅰️ Données

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
