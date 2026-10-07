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

# avec ldflags lors du build : 
   ldd /usr/local/bin/app 
	not a dynamic executable
```
- multistage de l'image en utilisant scratch comme image finale. taille de l'image à cette étape : 15.8MB.


#### Docker compose

pour le moment il n'y à pas besoin de faire de réseaux séparé ou autre fonctionnalité avancé, le compose est donc plutôt simple.

J'ai regardé pour mettre un healthcheck en place, mais curl est compilé dynamiquement avec openssl, et augmente beaucoup la taille de l'image.

Je n'ai pour le moment pas de solution "propre" pour faire un health check sur compose avec des images scratch, j'ai trouvé microcheck : https://github.com/tarampampam/microcheck mais pas pris le temps de vérifier si l'outil est bien maintenu, il fonctionne bien en tout cas.

### Ce que j'ai appris
build de golang, language que je n'ai pas beaucoup utilisé

scratch, j'ai toujours utilisé alpine pour les petites images

healthcheck sont plus compliqué à implémenter que ce que je pensais dans les petites images, k8s à contourné cela en sortant la responsabilité du container.
