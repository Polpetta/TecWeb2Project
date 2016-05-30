#Author: Polonio Davide <poloniodavide@gmail.com>
#License: GPLv3

OUTPUT_NAME= TecWeb2Project
LIST_NAME= listOfSections.tex
PATH_OF_CONTENTS= res/sections

all:
	rm res/$(LIST_NAME); \
	for i in $(sort $(wildcard res/sections/*.tex)); do \
		echo "Adding $$i into $(LIST_NAME)"; \
		echo "\input{$$i}" >> res/$(LIST_NAME); \
	done; \
	latexmk -jobname=$(OUTPUT_NAME) -pdflatex='pdflatex -interaction=nonstopmode' -pdf main.tex

clean:
	git clean -Xfd && echo "Clean complete"
