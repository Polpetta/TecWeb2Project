#Author: Polonio Davide <poloniodavide@gmail.com>
#License: GPLv3

OUTPUT_NAME= TecWeb2Project
LIST_NAME= listOfSections.tex
PATH_OF_CONTENTS= res/sections

all: compile zip

compile:
	set -e; \
	if [[ -a $(LIST_NAME) ]]; then rm res/$(LIST_NAME); fi; \
	for i in $(sort $(wildcard res/sections/*.tex)); do \
		echo "Adding $$i into $(LIST_NAME)"; \
		echo "\input{$$i}" >> res/$(LIST_NAME); \
	done; \
	latexmk -jobname=$(OUTPUT_NAME) -pdflatex='pdflatex -interaction=nonstopmode' -pdf main.tex;

clean:
	git clean -Xfd
	if [[ -a $(OUTPUT_NAME) ]]; then rm -rv $(OUTPUT_NAME)/; fi;

zip: compile
	set -e; \
	mkdir $(OUTPUT_NAME)/; \
	mkdir $(OUTPUT_NAME)/Immagini; \
	cp res/img/* $(OUTPUT_NAME)/Immagini/; \
	cp $(OUTPUT_NAME).pdf $(OUTPUT_NAME)/Relazione.pdf; \
	zip -r $(OUTPUT_NAME).zip $(OUTPUT_NAME)/*
