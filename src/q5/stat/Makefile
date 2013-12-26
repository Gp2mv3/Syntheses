MAIN_NAME=stat
ALL+=$(MAIN_NAME)_form.pdf
include ../q5.mk

$(MAIN_NAME)_skip.pdf: $(MAIN_NAME).tex
	latexmk -pdf -pdflatex="pdflatex -jobname=$(MAIN_NAME)_skip -shell-escape \
	  -enable-write18 '\def\skiptitlepage{} \def\skiptableofcontents{} \input{%S}'" \
	  -use-make $(MAIN_NAME).tex -jobname=$(MAIN_NAME)_skip

$(MAIN_NAME)_form.pdf: $(MAIN_NAME)_skip.pdf
	pdfnup $(MAIN_NAME)_skip.pdf
	mv $(MAIN_NAME)_skip-nup.pdf $(MAIN_NAME)_form.pdf
