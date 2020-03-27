.PHONY: all clean help settings

IPYNB=$(wildcard */*.ipynb)
IPYNB_BASE=$(notdir $(IPYNB))
HTML=$(IPYNB_BASE:%.ipynb=notebooks/%.html)
# HTML=$(patsubst %.ipynb,notebooks/%.html,$(IPYNB))

## all : regenerate all results.
all : index.html

index.html : $(HTML)
	tree notebooks -H 'notebooks' -T 'Teaching notebooks' --charset utf-8 --noreport > index.html

## results/%.csv : regenerate result for any book.
notebooks/%.html : */%.ipynb #$(IPYNB)
	@echo $^
	jupyter nbconvert $^ --to html_toc --output-dir notebooks/ --ExtractOutputPreprocessor.enabled=False
	@echo

## clean : remove all generated files.
clean :
	rm $(HTML) index.html

## settings : show variables' values.
settings :
	@echo IPYNB: $(IPYNB)
	@echo IPYNB_BASE: $(IPYNB_BASE)
	@echo HTML: $(HTML)

## help : show this message.
help :
	@grep '^##' ./Makefile
