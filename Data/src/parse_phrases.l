%option noyywrap yylineno
%x TXT TXT_SECTION_NUM TXT_SECTION_TITLE
%{
	#import <Foundation/Foundation.h>
	#include "bison.h"

	extern NSMutableDictionary *language;
	extern NSMutableArray *sections;

	NSMutableDictionary * currLanguage;
	NSMutableString * credits, *forward, *section_title, *section_num, *section_content,  *curr_txt_target;

	#define ADD_TEXT [curr_txt_target appendString:[NSString stringWithUTF8String:yytext]];
%}

%%
"SECTION "[^\t\n]* {
	yylval.iVal = atoi(yytext+8);
	return SECTION;
}

^[0-9]+ {
	yylval.iVal = atoi(yytext);
	return NUMBER;
}

[^\t\n/()]+ {
	yylval.obj = [NSString stringWithUTF8String:yytext];
	return CELL;
}

\t
\s*"//"\s*	return SLASH;
\n 			return NL;

\(.*\)[\s\t]*$		{
	yylval.obj = [NSString stringWithUTF8String:yytext];
	return endPAREN;
}
\([^\t]*\)		{
	yylval.obj = [NSString stringWithUTF8String:yytext];
	return midPAREN;
}
"/ "	{return SLASH;}
"/"			{
	yylval.iVal = *yytext;
	return CHAR;
}


<TXT>"(SECTION)"\s* {
	BEGIN(TXT_SECTION_NUM);
}
<TXT_SECTION_NUM>[0-9]+ {
	NSMutableDictionary * d = [NSMutableDictionary dictionary];
	[sections addObject:d];
	[d setObject:[NSString stringWithUTF8String:yytext] forKey:@"ID"];

	curr_txt_target = [NSMutableString string];
	[d setObject:curr_txt_target forKey:@"content"];

	BEGIN(TXT_SECTION_TITLE);
}
<TXT_SECTION_TITLE>.*$ {
	[ [sections lastObject] setObject:[NSString stringWithUTF8String:yytext] forKey:@"title"];
	BEGIN(TXT);
}

<TXT>"(CREDITS)" {
	curr_txt_target = [NSMutableString string];
	[language setObject:curr_txt_target forKey:@"credits"];
}
<TXT>"(FORWARD)" {
	curr_txt_target = [NSMutableString string];
	[language setObject:curr_txt_target forKey:@"forward"];
}

<TXT>[()]		ADD_TEXT
<TXT>[^()]+		ADD_TEXT
<TXT>\n			ADD_TEXT

<<EOF>>	{yyterminate();}

%%

void setLexToTxt(BOOL isTxt) {
	if(isTxt) BEGIN(TXT);
	else BEGIN(INITIAL);
}