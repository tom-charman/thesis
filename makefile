# You want latexmk to *always* run, because make does not have all the info.
# Also, include non-file targets in .PHONY so they are run regardless of any
# file of the given name existing.
.PHONY: thesis.pdf introduction.pdf phys-theory.pdf detector.pdf machine-learning.pdf analysis-methodology.pdf background-modelling.pdf results.pdf conclusion.pdf all clean directories

# The first rule in a Makefile is the one executed by default ("make"). It
# should always be the "all" rule, so that "make" and "make all" are identical.
all: thesis.pdf introduction.pdf theory.pdf detector.pdf machine-learning.pdf analysis-methodology.pdf background-modelling.pdf results.pdf conclusion.pdf all clean directories

# CUSTOM BUILD RULES

# In case you didn't know, '$@' is a variable holding the name of the target,
# and '$<' is a variable holding the (first) dependency of a rule.
# "raw2tex" and "dat2tex" are just placeholders for whatever custom steps
# you might have.

#%.tex: %.raw
#        ./raw2tex $< > $@
#
#%.tex: %.dat
#        ./dat2tex $< > $@


# OPTIONS

DIR           = $(shell pwd)
LATEXMK       = latexmk
OPTIONS       = -pdf -pdflatex="lualatex" -use-make -f

# MAIN

THESIS        = -jobname=BUILD/thesis thesis.tex

# CHAPTERS
INTRODUCTION  = -jobname=BUILD/introduction 01-introduction/introduction.tex
THEORY        = -jobname=BUILD/theory 02-phys-theory/theory.tex
DETECTOR      = -jobname=BUILD/detector 03-detector/detector.tex
ML            = -jobname=BUILD/machine-learning 04-machine-learning/machine-learning.tex
METHOD        = -jobname=BUILD/method 05-analysis-methodology/method.tex
MODELLING     = -jobname=BUILD/modelling 06-background-modelling/modelling.tex
RESULTS       = -jobname=BUILD/results 07-results/results.tex
CONCLUSION    = -jobname=BUILD/conclusion 08-conclusion/conclusion.tex

# TIDYING
CLEAN     = -C thesis.pdf introduction.pdf theory.pdf detector.pdf machine-learning.pdf method.pdf modelling.pdf results.pdf conclusion.pdf
MKDIR = mkdir -p
OUT_DIR = BUILD

# -pdf tells latexmk to generate PDF directly (instead of DVI).
# -pdflatex="" tells latexmk to call a specific backend with specific options.
# -use-make tells latexmk to call make for generating missing files.

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

method.pdf: 05-analysis-methodology/method.tex directories
	$(LATEXMK) $(OPTIONS) $(METHOD) && mv BUILD/method.pdf .

modelling.pdf: 06-background-modelling/modelling.tex directories
	$(LATEXMK) $(OPTIONS) $(MODELLING) && mv BUILD/modelling.pdf .

results.pdf: 07-results/results.tex directories
	$(LATEXMK) $(OPTIONS) $(RESULTS) && mv BUILD/results.pdf .

conclusion.pdf: 08-conclusion/conclusion.tex directories
	$(LATEXMK) $(OPTIONS) $(CONCLUSION) && mv BUILD/conclusion.pdf .

clean:
	if [ -d "BUILD" ]; then \
	rm -r BUILD; \
	fi

