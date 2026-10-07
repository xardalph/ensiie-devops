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

L'image fait 1.03GB avant toutes améliorations de taille ou de sécurité. Voici la liste des éléments que j'ai implémenté 
- utilisateur dédié pour l'application
- link statique de l'application, vérifié avec ldd : 
``` 
#  avant d'ajouter --ldflags '-linkmode external -extldflags "-static"'
ldd /usr/local/bin/app 
	linux-vdso.so.1 (0x00007fffabfa9000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007dad796e7000)
	/lib64/ld-linux-x86-64.so.2 (0x00007dad798e0000)

avec ldflags lors du build : 
   ldd /usr/local/bin/app 
	not a dynamic executable
```
- multistage de l'image en utilisant scratch comme image finale. taille de l'image à cette étape : 15.8MB.

### Ce que j'ai appris
