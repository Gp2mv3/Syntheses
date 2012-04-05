#PDFVIEWER='xpdf'
PDFVIEWER=evince
ROOT=../../..
PATH_TO_PDF=releases/q2/meca
PDF_NAME=meca_q2.pdf
MAIN_NAME=meca

default: show

include LaTeX.mk

show: meca.pdf
	$(PDFVIEWER) $(MAIN_NAME).pdf 2> /dev/null &

release:
	cp $(MAIN_NAME).pdf $(ROOT)/$(PATH_TO_PDF)/$(PDF_NAME)
