%option noyywrap yylineno
%{
	#include "stdio.h"
	#include <sys/stat.h>
	#import <Foundation/Foundation.h>
	#include "parse.h"

	NSMutableDictionary *languages,*categories,*currCategory,*currPhrase;

	enum {SECTION_HEADER,NATIVE_CELL,ENG_CELL,NULL_CELL} currentState;
	int sectionNumber;

	void writeCurrentCategory();
%}

%%
"SECTION "[^\t\n]* {
	writeCurrentCategory();
	sectionNumber = atoi(yytext+8);
	currentState = SECTION_HEADER;

	currCategory = [[NSMutableDictionary alloc] init];
}

^[0-9]+ {
	currPhrase = [NSMutableDictionary dictionary];
	[currCategory setValue:currPhrase forKey:[NSString stringWithUTF8String: yytext]];
	currentState = NATIVE_CELL;
}

\t {}
\n {
	currentState = (currentState == NATIVE_CELL ? ENG_CELL : NULL_CELL);
}

[^\t\n(//)]* {
	int phraseId = 0;
	switch(currentState) {
		case SECTION_HEADER:
			[categories setValue:[NSNumber numberWithInt:sectionNumber] forKey:[NSString stringWithCString:yytext encoding:NSUTF8StringEncoding]];
			break;
		case NATIVE_CELL:
			[currPhrase setValue:[NSString stringWithCString:yytext encoding:NSUTF8StringEncoding] forKey:@"native"];
			break;
		case ENG_CELL:
			[currPhrase setValue:[NSString stringWithCString:yytext encoding:NSUTF8StringEncoding] forKey:@"english"];
			break;
		default: break;
	}
}
<<EOF>>	{yyterminate();}

%%
/*
 +LanguageFiles
  +Language1
   -1.plist
   -2.plist
  +Language2
	....
  -languages.plist
*/
void writeCurrentCategory() {
	if(!currCategory) return;
	[currCategory writeToFile:[NSString stringWithFormat:@"%d.plist",sectionNumber] atomically:YES];

	[currCategory release];
	currCategory=nil;
}

int main(int argc, char **argv) {
	languages = [[NSMutableDictionary alloc] init];
	mkdir("LanguageFiles",0777);
	chdir("LanguageFiles");
	for(int i=1; i < argc; i++) {
		NSAutoreleasePool *pl = [[NSAutoreleasePool alloc] init];

		//Setup this language's stuff
		NSString * fileName = [NSString stringWithUTF8String:argv[i]]
			, *language = [fileName stringByDeletingPathExtension]
			, *path = [NSString stringWithFormat:@"../%@",fileName];

		if(!(categories = [languages valueForKey:language])) {
			categories = [[NSMutableDictionary alloc] init];
			[languages setValue:categories forKey:language];
		}

		//Parse the file
		FILE *f = fopen([path UTF8String],"r");
		if(!f) {
			fprintf(stderr, "File :'%s' doesn't exist\n", [fileName UTF8String]);
			continue;
		} 
		mkdir([language UTF8String], 0777);
		chdir([language UTF8String]); {

			yy_switch_to_buffer(yy_create_buffer(f,YY_BUF_SIZE));
			yylex();

			writeCurrentCategory();

		} chdir("..");

		[pl drain];
	}
	[languages writeToFile:@"languages.plist" atomically:YES];
	return 0;
}