# Apprentissages

## 3 Ajouter de la persistance et du hot-reloading au guestbook

Note: J'ai ajouté la persistance dans l'étape 2 et pas envie de modifier l'historique git, elle est bien fonctionnelle.

### Problème rencontré et pourquoi il est survenu
N/A
### Solution appliquée et pourquoi cette solution fonctionne

voir docker-compose.yaml, docker hub m'a fourni l'emplacement des données dans les images redis (`/data`), il n'y avait rien d'autre à faire

pour la partie dev avec air, j'ai fait un seul Dockerfile avec 3 stage, deux fichier docker-compose pour définir le type de stack

j'utilise un second fichier compose pour définir le volume qui contient le code, ce qui évite de dupliquer la configuration compose pour le mode dev, mais oblige les devs à lancer la stack comme ceci : 

```
docker compose -f docker-compose-dev.yaml -f docker-compose.yaml config
```

### Ce que j'ai appris

compose merge et include ne sont toujours pas aussi puissant que j'aurai aimé, il ne semble pas exister de moyen d'ajouter un volume de manière conditionnelle.

Air fonctionne bien pour le hot reload, mais ses erreurs ne sont pas très explicite.

valeur par défaut des variables: https://docs.docker.com/compose/how-tos/environment-variables/variable-interpolation/, au final pas utilisé au profit de deux fichier compose.

merge/include des compose files : https://docs.docker.com/compose/how-tos/multiple-compose-files/
