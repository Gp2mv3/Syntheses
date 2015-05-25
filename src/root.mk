# You can change the pdf viewer to your preferred
# one by commenting every line beginning by
# `PDFVIEWER' except the one with your pdf viewer
#PDFVIEWER=evince # GNOME
#PDFVIEWER=okular # KDE
#PDFVIEWER=xpdf # lightweight
PDFVIEWER=xdg-open # Default pdf viewer - GNU/Linux
#PDFVIEWER=open # Default pdf viewer - Mac OS
MAIN_NAME=${COURSE}-${TYPE}
ifneq (,$(filter $(TYPE),exam test))
  MAIN_NAME=${COURSE}-${TYPE}-${YEAR}-${MONTH}-${MINMAJ}
else
  MAIN_NAME=${COURSE}-${TYPE}
endif

ALL+=$(MAIN_NAME).pdf

MAIN_NAME_SOL=${MAIN_NAME}-Sol

ifneq (,$(filter $(TYPE),exam test exercises mcq))
  ALL+=$(MAIN_NAME_SOL).pdf
  FULL=${MAIN_NAME_SOL}.pdf
else
  FULL=${MAIN_NAME}.pdf
endif

ifdef SOL
ifeq ($(SOL),only)
  SETSOL=-s sol=-Sol
else
  SETSOL=-s sol=
endif
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
ifneq (,$(filter $(TYPE),exam test exercises mcq))
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
ifneq (,$(filter $(TYPE),exam test))
	cd ../../../../../..; smartcp -vvvv -s \
	  quadri=$(QUADRI) -s cours=$(COURSE) -s type=$(TYPE) -s year=$(YEAR) -s month=$(MONTH) -s minmaj=$(MINMAJ) $(SETSOL) config.yml
else
	cd ../../..; smartcp -vv -s \
	  quadri=$(QUADRI) -s cours=$(COURSE) -s type=$(TYPE) $(SETSOL) config.yml
endif

add:
	git add $(MAIN_NAME).tex
