.PHONY: all clean help settings

IPYNB=$(wildcard */*.ipynb)
IPYNB_BASE=$(notdir $(IPYNB))
HTML=$(IPYNB_BASE:%.ipynb=notebooks/%.html)
# HTML=$(patsubst %.ipynb,notebooks/%.html,$(IPYNB))

## all : Generate all targets
all : index.html

index.html : $(HTML)
	tree notebooks -H 'notebooks' -T 'Teaching notebooks' --charset utf-8 --noreport > index.html

## notebooks/%.html : Generate HTML pages
notebooks/%.html : */%.ipynb
	@echo $^
	jupyter nbconvert $^ --to html_toc --output-dir notebooks/ --ExtractOutputPreprocessor.enabled=False
	@echo

## clean : Remove all generated files.
clean :
	rm $(HTML) index.html

## settings : Show variable names and values.
settings :
	@echo IPYNB: $(IPYNB)
	@echo IPYNB_BASE: $(IPYNB_BASE)
	@echo HTML: $(HTML)

## help : Show this message.
help :
	@grep '^##' ./Makefile
