PROJECT = blog_code

DEPS = cowboy erlydtl jiffy lager sync
dep_erlydtl = git git@github.com:truqu/erlydtl.git master

include erlang.mk

.PHONY: elm

elm:
	$(MAKE) -C elm
	mkdir -p priv/js
	cp elm/app.js priv/js/app.js

elm-clean:
	$(MAKE) -C elm clean

elm-watch:
	find elm/ -name *.elm -type f | grep -v elm-stuff | entr make elm
