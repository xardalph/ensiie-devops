# Apprentissages

## conditions

## Court résumé de l’objectif visé

on veux conditionner l'exécution de terraform à certains invariant (valeur de variables) et ajouter des tests auto sur notre module

### Problème rencontré et pourquoi il est survenu
le code coverage ne semble pas intégré dans terraform, j'ai trouvé des blog post avec des script mais rien de fourni par hashicorp
https://oneuptime.com/blog/post/2026-02-23-how-to-measure-terraform-test-coverage/view

### Solution appliquée et pourquoi cette solution fonctionne
Le 1er script semble gérer ce besoin, dommage que hashicorp ne l'intègre pas dans la CLI

### Ce que j'ai appris
les tests terraform
