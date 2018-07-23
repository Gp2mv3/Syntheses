# You can change the pdf viewer to your preferred
# one by commenting every line beginning by
# `PDFVIEWER' except the one with your pdf viewer
#PDFVIEWER=evince # GNOME
#PDFVIEWER=okular # KDE
#PDFVIEWER=xpdf # lightweight
PDFVIEWER=xdg-open # Default pdf viewer - GNU/Linux
#PDFVIEWER=open # Default pdf viewer - Mac OS
ifneq (,$(filter $(TYPE),exam test))
  MAIN_NAME=${NAME}-${OPTION}${CODE}-${TYPE}-${YEAR}-${MONTH}-${MINMAJ}
else
  MAIN_NAME=${NAME}-${OPTION}${CODE}-${TYPE}
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
else ifeq ($(SOL),none)
  SETSOL=-s sol=
endif
endif

define commit_function
	$(eval DATE:=$(shell echo "$(shell git log -n 1 --pretty=format:"%ai" $1.tex)" | sed -r 's/([0-9]+)-([0-9]+)-([0-9]+) ([0-9]+):([0-9]+):([0-9]+) ([^ ]+)/\3\/\2\/\1\ (\4\:\5\)/'))
	$(eval COMMIT_ID:=$(shell git log -1 --pretty=format:%h -- $1.tex))
endef

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
	$(call commit_function,$(MAIN_NAME))
ifneq (,$(filter $(TYPE),exam test exercises mcq))
	latexmk -pdf -pdflatex="pdflatex -shell-escape -enable-write18 \
	  '\def\Sol{false} \def\DATUM{${DATE}} \def\COMMITID{${COMMIT_ID}} \def\COMMITINFOS{} \input{%S}'" -use-make $(MAIN_NAME).tex
else
	latexmk -pdf -pdflatex="pdflatex -shell-escape -enable-write18 \
	  '\def\DATUM{${DATE}} \def\COMMITID{${COMMIT_ID}} \def\COMMITINFOS{} \input{%S}'"-use-make $(MAIN_NAME).tex
endif

$(MAIN_NAME_SOL).pdf: $(MAIN_NAME).tex
	$(call commit_function,$(MAIN_NAME))
	latexmk -pdf -pdflatex="pdflatex -jobname=$(MAIN_NAME_SOL) -shell-escape -enable-write18 \
	  '\def\Sol{true} \def\DATUM{${DATE}} \def\COMMITID{${COMMIT_ID}} \def\COMMITINFOS{} \input{%S}'" \
	    -use-make $(MAIN_NAME).tex -jobname=$(MAIN_NAME_SOL)

clean: cleanaux
	$(RM) *.pdf

cleanaux:
	latexmk -c
	$(RM) *.aux *.fdb_latexmk *.log *.out *.bbl *.toc

show: $(FULL)
	$(PDFVIEWER) $(FULL) 2> /dev/null &

release: all
ifneq (,$(filter $(TYPE),exam test))
	cd ../../../../../..; python3 ~/git/smartcp/smartcp.py --google-drive -vvvv -s \
	  quadri=$(QUADRI) -s name=$(NAME) -s option=$(OPTION) -s code=$(CODE) -s type=$(TYPE) -s year=$(YEAR) -s month=$(MONTH) -s minmaj=$(MINMAJ) $(SETSOL) config.yml
else
	cd ../../..; python3 ~/git/smartcp/smartcp.py --google-drive -vvvvv -s \
	  quadri=$(QUADRI) -s name=$(NAME) -s option=$(OPTION) -s code=$(CODE) -s type=$(TYPE) -s num=$(NUM) $(SETSOL) config.yml
endif

add:
git add $(MAIN_NAME).tex
