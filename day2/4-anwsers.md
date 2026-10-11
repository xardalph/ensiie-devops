# Apprentissages

## 4 Créer des stacks avec du hot-reloading

J'ai choisi d'essayer de faire une stack avec Rust et plus particulièrement le framework web Axum de rust, car je l'avais déjà utilisé dans un précédent projet mais jamais mis en place de hot reload.

### Problème rencontré et pourquoi il est survenu

Au début j'utilisais la commande `bacon run --headless`, ce qui ne lancais qu'une seule fois le binaire et ne rechargeait pas en cas de modification des fichiers.

### Solution appliquée et pourquoi cette solution fonctionne

Bacon est très modulaire, mais les jobs pré configuré ne sont pas très bien documenté, l'ia m'a montré l'option `run-long` qui permet de lancer des binaires qui ne termine jamais


J'ai fait une [pr](https://github.com/Canop/bacon/pull/469) de contribution au projet bacon pour aider à documenter cette usage, affaire a suivre.

### Ce que j'ai appris

L'outil le plus simple pour mettre cela en place semble etre [bacon](https://github.com/canop/bacon). 
il n'est pas lié à axum particulièrement, et peux être utilisé pour n'importe quel projet rust

pour l'installer, il faut utiliser cargo qui est présent dans l'image rust officielle

`cargo install --locked bacon`

puis dans un projet rust comme celui que j'ai créé dans `rust-hot-reload/`, il faut utiliser la commande suivante pour lancer le serveur web, qui va être recompilé dès qu'un changement sera détecté.

```
bacon run-long --headless
```

Vous pouvez voir le fichier Dockerfile qui créer un environment de prod depuis scratch et un environment de dev depuis l'image rust officielle.

Pour lancer l'environment de dev, il faut utiliser la commande suivante : 

```
docker compose -f docker-compose-dev.yaml up
``` 

puis aller sur l'url http://localhost:3001/ pour voir le site web.
