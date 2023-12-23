# Life is a highway 🚛

> Réalisé par Lucas Gournay, Louèva Beranger, Elias Chekhab (Trinôme-MI6-E)

**Life is a highway** est un outil de traitement de données pour aider à gérer la logistique des sociétés de transport routier. Pour cela, il utilise les données d'un tableur suivant le chemin `data/data.csv`.

> Plus de détails sur le projet [ici](https://github.com/Eraguzy/life-is-a-highway/blob/main/Projet_CY_Truck_preIng2_2023_2024_v1.0.1.pdf)

## Utilisation 💡

Pour exécuter le programme, entrez la commande suivante dans votre terminal :
```
bash script.sh data/data.csv -x -y -z
```
`-x -y -z` étant les différents traitements que l'utilisateur souhaite avoir (on peut en demander plusieurs en même temps).

> ⚠️ il faut au minimum deux arguments pour exécuter correctement le programme : le chemin vers le fichier à traiter + les traitements souhaités.

Les graphiques résultant de ces traitements seront stockés dans un dossier `images`.

## Traitements disponibles 🧑‍💻

>Pour chaque traitement, un calcul du temps d'exécution est donné.

`-h` : affiche l'**aide**. Si présent, le programme n'effectuera pas d'autre tâche.

`-d1` : affiche un histogramme horizontal montrant les 10 conducteurs ayant effectué **le plus de trajets**, avec en ordonnée les noms des conducteurs, et en abscisse le nombre de trajets effectués. S'effectue en moins de 8 secondes.

`-d2` : affiche un histogramme horizontal montrant les 10 conducteurs ayant parcouru **la plus grande distance**, avec en ordonnée les noms des conducteurs, et en abscisse la distance effectuée (km). S'effectue en moins de 7 secondes.

`-l` : affiche un histogramme vertical montrant les 10 **plus longs trajets**, avec en abscisse l’identifiant du trajet, et en ordonnée la distance (km). S'effectue en moins de 8 secondes.

`-t` : affiche un histogramme vertical regroupé montrant les 10 **villes les plus traversées**, avec en abscisse le nom des villes, et en ordonnée le nombre de trajets. Le graphique montre le nombre de traversées ainsi que le nombre de fois où cette ville est un point de départ.

`-s` : affiche un **graphique min-max-moyenne** des 50 trajets les plus longs, avec en abscisse les identifiants des trajets, et en ordonnée les distances (km) (mini, moyenne, maxi).

## Prérequis ☝️

- avoir **gcc**, **Gnuplot**, **bash** installés sur votre appareil

## Bugs et limitations 👾

/



