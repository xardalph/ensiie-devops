# Apprentissages

## 0 dépendances

Vérifier que nous avons les dépendances nécessaire pour l'exercice

### Problème rencontré et pourquoi il est survenu
Je n'ai pas golang d'installer sur cette machine, et pas très envie de l'installer

### Solution appliquée et pourquoi cette solution fonctionne

`docker run  -v '$PWD:/app' -it -rm -name golang golang:latest`

devrait permettre de compiler avant d'utiliser une image multistage, je vais juste avoir des problèmes de droits avec le partages, pour régler cela il faudrait que je créer un user d'id 1000 dans le conteneur et que je l'utilise plutôt que root.

une fois dans l'image, `cd /app/ && go build && exit` puis lancer le binaire `./basic-web` fonctionne, même si le binaire appartient à root pour le moment.

### Ce que j'ai appris
utilisation basique de docker

