# ---------------------------------------
# Un makefile simple pour produire la thèse
# Auteur: Sylvain Hallé
# ---------------------------------------
.DEFAULT_GOAL := all

ifeq ($(OS),Windows_NT)
  RM = cmd /C del /Q /F
  RRM = cmd /C rmdir /Q /S
else
  RM = rm -f
  RRM = rm -f -r
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
	$(RM) *.aux *.log *.blg *.bbl *.dvi *.spl *.out *.toc *.lof *.lot *.idx *~

flush: clean
	$(RM) $(FILENAME).pdf

.PHONY : all clean once install flush help
