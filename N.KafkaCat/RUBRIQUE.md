* Liste des taches à faires 

:o: Environnement Kafka - KSQL
```
  0 - Créer votre propre répertoire dans 1.kafkacat et documenter les étapes dans votre fichier README.md
  1 - Utiliser votre propre orchestration pour utiliser l'environnement KSQL (docker-compose.yml)
  2 - créer un topic pour l'utilisation d'un STREAM KSQL (Volatile)
  3 - créer un topic pour l'utilisation d'une TABLE KSQL (statique)
```

:a: Données

:one: - Créer un jeu d'essai que l'on peut éxecuter à souhait comportant :
```
  1 - un shell script permettant de lancer les messages
  2 - plusieurs fichiers de données (au moins cinq) permettant une visibilité sur le flux des messages
  3 - ce jeu d'essai sera de type STREAM (volatile)
```

:two: - Créer un jeu d'essai que l'on peut éxecuter à souhait comportant :
```
  1 - un shell script permettant de lancer les messages
  2 - plusieurs fichiers de données (au moins cinq) permettant une visibilité sur le flux des messages
  3 - ce jeu d'essai sera de type TABLE (statique)
```

:b: Flux (KSQL)

:three: - Créer un STREAM en KSQL
```
  1 - Créer une commande KSQL permettant la création d'un STREAM
  2 - La commande doit comporter un objet JSON imbriqué (STRUCT)
  3 - afficher son contenu en utilisant la commande SELECT
```

:four: - Créer une TABLE en KSQL
```
  1 - Créer une commande KSQL permettant la création d'une TABLE
  2 - La commande doit mettre en valeur la clé de la table
  3 - afficher son contenu en utilisant la commande SELECT
```

:ab: Composition (KSQL JOIN)
```
  1 - À partir du STREAM et de la TABLE, créer un jointure
  2 - Afficher la jointure
```
