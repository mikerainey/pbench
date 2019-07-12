
PBENCH_PATH=.
OCAML_PBENCH_PATH=$(PBENCH_PATH)/ocaml/cli

BINARIES=prun pplot

all: $(BINARIES)


##################################################################
# C Binaries

prun_timeout:
	make -C timeout


##################################################################
# OCaml Binaries

include Makefile_common

prun: prun_timeout
	cp timeout/prun_timeout $(PBENCH_PATH)

prun: $(OCAML_PBENCH_PATH)/prun.pbench
	cp $< $@ 

pplot: $(OCAML_PBENCH_PATH)/pplot.pbench
	cp $< $@ 

##############################################################################
# Cleaning

clean: pbench_clean
	rm -f $(BINARIES)
	rm -f $(OCAML_PBENCH_PATH)/*.pbench


##############################################################################
# Installation in opam prefix or in /usr/local/bin folder

# PREFIX := $(shell opam config var prefix)/bin
# ifeq ($(PREFIX),)
# 	PREFIX := /usr/local/bin
# endif

# install: all
# 	install $(BINARIES) $(PREFIX)

# uninstall:
# 	rm -f $(BINARIES)



