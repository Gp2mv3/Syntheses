ifneq (,$(filter $(TYPE),exam test))
  MAIN_NAME=${NAME}-${OPTION}${CODE}-${TYPE}-${YEAR}-${MONTH}-${MINMAJ}
else
  MAIN_NAME=${NAME}-${OPTION}${CODE}-${TYPE}
endif

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
	OUT_MAIN_NAME:=Books-${NAME}-${OPTION}${CODE}
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

ifdef SOL
ifeq ($(SOL),only)
  SETSOL=-s sol=-Sol
else ifeq ($(SOL),none)
  SETSOL=-s sol=
endif
endif

ifneq (,$(filter $(TYPE),exam test exercises mcq))
  ALL=$(MAIN_NAME).pdf $(MAIN_NAME_SOL).pdf
  OUT_MAIN_NAME_SOL=${OUT_MAIN_NAME}-Sol
else
  ALL=${MAIN_NAME}.pdf
endif

define commit_function
	$(eval DATE:=$(shell echo "$(shell git log -n 1 --pretty=format:"%ai" $1.tex)" | sed -r 's/([0-9]+)-([0-9]+)-([0-9]+) ([0-9]+):([0-9]+):([0-9]+) ([^ ]+)/\3\/\2\/\1\ (\4\:\5\)/'))
	$(eval COMMIT_ID:=$(shell git log -1 --pretty=format:%h -- $1.tex))
endef

SMARTCP:=$(BASE_DIR)../../../mysmartcp.py

# 1e: make all
# 2e: make only out-of-date
# .PHONY: clean cleanaux $(ALL)
.PHONY: clean cleanaux

all: $(ALL) cleanaux

release: $(ALL) cleanaux

$(MAIN_NAME).pdf: $(MAIN_NAME).tex
	$(call commit_function,$(MAIN_NAME))
ifneq (,$(filter $(TYPE),exam test exercises mcq))
	latexmk -pdf $(PVC) -pdflatex="pdflatex -shell-escape -enable-write18 '\def\Sol{false} \def\DATUM{${DATE}} \
	\def\COMMITID{${COMMIT_ID}} \def\COMMITINFOS{} \input{%S}'" -use-make $(MAIN_NAME).tex
else
	latexmk -pdf $(PVC) -pdflatex="pdflatex -shell-escape -enable-write18 '\def\DATUM{${DATE}} \
	\def\COMMITID{${COMMIT_ID}} \def\COMMITINFOS{} \input{%S}'" -use-make $(MAIN_NAME).tex
endif
ifeq ($(MAKECMDGOALS),release)
	$(eval MYPATH:=$(shell python3 ${SMARTCP} ${INPUT}))
	mkdir -p "${MYPATH}"
	cp  "$(MAIN_NAME).pdf" "${MYPATH}/$(OUT_MAIN_NAME).pdf"
endif

$(MAIN_NAME_SOL).pdf: $(MAIN_NAME).tex
	$(call commit_function,$(MAIN_NAME))
	latexmk -pdf $(PVC) -pdflatex="pdflatex -jobname=$(MAIN_NAME_SOL) -shell-escape -enable-write18 '\def\Sol{true} \
	\def\DATUM{${DATE}} \def\COMMITINFOS{} \def\COMMITID{${COMMIT_ID}} \input{%S}'" -use-make $(MAIN_NAME).tex -jobname=$(MAIN_NAME_SOL)
ifeq ($(MAKECMDGOALS),release)
	$(eval MYPATH:=$(shell python3 ${SMARTCP} ${INPUT}))
	mkdir -p "${MYPATH}"
	cp "$(MAIN_NAME_SOL).pdf" "${MYPATH}/$(OUT_MAIN_NAME_SOL).pdf"
endif

# Supprime tout
clean: cleanaux
	rm -rf $(ALL)

# Supprime les fichiers auxilliaires
cleanaux:
	latexmk -c
	rm -rf *.aux *.fdb_latexmk *.log *.out *.bbl *.run.xml *.toc *.bcf
