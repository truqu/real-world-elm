PROJECT = blog_code

DEPS = cowboy erlydtl jiffy lager sync
dep_erlydtl = git git@github.com:truqu/erlydtl.git master

include erlang.mk

.PHONY: elm

elm:
	$(MAKE) -C elm
	npm run-script uglify

elm-clean:
	$(MAKE) -C elm clean

elm-watch:
	find elm/ -name *.elm -type f | grep -v elm-stuff | entr make elm
