# Apprentissages

## 5 yunohost et auto hébergement

plutôt que de faire un nouveau projet docker, je vais vous présenter mon infrastructure d'auto hébergement qui utilise compose pour héberger quelques services (nextcloud, vaultwarden, supervision...)

je n'ai pas mis mon repo docker en publique, je vous ai normalement envoyé l'archive de mon répo par mail.

Mes besoins d'autohébergements sont plutôt simple, je veux stocker mes mots de passes de manière sécurisé, quelques fichiers et photo, télécharger en torrent les iso linux à leurs sortie, et tester des outils quand l'envie m'en prend.
Pour cela j'ai un petit VPS, et j'ai eu un serveur mais que j'ai du eteindre jusqu'a nouvelle ordre (trop de bruit).

### reverse proxy : Traefik for the win

J'utilise traefik pour générer tous mes certificats tls et faire point d'entrée unique vers mes services hébergé.
il permet de surveiller les containers docker via le socket docker, et active un vhost pour chaque container qui utilise.
afin d'essayer de réduire sont périmètre d'action si il est compromis, j'ai mis en place un réseau dédié dans lequel chaque container qui doit être accessible est ajouté, ce qui fait que j'ai une double activation pour qu'un container soit visible (un tag docker + ajout dans le bon réseau)

### compose factorization

Afin de maximiser la factorisation et avec l'arrivé de mon second serveur, j'ai mis en place une architecture compose pour définir certains éléments une seule fois via des main.yaml.

Les problèmes principaux que je voulais traiter était : 
- monitoring/backup : mon architecture initiale était d'avoir plusieurs projets docker complètement séparé, ce qui rendait la configuration des backup et de la supervision (via prometheus/grafana) complexe, car un volume définie dans un projet compose ne peux pas être utilisé dans un autre projet compose (le nom du dossier courant est concaténé au début du nom de chaque volumes)
- activation partielle : je voulais pouvoir découper la stack de supervision en 2 : grafana et victoria metrics doivent tourner sur un seul hote, mais cadvisor et vmagent doivent être exécuter sur tous mes noeuds.

Pour cela, j'ai envisagé d'utiliser k8s, mais je le trouvais trop lourd pour mes besoins encore très petit, et synchroniser les données entre mes deux machines ne me semblais pas faisable pour avoir du HA. J'ai donc décidé de continuer sur compose, et est mis cette architecture en place : 
```
| docker-compose.yaml -> défini les réseaux génériques et inclue le fichier ./main.yaml du dossier courant + les fichiers .env
| .env -> définie les variables global à ce serveur (nom de domaine par exemple)
| nextcloud/ -> nom du logiciel que j'héberge
| | docker-compose.yaml -> lien symbolique vers le compose du dossier audessus
| | main.yaml -> contient la définition des containers utile pour faire tourner nextcloud (web, db, etc...)
| | .env -> variable d'environment que je ne veux pas mettre dans git
| | .env.template -> exemple de variable d'environment documenté
| monitoring_agent/
| | .env
| | docker-compose.yaml
| | main.yaml -> configure tous les agents de supervisions (cadvisor, blackbox, node_exporter, et vmagent qui envoie les données vers victoria metrics)
| | scraping.yaml -> charge toutes les configurations présentes dans enabled_scrape
| | available_scrape -> liste de toutes les configuration de supervision dont je pourrai avoir besoin
| | enabled_scrape  -> contenu ignoré par git, pour rester spécifique à chaque serveur installé.
| | file.yaml -> lien symbolique vers un fichier de available_scrape
| | 
```

l'objectif était d'utiliser les fonctions "include" de docker compose pour que toute mon infrastructure soit un seul "projet" au sens compose, mais que ce ne soit pas un seul fichier de 3 000 lignes, et éviter d'avoir des lignes de commandes trop longues en spécifiant tous les fichiers manuellement.

Voici le fichier compose racine, il définie principalement l'appel aux fichier main.yaml, .env de chaque dossiers et les réseaux commun (il faudrait que je les transforment de external à internal avec cette nouvelle architecture, je m'y mettrai peut-être un jour) : 

```
# exemple of small app using traefik.
#services:
#  my-app:
#    image: traefik/whoami:v1.7.1
#    labels:
#      - "traefik.http.routers.${APP}.rule=Host(`whoami.${DOMAINNAME}`)"
#      - "traefik.enable=true"

include:
  - path: main.yaml
    env_file: # this load the .env at the root of the git project, and the .env for the current 
      # docker-compose (which should be named main.yaml)
      - ../.env
      - .env
# default network that are used nearly all the time.
networks:
  default:
  monitoring-internal:
    external: true
  monitoring:
    external: true
  traefik_proxy:
    external: true
```

pour la supervision, j'ai voulu utiliser le même principe que Apache utilise sur debian (ce n'est pas le cas sur alma, j'ignore pourquoi).

Apache utilise un dossier `sites_availables`  qui contient les fichier de configurations, et un dossier `sites_enabled` ou vivent seulement des liens symbolique vers `sites_availables` des sites actifs.
Cela me permet d'avoir un seul dépôt git contenant toutes mes configurations, mais elle ne sont active que lorsque nécessaire. Dans les fait si je erdait completement un serveur je devrait me souvenir de ce qui est activé sur quel serveur, c'est un risque que j'ai accepté puisqu'il n'y à pas beaucoup de fichier pour le moment.





