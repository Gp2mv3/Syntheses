# You can change the pdf viewer to your preferred
# one by commenting every line beginning by
# `PDFVIEWER' except the one with your pdf viewer
#PDFVIEWER=evince # GNOME
#PDFVIEWER=okular # KDE
#PDFVIEWER=xpdf # lightweight
PDFVIEWER=xdg-open # Default pdf viewer - GNU/Linux
#PDFVIEWER=open # Default pdf viewer - Mac OS
MAIN_NAME=${COURSE}-${TYPE}
ifeq ($(TYPE),exam)
  MAIN_NAME=${COURSE}-${TYPE}-${YEAR}-${MONTH}
else
  MAIN_NAME=${COURSE}-${TYPE}
endif

ALL+=$(MAIN_NAME).pdf

MAIN_NAME_SOL=${MAIN_NAME}-Sol

ifeq ($(TYPE),exam)
  ALL+=$(MAIN_NAME_SOL).pdf
  FULL=${MAIN_NAME_SOL}.pdf
else
  FULL=${MAIN_NAME}.pdf
endif

# You want latexmk to *always* run, because make does not have all the info.
.PHONY: $(ALL)

# If you want the pdf to be opened by your preferred pdf viewer
# after `$ make', comment the following line and uncomment the
# line after
#default: all
default: show

all: $(ALL)

# MAIN LATEXMK RULE

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

# -interactive=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

$(MAIN_NAME).pdf: $(MAIN_NAME).tex
ifeq ($(TYPE),exam)
	latexmk -pdf -pdflatex="pdflatex -shell-escape -enable-write18 \
	  '\def\Sol{false} \input{%S}'" -use-make $(MAIN_NAME).tex
else
	latexmk -pdf -pdflatex="pdflatex -shell-escape -enable-write18" \
	  -use-make $(MAIN_NAME).tex
endif

$(MAIN_NAME_SOL).pdf: $(MAIN_NAME).tex
	latexmk -pdf -pdflatex="pdflatex -jobname=$(MAIN_NAME_SOL) -shell-escape \
	  -enable-write18 '\def\Sol{true} \input{%S}'" \
	  -use-make $(MAIN_NAME).tex -jobname=$(MAIN_NAME_SOL)


clean:
	latexmk -CA
	$(RM) *.aux *.fdb_latexmk *.log *.out *.pdf

show: $(FULL)
	$(PDFVIEWER) $(FULL) 2> /dev/null &

release: all
ifeq ($(TYPE),exam)
	cd ../../../../..; python3 ~/git/smartcp/smartcp.py -vvvv -s \
	  quadri=$(QUADRI) -s cours=$(COURSE) -s type=$(TYPE) -s year=$(YEAR) -s month=$(MONTH) config.yml
else
	cd ../../..; python3 ~/git/smartcp/smartcp.py -vv -s \
	  quadri=$(QUADRI) -s cours=$(COURSE) -s type=$(TYPE) config.yml
endif

add:
	git add $(MAIN_NAME).tex
