%{
	// C Libraries
	#include <stdio.h>
	#include <sys/stat.h>
	#import <Foundation/Foundation.h>
	
	// Prototypes to keep the compiler happy
	void yyerror (const char *error);
	int  yylex ();
	void yyrestart(FILE *);

	NSMutableDictionary *language;
	NSMutableArray *sections;

	void writeCurrentCategory();

	int sectionNumber;

	extern int yylineno;

	void setLexToTxt(BOOL isTxt);

//	#define TEST_TOKENS
%}

%union {
	int iVal;
	char* str;
	id obj;
	struct {
		id obj;
		int iVal;
	} id_int;
}

// NL is NewLine
%token NL SLASH

%token <iVal> NUMBER SECTION CHAR
%token <obj> CELL endPAREN midPAREN

%type <obj> opt_endPAREN section_desc phrases cell definitions definition phrase section

%%

///////////////////////
// PROGRAM STRUCTURE //
///////////////////////


/*
 +LanguageFiles
  -<language1>.plist
  -<language2>.plist
  -languages.plist
*/
file : sectionList 

sectionList : sectionList section {
	[sections addObject:$2];
} | section {
	[sections addObject:$1];
};

section : SECTION section_desc opt_endPAREN NLs phrases {
	$$ = [NSDictionary dictionaryWithObjectsAndKeys:
			$5, @"phrases",
			[NSString stringWithFormat:@"%d",$1], @"ID",
			$2, @"title",
			$3, @"subtitle", nil //I think that if $3 is nil it will stop there
		];
	for(int i=0; i<[$5 count]; i++) {
		NSMutableDictionary * phrase = [$5 objectAtIndex:i];
		[phrase setObject:[NSString stringWithFormat:@"%d.%@",$1,[phrase objectForKey:@"ID"]] forKey:@"ID"];
	}
};

phrases : phrases phrase {
	[($$ = $1) addObject:$2];
} | phrase {
	$$ = [NSMutableArray arrayWithObject:$1];
};

phrase : NUMBER definitions NLs definitions NLs {
	$$ = [NSMutableDictionary dictionaryWithObjectsAndKeys:
			[NSString stringWithFormat:@"%d",$1], @"ID",
			$2, @"native",
			$4, @"english", nil
		];
}

definitions : definitions SLASH definition {
	[($$=$1) addObject:$3];
} | definition {
	$$ = [NSMutableArray arrayWithObject:$1];
}

definition : cell {$$ = $1;};

// BASIC TYPES

opt_endPAREN : endPAREN {
	$$ = $1;
} | {$$ = nil;};

section_desc : CELL {
	$$ = $1;
};

NLs : NL NLs | NL;

cell : CELL 
		{$$ = $1;}
	| CELL cell 
		{$$ = [NSString stringWithFormat:@"%@%@", $1, $2];} 
	| midPAREN cell 
		{$$ = [NSString stringWithFormat:@"%@%@", $1, $2];}
	| CHAR cell 
		{$$ = [NSString stringWithFormat:@"%c%@", $1, $2];}
	| endPAREN 
		{$$ = $1;};
 
%%

void printClasses(id collection) {
	if([collection isKindOfClass:[NSArray class]]) {
		for(id obj in collection) {
			printClasses(obj);
		}
	}
	else if([collection isKindOfClass:[NSDictionary class]]) {
		for(id key in collection) {
			printClasses(key);
			printClasses([collection objectForKey:key]);
		}
	}
	else {
		NSLog(@"%@", [collection class]);
	}
}

int main(int argc, char **argv) {
	NSMutableArray * languages = [[NSMutableArray alloc] init];
	NSFileManager * fm = [NSFileManager defaultManager];
	mkdir("LanguageFiles",0777);

	if(argc < 2) {
		printf("Usage: %s [data directory]\n",argv[0]);
		return 0;
	}

	NSString *dataDir = [NSString stringWithUTF8String:argv[1]];

	for(NSString * file in [fm subpathsAtPath:dataDir]) {
		if([[file pathExtension] caseInsensitiveCompare:@"csv"] == NSOrderedSame) {
			[languages addObject:[file stringByDeletingPathExtension]];
		}
	}

	[languages writeToFile:@"LanguageFiles/languages.plist" atomically:YES];

	for(NSString * l in languages) {
		NSString * txtFile = [NSString stringWithFormat:@"%@/%@.txt",dataDir,l],
				* csvFile = [NSString stringWithFormat:@"%@/%@.csv",dataDir,l];

		sections = [NSMutableArray array];
		language = [NSMutableDictionary dictionaryWithObject:sections forKey:@"sections"];

		if([fm isReadableFileAtPath:txtFile]) {
			FILE * f = fopen([txtFile UTF8String],"r");
			yyrestart(f);

			setLexToTxt(YES);
			yylex();

			fclose(f);
		}
		if([fm isReadableFileAtPath:csvFile]) {
			FILE * f = fopen([csvFile UTF8String],"r");
			yyrestart(f);

			setLexToTxt(NO);
			yyparse();

			fclose(f);
		}

		[language writeToFile:[NSString stringWithFormat:@"LanguageFiles/%@.plist",l] atomically:YES];
	}
	return 0;

	for(int i=1; i < argc; i++) {
		NSAutoreleasePool *pl = [[NSAutoreleasePool alloc] init];

		//Setup this language's stuff
		NSString * fileName = [NSString stringWithUTF8String:argv[i]]
			, *path = [NSString stringWithFormat:@"../%@",fileName]
			, *ext  = [fileName pathExtension];

		//Parse the file
		FILE *f = fopen([path UTF8String],"r");
		if(!f) {
			fprintf(stderr, "File :'%s' doesn't exist\n", [fileName UTF8String]);
			continue;
		}
		yyrestart(f);
		if([ext caseInsensitiveCompare:@"csv"] == NSOrderedSame) {
#ifndef TEST_TOKENS
			yyparse();
			NSLog(@"%@",languages);
#else
			int ret;
			while((ret=yylex())) {
				switch(ret) {
					case SECTION: printf("<section %d >",yylval.iVal); break;
					case NL: printf("\n"); break;
					case NUMBER: printf("%d ",yylval.iVal); break;
					case CELL: printf("cell "); break;

					default: printf("%3d ",ret);
				}
			}
			printf("\n");
#endif
		}

		fclose(f);

		[pl drain];
	}
	return 0;
}

void yyerror(const char *s) {
	fprintf(stderr, "error at line %d: %s\n", yylineno, s);
}
