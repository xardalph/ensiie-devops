# Apprentissages

## 1 Conteneuriser l'application guestbook

faire un docker file d'une application golang simple

### Problème rencontré et pourquoi il est survenu

### Solution appliquée et pourquoi cette solution fonctionne
le dockerfile proposé par l'image golang sur docker hub suffit pour faire fonctionner cette application, vous pouvez voir le fichier Dockerfile dans le dossier courant. pour lancer le conteneur, il faut le build puis l'exécuter : 
```
docker build -t my-golang-app .
docker run -p 3000:3000 -it --rm my-golang-app:latest
```
il faut être dans le dossier de l'application pour les deux commandes pour que les chemins soit correctement résolu.

### Ce que j'ai appris
