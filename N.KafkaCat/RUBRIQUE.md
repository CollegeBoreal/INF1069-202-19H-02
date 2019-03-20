* Liste des taches à faires 

:o: Environnement Kafka - KSQL
```
  0 - Créer votre propre répertoire dans 1.kafkacat et documenter les étapes dans votre fichier README.md
  1 - Utiliser votre propre orchestration pour utiliser l'environnement KSQL (docker-compose.yml)
  2 - créer un topic pour l'utilisation d'une TABLE KSQL (statique)
  3 - créer un topic pour l'utilisation d'un STREAM KSQL (Volatile)
```

:a: Données

:one: - Créer un jeu d'essai que l'on peut éxecuter à souhait comportant : (statique)
```
  0 - un shell script permettant de lancer les messages
  1 - plusieurs fichiers de données permettant une visibilité sur le flux des messages
  2 - ce jeu d'essai sera de type TABLE 
  3 - Le jeu de données est élaboré (au moins cinq fichiers) 
```

:two: - Créer un jeu d'essai que l'on peut éxecuter à souhait comportant : (volatile)
```
  0 - un shell script permettant de lancer les messages
  1 - plusieurs fichiers de données (au moins cinq) permettant une visibilité sur le flux des messages
  2 - ce jeu d'essai sera de type STREAM 
  3 - Le jeu de données est élaboré (au moins cinq fichiers) 
```

:b: Flux (KSQL)

:three: - Créer une TABLE en KSQL
```
  0 - Créer une commande KSQL permettant la création d'une TABLE
  1 - afficher son contenu en utilisant la commande SELECT
  2 - la création KSQL comporte un objet JSON imbriqué (STRUCT) 
  3 - la création KSQL montre une gestion des dates
```

:four: - Créer un STREAM en KSQL
```
  0 - Créer une commande KSQL permettant la création d'un STREAM
  1 - afficher son contenu en utilisant la commande SELECT
  3 - La commande doit mettre en valeur la clé de la TABLE à lier 
```

:ab: - Composition (KSQL JOIN)
```
  1 - À partir du STREAM et de la TABLE, créer une jointure
  2 - Afficher la jointure
```

:100: - Présentation [Point en plus]
```
  1 - Comporte un fichier README.md
  2 - Comporte toutes les commandes bash et KSQL
  2 - Comporte toutes les commandes bash et KSQL
```
