default: app.js

ELM_FILES = $(shell find . -path ./elm-stuff -prune -o -type f -name '*.elm')

ELM_PATH := ../node_modules/elm/
PATH := $(ELM_PATH)/bin:$(PATH)

app.js: $(ELM_FILES)
	elm-make --yes App.elm --output app.js

clean-deps:
	rm -rf elm-stuff

clean:
	rm -f *.js
	rm -rf elm-stuff/build-artifacts
