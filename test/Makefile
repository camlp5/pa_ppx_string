WD=$(shell pwd)
TOP=..
include $(TOP)/config/Makefile

LAUNCH=../tools/LAUNCH
OCAMLFIND=$(LAUNCH) ocamlfind
NOT_OCAMLFIND=$(LAUNCH) not-ocamlfind
SYNTAX := camlp5o

PACKAGES := $(PACKAGES),pa_ppx_string,ounit2

all: ppx_string.exe

all-tests:: all
	mkdir -p _build && ./ppx_string.exe

ppx_string.exe: ppx_string.cmo
	$(OCAMLFIND) ocamlc $(OCAMLCFLAGS) -package $(PACKAGES) -linkpkg -linkall -o $@ $<

clean::
	rm -rf *.cm* _build
