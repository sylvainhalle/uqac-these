%% --------------------------------------------------------------------------
%% Classe essai/mémoire/thèse UQAC
%%
%% uqac-these.cls
%% Copyright 2012-2018 Sylvain Hallé
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is Sylvain Hallé.
%%
%% This work consists of the file uqac-these.cls.
%%
%% Version: 2012-11-12
%% Modif:   2020-07-03
%%
%% NOTES d'utilisation
%% -------------------
%% Cette est classe est largement inspirée du modèle de thèse de l'UQAM,
%% version 1.3. Quelques différences fondamentales:
%%
%% - Utilise "book" comme classe de base plutôt que "report"; gère tout
%%   seul les numéros de pages romains/arabes avec les commandes standard
%%   \frontmatter et \mainmatter
%% - On essaie autant que possible de ne *pas* définir de nouveaux
%%   environnements (introduction, conclusion), mais de plutôt surcharger
%%   ceux déjà fournis par la classe report. Sauf erreur, le document
%%   compile si on remplace "uqac-these" par "book" dans le préambule
%%   (ce qui n'est pas le cas avec la classe UQAM p/r à "report")
%% - La définition des styles (de pages, de titres, etc.) se fait à travers
%%   des packages prévus à cet effet (plutôt que d'écraser directement les
%%   commandes en TeX) qui n'existaient pas au moment ou memoireuqam.cls a
%%   été écrit
%% --------------------------------------------------------------------------

%% ------------------------
%% Déclarations
%% ------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uqac-these}[2020/07/03 These UQAC, V1.05 par Sylvain Halle]

%% ------------------------
%% Numéro de version
%% ------------------------
\def\@uqactheseversion{1.05}

%% ------------------------
%% Options de police par défaut
%% ------------------------
\def\@uqacpdctimes{false}
\DeclareOption{times}{%
  \def\@uqacpdctimes{true}
}

%% ------------------------
%% Options de mémoire, thèse ou essai
%% ------------------------
\def\@uqacpdcessai{false} %% Essai
\DeclareOption{essai}{%
  \def\@uqacpdcessai{true}
}
\def\@uqacpdcmemoire{false} %% Mémoire
\DeclareOption{memoire}{%
  \def\@uqacpdcmemoire{true}
}
\def\@uqacpdcprojetthese{false} %% Projet de thèse
\DeclareOption{projetthese}{%
  \def\@uqacpdcprojetthese{true}
}
\def\@uqacpdcproposition{false} %% Proposition de projet (maîtrise)
\DeclareOption{propositionprojet}{%
  \def\@uqacpdcproposition{true}
}
\def\@uqacpdcthese{true} %% Thèse = valeur par défaut
\DeclareOption{these}{%
  \def\@uqacpdcthese{true}
}

%% ------------------------
%% Passage des autres options à la classe thesis
%% ------------------------
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{book}%
}
\ProcessOptions

%% ------------------------
%% Classe de base
%% ------------------------
\ifx\pdfoutput\undefined
\LoadClass[12pt,letterpaper,openright,dvips]{book}
\else
\LoadClass[12pt,letterpaper,openright,pdftex]{book}
\fi

%% ------------------------
%% Extensions
%% ------------------------
\RequirePackage[utf8]{inputenc}
\RequirePackage{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage{graphicx}
\RequirePackage{ifthen}
\let\footruleskip\undefined\RequirePackage{fancyhdr}
\RequirePackage[explicit]{titlesec}
\RequirePackage{textcase}
\RequirePackage{setspace}
\RequirePackage{tocloft}
\RequirePackage{emptypage} %% On ne pagine pas pages vides
%% Pour les titres de chapitres + coupures de mots en français
\RequirePackage[french]{babel}

%% ------------------------
%% Chargement conditionnel de packages selon le document produit
%% ------------------------
\ifx\pdfoutput\undefined
  %\newcommand{\hypersetup}[1]{}
\else
  \RequirePackage[babel]{microtype}
\fi

%% ------------------------
%% Ces packages doivent être chargés après babel
%% ------------------------
\RequirePackage{caption} %% Pour définir les légendes des figures

%% ------------------------
%% Choix de la police de caractère
%% ------------------------
\ifthenelse{\equal{\@uqacpdctimes}{false}}{%
  %% On utilise Computer Modern (police par défaut)
  %% (ne rien faire)
}{%
  %% Use Times font with math support
  \RequirePackage{newtxtext}
  %% Redefine default sans-serif font as Helvetica
  \renewcommand{\sfdefault}{phv}
  %% Use Bera Mono as the monospace font
  \RequirePackage[scaled]{beramono}
}

%% ------------------------
%% Choix du type de document
%% ------------------------
\def\@uqacpdcnomdoc{Thèse}
\def\@uqacpdcaccord{e}
\def\@uqacpdcnomprogramme{du doctorat en informatique}
\ifthenelse{\equal{\@uqacpdcmemoire}{true}}{%
  \def\@uqacpdcnomdoc{Mémoire}
  \def\@uqacpdcaccord{}
  \def\@uqacpdcnomprogramme{de la maîtrise en informatique}
}{%
  \ifthenelse{\equal{\@uqacpdcessai}{true}}{%
    \def\@uqacpdcnomdoc{Essai}
    \def\@uqacpdcaccord{}
    \def\@uqacpdcnomprogramme{de la maîtrise en informatique}
  }{%
    \ifthenelse{\equal{\@uqacpdcprojetthese}{true}}{%
      \def\@uqacpdcnomdoc{Projet de thèse}
      \def\@uqacpdcaccord{}
      \def\@uqacpdcnomprogramme{du doctorat informatique}
    }{%
      \ifthenelse{\equal{\@uqacpdcproposition}{true}}{%
        \def\@uqacpdcnomdoc{Proposition de projet}
        \def\@uqacpdcaccord{e}
        \def\@uqacpdcnomprogramme{de la maîtrise en informatique}
      }{%
        %\def\@uqacpdcnomdoc{}
      }
    }
  }
}

%% ------------------------
%% En français: les paragraphes n'ont pas d'alinéa et sont séparés
%% par une ligne vide
%% ------------------------
\setlength{\parindent}{0pt}
\setlength{\parskip}{10pt}

%% ------------------------
%% Marges de la page et interligne
%% ------------------------
\geometry{hmargin={3.5cm,2.5cm},vmargin={3.4cm,3cm}}

%% ------------------------
%% Style de la page
%% ------------------------
\fancyhead[LO,RE]{}
\fancyhead[RO,LE]{\thepage}
\renewcommand{\footrulewidth}{0pt}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot{}
\pagestyle{fancy}
%% On redéfinit le style plain pour ne pas avoir de numéros de page
%% à la première page des chapitres
\fancypagestyle{plain}{%
\fancyhf{} % clear all header and footer fields
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}}
\setlength{\headheight}{14.5pt}

%% ------------------------
%% Style des titres et sous-titres
%% ------------------------
\titleformat{\chapter}%
[block]%
{\centering\fontfamily{phv}\bfseries\selectfont}%
{\MakeTextUppercase{Chapitre \thechapter}}% Titre du chapitre
{0cm}% Séparation d'avec le corps du chapitre
{\vskip 24pt\MakeTextUppercase{#1}}% Code à exécuter avant le titre
{}% Code à exécuter après le titre

\titleformat{\section}%
[hang]%
{\fontfamily{phv}\bfseries\selectfont}%
{\MakeTextUppercase{\thesection}}% Titre du chapitre
{0.5cm}% Séparation d'avec le corps du chapitre
{\MakeTextUppercase{#1}}% Code à exécuter avant le titre
{}% Code à exécuter après le titre

\titleformat{\subsection}%
[hang]%
{\itshape\selectfont}%
{\MakeTextUppercase{\thesubsection}}% Titre du chapitre
{0.5cm}% Séparation d'avec le corps du chapitre
{\MakeTextUppercase{#1}}% Code à exécuter avant le titre
{}% Code à exécuter après le titre

%% Les chapitres sans numéro apparaissent dans la table des matières aussi
\let\stdchapter\chapter
\renewcommand*\chapter{%
  \@ifstar{\starchapter}{\@dblarg\nostarchapter}}
\newcommand*\starchapter[1]{\addcontentsline{toc}{chapter}{#1}\stdchapter*{#1}}
\def\nostarchapter[#1]#2{\stdchapter[{#1}]{#2}}

%% ------------------------
%% Légende des figures
%% ------------------------
%% Pour une raison étrange, Babel hard-code l'usage de petites majuscules
%% pour le mot "Figure"; on doit donc le redéfinir
%% (cf. http://tex.stackexchange.com/questions/73639/caption-formatting-with-babel-french)
\captionsetup[figure]{name=Figure}
\captionsetup[table]{name=Tableau}
\renewcommand{\captionfont}{\normalfont\small\bfseries}

%% ------------------------
%% Style de la table des matières
%% ------------------------
\renewcommand{\cfttoctitlefont}{\hfill\normalfont\bfseries\MakeUppercase}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftloftitlefont}{\hfill\normalfont\bfseries\MakeUppercase}
\renewcommand{\cftafterloftitle}{\hfill}
\renewcommand{\cftlottitlefont}{\hfill\normalfont\bfseries\MakeUppercase}
\renewcommand{\cftafterlottitle}{\hfill}

\setcounter{tocdepth}{1}
\renewcommand{\cftchapfont}{\normalfont\bfseries}

%% ------------------------
%% Style de la page couverture
%% ------------------------
\renewcommand{\maketitle}{%
\begin{titlepage}
\begin{center}
\begin{spacing}{2}
\includegraphics[width=1.5in]{uqac-logo}

\vfill

\textbf{\MakeTextUppercase{\@uqacpdcnomdoc{}}}\\
\MakeTextUppercase{présenté\@uqacpdcaccord{} à}\\
\MakeTextUppercase{l'Université du Québec à Chicoutimi}\\
\MakeTextUppercase{comme exigence partielle}\\
\MakeTextUppercase{\@uqacpdcnomprogramme}\\

\vfill

\textbf{\MakeTextUppercase{par}}\\
\MakeTextUppercase{\@author} \\
%B.A.A.

\vfill

\textbf{\MakeTextUppercase{\@title}}

\vfill

\MakeTextUppercase{\@date}
\end{spacing}
\end{center}
\end{titlepage}
}

%% ------------------------
%% Les redéfinitions suivantes nécessitent le package etoolbox
%% ------------------------
\RequirePackage{etoolbox}

%% Environnements verbatim à simple interligne par défaut
\BeforeBeginEnvironment{verbatim}{\def\baselinestretch{1}}

%% ------------------------
%% Ceci sert à corriger un bug
%% de la version 2.10.1 du package titlesec qui fait disparaître
%% les numéros de sections.
%% https://tex.stackexchange.com/a/300259
%% ------------------------
\RequirePackage{etoolbox}
\makeatletter
\patchcmd{\ttlh@hang}{\parindent\z@}{\parindent\z@\leavevmode}{}{}
\patchcmd{\ttlh@hang}{\noindent}{}{}{}
\makeatother

%% Codes pour jEdit
%% :mode=latex:wrap=none:
