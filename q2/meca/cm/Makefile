#PDFVIEWER=xpdf
PDFVIEWER=evince
ROOT=../../..
MAIN_NAME=meca
QUADRI=q2
EXTENTION=pdf # EXT is already taken by LaTeX.mk
PATH_TO_PDF=releases/$(QUADRI)/$(MAIN_NAME)
PDF_NAME=$(MAIN_NAME)_$(QUADRI).$(EXTENTION)

default: show

include LaTeX.mk

show: $(MAIN_NAME).$(EXTENTION)
	$(PDFVIEWER) $(MAIN_NAME).$(EXTENTION) 2> /dev/null &

release:
	cp $(MAIN_NAME).$(EXTENTION) $(ROOT)/$(PATH_TO_PDF)/$(PDF_NAME)
