# ---------------------------------------
# Un makefile simple pour produire la thèse
# Auteur: Sylvain Hallé
# ---------------------------------------
FILENAME = these
INSTALLDIR=tex/latex/uqac-these

$(FILENAME).pdf: $(FILENAME).tex
	pdflatex $(FILENAME).tex

help:
	@echo 'Makefile pour compiler la thèse de l\'UQAC                             '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make once                        compile la thèse une fois          '
	@echo '   make all                         compile au complet (3x avec BibTeX)'
	@echo '   make clean                       efface les fichiers temporaires    '
	@echo '   make flush                       clean + efface le pdf de la thèse  '
	@echo '   make install                     installe la classe dans l\'arbre   '
	@echo '                                      texmf local                      '
	@echo '                                                                       '

all:
	pdflatex $(FILENAME).tex
	bibtex $(FILENAME)
	pdflatex $(FILENAME).tex
	pdflatex $(FILENAME).tex

once:
	pdflatex $(FILENAME).tex

install:
	TEXHOME:=$(shell kpsewhich --var-value=TEXMFHOME)
	-mkdir $(TEXHOME)/$(INSTALLDIR)
	cp uqac-these.cls theseuqam.bst logo-uqac.pdf $(TEXHOME)/$(INSTALLDIR)/

clean:
	rm -f *.aux *.log *.blg *.bbl *.dvi *.spl *.out *.toc *.lof *.lot *~

flush: clean
	rm $(FILENAME).pdf

.PHONY : all clean once install flush help
