#Author: Polonio Davide <poloniodavide@gmail.com>
#License: GPLv3

OUTPUT_NAME= TecWeb2Project
LIST_NAME= listOfSections.tex
PATH_OF_CONTENTS= res/sections
COMPILER_OPTIONS= pdflatex -interaction=nonstopmode

SHELL := /bin/bash #Need bash not shell

all: compile zip

compile:
	set -e; \
	if [[ -a "res/$(LIST_NAME)" ]]; then echo "Removing res/$(LIST_NAME)"; \
		rm res/$(LIST_NAME); fi; \
	for i in $(sort $(wildcard $(PATH_OF_CONTENTS)/*.tex)); do \
		echo "Adding $$i into $(LIST_NAME)"; \
		echo "\input{$$i}" >> res/$(LIST_NAME); \
	done; \
	latexmk -jobname=$(OUTPUT_NAME) -pdflatex='$(COMPILER_OPTIONS)' -pdf main.tex;

clean:
	git clean -Xfd
	if [[ -a "$(OUTPUT_NAME)" ]]; then rm -rv $(OUTPUT_NAME)/; fi;

zip: compile
	set -e; \
	mkdir $(OUTPUT_NAME)/; \
	mkdir $(OUTPUT_NAME)/Immagini; \
	cp res/img/* $(OUTPUT_NAME)/Immagini/; \
	cp $(OUTPUT_NAME).pdf $(OUTPUT_NAME)/Relazione.pdf; \
	zip -r $(OUTPUT_NAME).zip $(OUTPUT_NAME)/*
