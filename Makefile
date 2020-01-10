# Dossiers contenant un makefile
SUBDIRS := $(sort $(shell find src/ -name "Makefile"))
SUBDIRS := $(filter-out src/q1/info-FSAB1401/exam/2009/Juin/All/src/Makefile,$(SUBDIRS))

ifeq ($(MAKECMDGOALS),clean)
	COMPILE=make clean
else ifeq ($(MAKECMDGOALS),release)
	COMPILE=make release
else ifeq ($(MAKECMDGOALS),pdf)
	COMPILE=make pdf
else
	COMPILE=make
endif

ifneq (,$(filter $(MAKEMCGOALS),pvc))
	PVC:=-pvc
endif

.PHONY: all $(SUBDIRS) clean pvc

all: $(SUBDIRS)

$(SUBDIRS):
	$(COMPILE) -C $(dir $@)

clean: $(SUBDIRS)

release: $(SUBDIRS)

pvc: $(SUBDIRS)

pdf: $(SUBDIRS)

