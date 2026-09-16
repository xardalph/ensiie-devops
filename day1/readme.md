# Apprentissages

## random_pet & dépendances

on veux créer un fichier avec un nom aléatoire lisible et retenable par un humain.
Terraform peux installer pour nous les 2 dépendances si on fait `terraform init -upgrade`

Court résumé de l’objectif visé

### Problème rencontré et pourquoi il est survenu
les docs terraform ne sont pas très clair pour ne pas utiliser les providers qui n'utilisent pas aws : 
https://registry.terraform.io/providers/hashicorp/random/latest/docs

### Solution appliquée et pourquoi cette solution fonctionne
lire la doc et surtout la listes des options, la signification de keepers et le fait qu'une ressource peux être vide.

### Ce que j'ai appris
le type de ressource définie la dépendance dont on à besoin avec un format `resource <dep_name> <obj_name>`

donc on doit pouvoir créer plusieurs resources avec le même plugin
