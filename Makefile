SOURCES=diff_match_patch.ml
PACKAGE=diff_match_patch

.PHONY: clean install uninstall

all:  $(PACKAGE)
	cd $(PACKAGE) && make all doc

$(PACKAGE): $(patsubst %.ml, %.cmxs, $(SOURCES))
	goji generate $^

%.cmxs: %.ml
	ocamlfind ocamlopt -package goji_lib -shared $< -o $@

install: $(PACKAGE)
	cd $(PACKAGE) && make install

uninstall: $(PACKAGE)
	cd $(PACKAGE) && make uninstall

reinstall: $(PACKAGE) uninstall install

clean:
	$(RM) -rf $(PACKAGE)
	$(RM) -rf *~ *.cm* *.o
