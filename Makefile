# ---------------------------------------
# Un makefile simple pour produire la thèse
# Auteur: Sylvain Hallé et Éric Laberge
# ---------------------------------------
.DEFAULT_GOAL := all

ifeq ($(OS),Windows_NT)
  RM = cmd /C del /Q /F
  RRM = cmd /C rmdir /Q /S
  CP = cmd /C cp
else
  RM = rm -f
  RRM = rm -f -r
  CP = cp
endif

FILENAME = these
INSTALLDIR=tex/latex/uqac-these

SRC=$(wildcard *.tex)

$(FILENAME).pdf: $(FILENAME).tex $(SRC)
	pdflatex $(FILENAME).tex

help:
	@echo "Makefile pour compiler la thèse de l'UQAC                              "
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make once                        compile la thèse une fois          '
	@echo '   make all                         compile au complet (3x avec BibTeX)'
	@echo '   make clean                       efface les fichiers temporaires    '
	@echo '   make flush                       clean + efface le pdf de la thèse  '
	@echo "   make install                     installe la classe dans l'arbre    "
	@echo '                                      texmf local                      '
	@echo "   make file=chapX.tex aspell       passe le correcteur Aspell sur le  "
	@echo '                                      fichier chapX.tex                '
	@echo "   make file=chapX.tex textidote    passe TeXtidote sur le fichier     "
	@echo '                                      chapX.tex                        '
	@echo '   make metadata                    ajoute le champ `Author` au PDF    '
	@echo '                                                                       '

all: $(SRC)
	pdflatex -interaction=batchmode $(FILENAME).tex
	bibtex $(FILENAME)
	pdflatex -interaction=batchmode $(FILENAME).tex
	pdflatex -interaction=batchmode $(FILENAME).tex

once: $(SRC)
	pdflatex -interaction=batchmode $(FILENAME).tex

install:
	TEXHOME:=$(shell kpsewhich --var-value=TEXMFHOME)
	-mkdir $(TEXHOME)/$(INSTALLDIR)
	cp uqac-these.cls theseuqam.bst logo-uqac.pdf $(TEXHOME)/$(INSTALLDIR)/

clean:
	$(RM) *.aux *.log *.blg *.bbl *.dvi *.spl *.out *.toc *.lof *.lot *.lol *.idx *~ *.bak

aspell:
	aspell --home-dir=. --lang=fr --mode=tex --add-tex-command="nsc p" --add-tex-command="citep op" --add-tex-command="citet op" check $(file)

textidote:
	textidote --check fr --read-all $(file)

metadata:
	pdftk $(FILENAME).pdf update_info_utf8 these.info output $(FILENAME)2.pdf
	$(CP) $(FILENAME)2.pdf $(FILENAME).pdf
	$(RM) $(FILENAME)2.pdf

flush: clean
	$(RM) $(FILENAME).pdf

.PHONY : all clean once install flush help aspell metadata
