# You can change the pdf viewer to your preferred
# one by commenting every line beginning by
# `PDFVIEWER' except the one with your pdf viewer
PDFVIEWER=evince
#PDFVIEWER=okular
#PDFVIEWER=xpdf
ROOT=../../../..
MAIN_NAME=math
QUADRI=q2
EXTENTION=pdf # EXT is already taken by LaTeX.mk
PATH_TO_PDF=$(QUADRI)/$(MAIN_NAME)
PDF_NAME=$(MAIN_NAME)_$(QUADRI).$(EXTENTION)

# If you want the pdf to be opened by your preferred pdf viewer
# after `$ make', comment the following line and uncomment the
# line after
default: $(MAIN_NAME).$(EXTENTION)
#default: show

# If you want a more complete Makefile, install the `latex-make' package,
# comment the 2 following lines and uncomment the line after
$(MAIN_NAME).$(EXTENTION): $(MAIN_NAME).tex
	pdflatex $(MAIN_NAME).tex
#include LaTeX.mk

show: $(MAIN_NAME).$(EXTENTION)
	$(PDFVIEWER) $(MAIN_NAME).$(EXTENTION) 2> /dev/null &

release: $(MAIN_NAME).$(EXTENTION)
	cp $(MAIN_NAME).$(EXTENTION) $(ROOT)/$(PATH_TO_PDF)/$(PDF_NAME)
