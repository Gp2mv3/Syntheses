# Main name of the .tex file
ifneq (,$(filter $(TYPE),exam test))
  MAIN_NAME=${NAME}-${OPTION}${CODE}-${TYPE}-${YEAR}-${MONTH}-${MINMAJ}
else
  MAIN_NAME=${NAME}-${OPTION}${CODE}-${TYPE}
endif

# Out main name as it appears in after 'make release' (e.g. in the EPL-Drive)
ifeq ($(strip ${TYPE}),summary)
	ifdef NUM
		OUT_MAIN_NAME:=Synthèse${NUM}-${NAME}-${OPTION}${CODE}
	else
		OUT_MAIN_NAME:=Synthèse-${NAME}-${OPTION}${CODE}
	endif
else ifeq ($(strip ${TYPE}),notes)
	OUT_MAIN_NAME:=CM-${NAME}-${OPTION}${CODE}
else ifneq (,$(filter $(TYPE),exercises))
	ifdef NUM
		OUT_MAIN_NAME:=APE${NUM}-${NAME}-${OPTION}${CODE}
	else
		OUT_MAIN_NAME:=APE-${NAME}-${OPTION}${CODE}
	endif
	OUT_MAIN_NAME:=APE-${NAME}-${OPTION}${CODE}
else ifeq ($(strip ${TYPE}),mcq)
	OUT_MAIN_NAME:=QCM-${NAME}-${OPTION}${CODE}
else ifeq ($(strip ${TYPE}),errata)
	OUT_MAIN_NAME:=Errata-${NAME}-${OPTION}${CODE}
else ifeq ($(strip ${TYPE}),test)
	OUT_MAIN_NAME:=${OPTION}${CODE}-${YEAR}-${MONTH}
else ifeq ($(strip ${TYPE}),formulaire)
	ifdef NUM
		OUT_MAIN_NAME:=formulaire${NUM}-${NAME}-${OPTION}${CODE}
	else
		OUT_MAIN_NAME:=formulaire-${NAME}-${OPTION}${CODE}
	endif
else ifeq ($(strip ${TYPE}),exam)
	OUT_MAIN_NAME:=${OPTION}${CODE}-${YEAR}-${MONTH}
	ifneq (,$(filter $(strip ${MINMAJ}),Maj Majeure)) 
		OUT_MAIN_NAME:=$(strip $(OUT_MAIN_NAME))-Majeure
	else ifneq (,$(filter $(strip ${MINMAJ}),Min Mineure))
		OUT_MAIN_NAME:=$(strip $(OUT_MAIN_NAME))-Mineure
	endif
	ifneq (,$(filter $(strip ${NAME}),meca elec))
		OUT_MAIN_NAME:=$(strip $(OUT_MAIN_NAME))-${NAME}
	endif
endif

INPUT:=$(strip ${QUADRI} ${NAME} ${OPTION} ${CODE} ${TYPE} ${YEAR} ${MONTH})

MAIN_NAME_SOL=${MAIN_NAME}-Sol

ifneq (,$(filter $(TYPE),exam test exercises mcq))             # Filter exams, tests, exercises, mcq
  ALL=$(MAIN_NAME).pdf $(MAIN_NAME_SOL).pdf
  OUT_MAIN_NAME_SOL=${OUT_MAIN_NAME}-Sol
  ALL_RELEASE=release_$(MAIN_NAME) release_$(MAIN_NAME_SOL)
else                                                           # Filter summaries, notes
  ALL=${MAIN_NAME}.pdf
  ALL_RELEASE=release_$(MAIN_NAME)
endif

# Compute the date and ID of the last commit
define commit_function
	$(eval DATE:=$(shell echo "$(shell git log -n 1 --pretty=format:"%ai" $1.tex)" | sed -r 's/([0-9]+)-([0-9]+)-([0-9]+) ([0-9]+):([0-9]+):([0-9]+) ([^ ]+)/\3\/\2\/\1\ (\4\:\5\)/'))
	$(eval COMMIT_ID:=$(shell git log -1 --pretty=format:%h -- $1.tex))
endef

# Directory of the script mysmartcp.py
SMARTCP:=$(BASE_DIR)../../../mysmartcp.py

# 1e: make all
# 2e: make only out-of-date
# .PHONY: clean cleanaux $(ALL)
.PHONY: clean cleanaux

# Make the PDF with aux files
all: $(ALL)

# Make only the PDF without aux files
pdf: $(ALL) cleanaux

# Make the pdf without aux files and release (copy) the PDF towards another directory (e.g. the EPL-Drive)
release: $(ALL) cleanaux prerelease $(ALL_RELEASE)

prerelease:
	$(eval MYPATH:=$(shell python3 ${SMARTCP} ${INPUT})) # Obtain the path/location of the output folder for this PDF
	mkdir -p "${MYPATH}"                                 # Create the output folder (if not existing yet)

release_$(MAIN_NAME):
	cp "$(MAIN_NAME).pdf" "${MYPATH}/$(OUT_MAIN_NAME).pdf"         # Copy the PDF in the output folder

release_$(MAIN_NAME_SOL):
	cp "$(MAIN_NAME_SOL).pdf" "${MYPATH}/$(OUT_MAIN_NAME_SOL).pdf" # Copy the solution of the PDF in the output folder

# Compile the PDF
$(MAIN_NAME).pdf: $(MAIN_NAME).tex
	$(call commit_function,$(MAIN_NAME))
ifneq (,$(filter $(TYPE),exam test exercises mcq))
	latexmk -pdf $(PVC) -pdflatex="pdflatex -shell-escape -enable-write18 '\def\Sol{false} \def\DATUM{${DATE}} \
	\def\COMMITID{${COMMIT_ID}} \def\COMMITINFOS{} \input{%S}'" -use-make $(MAIN_NAME).tex
else
	latexmk -pdf $(PVC) -pdflatex="pdflatex -shell-escape -enable-write18 '\def\DATUM{${DATE}} \
	\def\COMMITID{${COMMIT_ID}} \def\COMMITINFOS{} \input{%S}'" -use-make $(MAIN_NAME).tex
endif

# Compile the solution of the PDF
$(MAIN_NAME_SOL).pdf: $(MAIN_NAME).tex
	$(call commit_function,$(MAIN_NAME))
	latexmk -pdf $(PVC) -pdflatex="pdflatex -jobname=$(MAIN_NAME_SOL) -shell-escape -enable-write18 '\def\Sol{true} \
	\def\DATUM{${DATE}} \def\COMMITINFOS{} \def\COMMITID{${COMMIT_ID}} \input{%S}'" -use-make $(MAIN_NAME).tex -jobname=$(MAIN_NAME_SOL)

# Remove all files associated to the .tex
clean: cleanaux
	rm -rf $(ALL)

# Remove only the aux files
cleanaux:
	latexmk -c
	rm -rf *.aux *.fdb_latexmk *.log *.out *.bbl *.run.xml *.toc *.bcf
	rm -rf *.pygstyle *.pygtex _minted*
