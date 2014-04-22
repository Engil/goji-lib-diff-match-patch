.PHONY: clean

all: example.js libs.js

%.js: %.byte
	js_of_ocaml -pretty $< -o $@

libs.js:
	goji jslink diff_match_patch -o $@

example.byte: example.ml
	ocamlfind ocamlc -g -custom \
							-syntax camlp4o \
          		-package diff_match_patch,js_of_ocaml,js_of_ocaml.syntax \
          		$< -linkpkg -o $@

clean:
	rm -f *~ main.js libs.js *.byte *.cm*
