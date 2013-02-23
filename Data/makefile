build : parse_phrases.l
	flex -o flex.m parse_phrases.l
	clang flex.m -lfl -framework Foundation -o parse_native_lang
	parse_native_lang Inupiaq.csv

clean :
	rm -r LanguageFiles flex.m
