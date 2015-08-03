PROJECT = blog_code

DEPS = cowboy erlydtl jiffy lager sync
dep_cowboy = git git@github.com:ninenines/cowboy.git 1.0.1
dep_erlydtl = git git@github.com:erlydtl/erlydtl.git master
dep_jiffy = git git@github.com:truqu/jiffy.git master
dep_lager = git git@github.com:basho/lager.git 2.1.1
dep_sync = git git@github.com:inaka/sync.git elbrujohalcon.52.dtl

KERL_VERSION = 17.4

ifdef KERL_VERSION
  SHELL := /bin/bash
  KERL_PATH = $(shell kerl list installations | grep ${KERL_VERSION} | perl -pe 's/^[^ ]* //')
  PATH := $(KERL_PATH)/bin:$(PATH)
endif

include erlang.mk

.PHONY: elm less

elm:
	$(MAKE) -C elm
	npm run-script uglify

elm-clean:
	$(MAKE) -C elm clean

elm-watch:
	find elm/ -name *.elm -type f | grep -v elm-stuff | entr make elm
