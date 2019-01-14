# You can change the pdf viewer to your preferred
# one by commenting every line beginning by
# `PDFVIEWER' except the one with your pdf viewer
#PDFVIEWER=evince # GNOME
#PDFVIEWER=okular # KDE
#PDFVIEWER=xpdf # lightweight
PDFVIEWER=xdg-open # Default pdf viewer - GNU/Linux
#PDFVIEWER=open # Default pdf viewer - Mac OS
MAIN_NAME=how_to_contribute
PDF_NAME=$(MAIN_NAME).pdf
OUT_MAIN_NAME=How_to_Contribute

# You want latexmk to *always* run, because make does not have all the info.
.PHONY: clean

# If you want the pdf to be opened by your preferred pdf viewer
# after `$ make', comment the following line and uncomment the
# line after
#default: all
#default: show

all: $(PDF_NAME) clean

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interactive=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

# Other depences are gessed automatically by latexmk
# see http://tex.stackexchange.com/questions/40738/how-to-properly-make-a-latex-project
$(PDF_NAME): $(MAIN_NAME).tex
	latexmk -pdf -pdflatex="pdflatex -shell-escape -enable-write18" -use-make $(MAIN_NAME).tex

# Supprime les fichiers auxilliaires
clean:
	latexmk -c
	rm -rf *.aux *.fdb_latexmk *.log *.out *.bbl *.run.xml *.toc *.bcf *.nav *.snm *.vrb

show: $(PDF_NAME)
	$(PDFVIEWER) $(PDF_NAME) 2> /dev/null &

release: all
	$(eval MYPATH:=$(shell python3 ../mysmartcp.py -1))
	mkdir -p "${MYPATH}"
	cp  "$(MAIN_NAME).pdf" "${MYPATH}/$(OUT_MAIN_NAME).pdf"
