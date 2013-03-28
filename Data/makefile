test : build run

run :
	bin/parse_native_lang data

build : src/parse_phrases.l src/parse_phrases.y
	lex -o src/flex.m src/parse_phrases.l
	yacc -d src/parse_phrases.y
	mv y.tab.c src/bison.m
	mv y.tab.h src/bison.h
	clang src/flex.m src/bison.m -lfl -framework Foundation -o bin/parse_native_lang
	rm src/bison.* src/flex.m

clean :
	rm -r LanguageFiles flex.m
