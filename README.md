# Aide pour Utiliser Emacs et Rendre les Devoirs de l'IED

Pour une assistance à la prise en main d'Emacs et pour rendre les devoirs de l'IED, voici trois fichiers qui pourront être utiles :

- `init.el` : fichier de configuration pour Emacs (optionnel)
- `ied-latex-standard.org`
- `IED-L[NIVEAU]-[COURS]-[CHAPITRE]-[PRENOM]-[NOM]-ID[NUMERO].org`

## Installation

Pour utiliser Emacs :

1. Installer Emacs
    ```bash
    $ sudo apt-get install emacs
    ``` 
2. Installer LaTeX
    ```bash
    $ sudo apt-get install texlive-full
    ```
(Note: LaTeX n'est pas requis pour utiliser Emacs, mais il est nécessaire pour rédiger les devoirs.)
3. Lancer Emacs
    ```bash
    $ emacs &
    ```

## Les Commandes

Il est conseillé de parcourir le tutoriel pour apprendre les commandes de base. Sinon, voici quelques commandes de base :

- `Ctrl-g` : pour sortir d'un combo de commandes (souvent utile)
- `Ctrl-f`, `Ctrl-b`, `Ctrl-p`, `Ctrl-n` : pour avancer, reculer, monter, descendre le curseur respectivement.
- `Ctrl-x Ctrl-f` : pour ouvrir un fichier
- `Ctrl-x Ctrl-s` : pour sauvegarder
- `Ctrl-x Ctrl-c` : pour quitter

## Devoirs

Pour soumettre un devoir en utilisant Org-mode, copiez le fichier `ied-latex-standard.org` sur votre machine et notez le chemin d'accès pour une utilisation ultérieure.

Suivez ces étapes pour rédiger un devoir :

1. Ouvrez une copie du fichier "devoir". Deux options possibles :
   - Si vous êtes déjà dans Emacs, utilisez la commande `Ctrl-x Ctrl-f` et saisissez le nom de votre fichier dans le dossier choisi,
   - Sinon, à partir de la ligne de commande, exécutez `emacs [COPIE FICHIER] &` pour ouvrir une fenêtre avec un fichier portant le même nom.

2. Modifiez l'en-tête du document .org avec les informations du cours et les vôtres, ainsi que le chemin d'accès au fichier `ied-latex-standard.org` copié précédemment :

```org-mode
#+TITLE: [NOM DU CHAPITRE]
#+SUBTITLE: [NOM DU COURS]
#+OPTIONS: toc:t author:nil
#+LaTeX_HEADER: \author{[PRENOM NOM] \\ N. Etudiant : [NUMERO]}
#+SETUPFILE: ~/[CHEMIN]/ied-latex-standard.org
```

3. Rédigez votre devoir en dessous de la marque "New page" en utilisant la notation Org-mode.

4. Exportez votre devoir en PDF en utilisant la commande `Ctrl-c Ctrl-e l p`. Votre devoir est prêt.

Le format n'est pas standard et peut être modifié en fonction des besoins et préférences.