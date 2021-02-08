# You want latexmk to *always* run, because make does not have all the info.
# Also, include non-file targets in .PHONY so they are run regardless of any
# file of the given name existing.
.PHONY: thesis.pdf introduction.pdf phys-theory.pdf detector.pdf machine-learning.pdf modelling.pdf reconstruction.pdf fit.pdf results.pdf conclusion.pdf all clean directories

# The first rule in a Makefile is the one executed by default ("make"). It
# should always be the "all" rule, so that "make" and "make all" are identical.
all: thesis.pdf introduction.pdf theory.pdf detector.pdf machine-learning.pdf modelling.pdf  reconstruction.pdf fit.pdf results.pdf conclusion.pdf all clean directories

# OPTIONS

DIR           = $(shell pwd)
LATEXMK       = latexmk
OPTIONS       = -pdf -pdflatex="lualatex" -interaction=nonstopmode -use-make -f

# MAIN

THESIS        = -jobname=BUILD/thesis thesis.tex

# CHAPTERS
INTRODUCTION  = -jobname=BUILD/introduction 01-introduction/introduction.tex
THEORY        = -jobname=BUILD/theory 02-phys-theory/theory.tex
DETECTOR      = -jobname=BUILD/detector 03-detector/detector.tex
ML            = -jobname=BUILD/machine-learning 04-machine-learning/machine-learning.tex
RECON         = -jobname=BUILD/recon 05-reconstruction-and-selection/reconstruction-and-selection.tex
FIT           = -jobname=BUILD/fit 06-fit-models/fit-models.tex
MODELLING     = -jobname=BUILD/modelling 07-background-modelling/modelling.tex
RESULTS       = -jobname=BUILD/results 08-results/results.tex
CONCLUSION    = -jobname=BUILD/conclusion 09-conclusion/conclusion.tex

# TIDYING
CLEAN     = -C thesis.pdf introduction.pdf theory.pdf detector.pdf machine-learning.pdf recon.pdf fit.pdf  modelling.pdf results.pdf conclusion.pdf
MKDIR = mkdir -p
OUT_DIR = BUILD

# -interaction=nonstopmode keeps the pdflatex backend from stopping at a
# missing file reference and interactively asking you for an alternative.

directories:
	$(MKDIR) $(OUT_DIR)

thesis.pdf: thesis.tex directories
	$(LATEXMK) $(OPTIONS) $(THESIS) && mv BUILD/thesis.pdf .

introduction.pdf: 01-introduction/introduction.tex directories build
	$(LATEXMK) $(OPTIONS) $(INTRODUCTION) && mv BUILD/introduction.pdf .

theory.pdf: 02-phys-theory/theory.tex directories
	$(LATEXMK) $(OPTIONS) $(THEORY) && mv BUILD/theory.pdf .

detector.pdf: 03-detector/detector.tex directories
	$(LATEXMK) $(OPTIONS) $(DETECTOR) && mv BUILD/detector.pdf .

machine-learning.pdf: 04-machine-learning/machine-learning.tex directories
	$(LATEXMK) $(OPTIONS) $(ML) && mv BUILD/machine-learning.pdf .

reconstruction.pdf: 05-reconstruction-and-selection/reconstruction-and-selection.tex directories
	$(LATEXMK) $(OPTIONS) $(RECON) && mv BUILD/recon.pdf .

fit.pdf: 06-fit-models/fit-models.tex directories
	$(LATEXMK) $(OPTIONS) $(FIT) && mv BUILD/fit.pdf .

modelling.pdf: 07-background-modelling/modelling.tex directories
	$(LATEXMK) $(OPTIONS) $(MODELLING) && mv BUILD/modelling.pdf .

results.pdf: 08-results/results.tex directories
	$(LATEXMK) $(OPTIONS) $(RESULTS) && mv BUILD/results.pdf .

conclusion.pdf: 09-conclusion/conclusion.tex directories
	$(LATEXMK) $(OPTIONS) $(CONCLUSION) && mv BUILD/conclusion.pdf .

clean:
	if [ -d "BUILD" ]; then \
	rm -r BUILD; \
	fi

