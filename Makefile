# Makefile

ifeq ($(INSTALL),)
INSTALL := install -v 
endif

all:	help

install:	mw mwstat xcolor config.sh
	for f in $^; do $(INSTALL) $$f ~/bin/; done

.PHONY:	help

help:
	@echo $(MAKE) install

# EOF #
