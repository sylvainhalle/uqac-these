**Ce gabarit est obsolète. Utiliser plutôt https://github.com/sylvainhalle/uqac-these-3.**

Gabarit de mémoire, thèse et essai pour l'UQAC
==============================================

par Sylvain Hallé <shalle@acm.org>

Comment utiliser ce modèle
--------------------------

Cet ensemble de fichiers permet de produire un document de type
mémoire, essai ou thèse en suivant la même présentation que le gabarit au
format Microsoft Word qui était (jadis) disponible sur le site de
l'université.

En quelques étapes rapides:

1. Décompressez le contenu de l'archive dans un répertoire de votre
   choix
2. Ouvrez le fichier these.tex, trouvez-y les champs \UqacTheseTitre, etc.
   et remplacez-les par les valeurs appropriées
3. Modifiez au besoin le préambule (la ligne débutant par \documentclass)
   pour remplacer these par memoire, essai ou projetthese selon le type de
   document à produire (modifie le contenu de la page titre auto-générée)
4. Localisez la section "Document principal" et ajoutez autant de commandes
   include qu'il y a de fichiers à inclure dans votre document
5. Modifiez au besoin la ligne \bibliography pour y inclure les fichiers
   .bib appropriés

Pour tout le reste, la classe uqac-these utilise exactement les mêmes
commandes et les mêmes environnements que la classe "book" qui vient par
défaut avec LaTeX. Lisez la documentation sur "book" pour comprendre comment
utiliser uqac-these.

Le Makefile
-----------

Sous Linux, un script de type Makefile vous aide à accomplir les tâches
courantes (compiler, produire la bibliographie, etc.). Tapez `make help`
pour plus d'infos.

### Compilation

La compilation courante s'effectue simplement avec:

    make

Le processus s'arrête avec un code d'erreur non nul si la compilation n'a pu
s'effectuer jusqu'au bout (par exemple, si `pdflatex` a produit un message
d'erreur).

### Correction orthographique

La commande `make` vous permet d'appeler le correcteur orthographique
[Aspell](http://aspell.net) (si installé) sur vos fichiers source. On
l'appelle ainsi:

    make file=chapitreX.tex aspell

La beauté d'Aspell est qu'il "comprend" les commandes LaTeX et ne les prend
pas pour des fautes d'orthographe. Mieux, si vous ajoutez des acronymes et
des mots techniques (comme "Bitcoin", "HTML" ou "endomorphisme"), Aspell
s'en souviendra et ne vous arrêtera pas dessus la prochaine fois que vous
repasserez sur vos fichiers.


Quelques bonnes pratiques
-------------------------

### Inclusion de code source

Utilisez l'environnement `verbatim` pour du code quelconque, et
`lstlisting` pour du code source (ce dernier fait de la coloration
syntaxique).

N'incluez pas vos fragments de code directement dans votre chapitre.
Placez-les plutôt dans des fichiers séparés que vous incluez avec une
instruction `\input`. Donc, ne faites pas ceci:

```
On peut le voir avec le code suivant:

\begin{lstlisting}
plein de code bizarre
\end{lstlisting}
```

mais plutôt:

```
On peut le voir avec le code suivant:

\input{mon.code.inc.tex}
```

Il y a deux raisons principales:

- Comme le code que vous incluez n'est probablement pas du LaTeX, la
  coloration syntaxique risque d'être perturbée par votre code (parfois
  pour le reste du fichier: imaginez si votre code contient un seul `$`)
- Si vous passez un correcteur orthographique (comme Aspell) sur votre
  source, il ne lira pas le code (et vous épargnera une floppée
  d'avertissements stupides).
  
### Emplacement des figures

Placez vos figures dans le dossier `fig`. Vous n'avez pas besoin de (et ne
devriez pas) écrire `fig/` lorsque vous utilisez `\includegraphics` pour
inclure une figure.

### Warnings et erreurs

N'ignorez pas les warnings, et encore moins les erreurs. Même si la
compilation peut se rendre jusqu'au bout en appuyant sur Enter pour passer
par-dessus ces messages, la manoeuvre a des chances de ne pas fonctionner
sur tous les ordinateurs. Presque toujours, la présence d'un message
d'erreur indique un vrai problème avec vos sources --alors réglez-le!

Production du PDF final
-----------------------

L'UQAC demande à ce que le PDF final soit au format
[PDF/A](https://en.wikipedia.org/wiki/PDF/A), selon le
[Guide de création des fichiers pour le dépôt final](http://services.uqac.ca/decanat-des-etudes/files/2014/09/GuideCr%C3%A9ationFichiers_DepotFinal2018.pdf).
Comme vous utilisez LaTeX, vous êtes épargné du processus fastidieux décrit
dans ce document (et qui s'applique aux utilisateurs de Word). Vous n'avez
qu'à décommenter cette ligne dans `these.tex` pour produire votre dernier
fichier:

    \usepackage[a-1b]{pdfx}

Assurez-vous d'utiliser une version récente du package (2017 ou après), car
d'anciennes versions sont boguées et empêchent votre document de compiler.
De plus, le package n'écrit pas correctement la méta-donnée `Author` dans le
PDF généré. Pour l'ajouter, vous devez aller écrire votre nom dans le
fichier `these.info`, puis taper à la ligne de commande

    make metadata

Cette option nécessite que
[pdftk](https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/)
soit installé.

À propos de ce modèle
---------------------

Consultez les commentaires du code source de `uqac-these.cls` pour
plus d'information sur la création de cette classe.

2017-12-24

<!-- wrap=hard:maxLineLen=76: -->
