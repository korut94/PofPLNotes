#Author: Polonio Davide <poloniodavide@gmail.com>
#License: GPLv3

OUTPUT_NAME= PofPL
LIST_NAME= lessons.tex
PATH_OF_CONTENTS= res/fLessons
COMPILER_OPTIONS= pdflatex -interaction=nonstopmode
MAIN_FILE= main

SHELL := /bin/bash #Need bash not shell

all: compile

compile: clean
	set -e; \
	function generatePdf () { \
	  pdflatex $(MAIN_FILE); \
  }; \
	if [[ -a "res/$(LIST_NAME)" ]]; then echo "Removing res/$(LIST_NAME)"; \
		rm res/$(LIST_NAME); fi; \
	for i in $(sort $(wildcard $(PATH_OF_CONTENTS)/*.tex)); do \
		echo "Adding $$i into $(LIST_NAME)"; \
		echo "\input{$$i}" >> res/$(LIST_NAME); \
	done; \
	for j in {1..2}; do \
	  generatePdf; \
  done; \
	for k in {1..2}; do \
	  pdflatex $(MAIN_FILE); \
  done; \
	mv $(MAIN_FILE).pdf $(OUTPUT_NAME).pdf;

clean:
	git clean -Xfd
	if [[ -a "$(OUTPUT_NAME)" ]]; then rm -rv $(OUTPUT_NAME)/; fi;
