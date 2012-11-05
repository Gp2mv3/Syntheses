# You can change the pdf viewer to your preferred
# one by commenting every line beginning by
# `PDFVIEWER' except the one with your pdf viewer
PDFVIEWER=evince # GNOME
#PDFVIEWER=okular # KDE
#PDFVIEWER=xpdf # lightweight
#PDFVIEWER=open # Mac OS
ROOT=../../..
EXT=pdf
PATH_TO_PDF=$(QUADRI)/$(MAIN_NAME)
PDF_NAME=$(MAIN_NAME)_$(QUADRI).$(EXT)

# If you want the pdf to be opened by your preferred pdf viewer
# after `$ make', comment the following line and uncomment the
# line after
default: all
#default: show

all: $(MAIN_NAME).$(EXT)

$(MAIN_NAME).$(EXT): $(MAIN_NAME).tex ../../lib.tex
	pdflatex -shell-escape -enable-write18 $(MAIN_NAME).tex

clean:
	$(RM) *.aux *.log *.out *.toc

show: $(MAIN_NAME).$(EXT)
	$(PDFVIEWER) $(MAIN_NAME).$(EXT) 2> /dev/null &

release: $(MAIN_NAME).$(EXT)
	cd ../..; ./update_dropbox.sh $(QUADRI) $(MAIN_NAME)

addpdf: release
	git add $(ROOT)/$(PATH_TO_PDF)/$(PDF_NAME)

addtex:
	git add $(MAIN_NAME).tex

add: addpdf addtex
