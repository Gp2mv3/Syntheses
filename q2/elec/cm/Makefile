#PDFVIEWER=xpdf
#PDFVIEWER=evince
PDFVIEWER=okular
ROOT=../../..
MAIN_NAME=elec
QUADRI=q2
EXTENTION=pdf # EXT is already taken by LaTeX.mk
PATH_TO_PDF=releases/$(QUADRI)/$(MAIN_NAME)
PDF_NAME=$(MAIN_NAME)_$(QUADRI).$(EXTENTION)



#Didn't find LaTeX.mk so I've chage the "default" makefile

default: 
	pdflatex $(MAIN_NAME).tex

show: $(MAIN_NAME).$(EXTENTION)
	$(PDFVIEWER) $(MAIN_NAME).$(EXTENTION) 2> /dev/null &

release:
	cp $(MAIN_NAME).$(EXTENTION) $(ROOT)/$(PATH_TO_PDF)/$(PDF_NAME)
