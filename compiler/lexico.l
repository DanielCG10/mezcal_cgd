%option noyywrap
%{
	#include "grammar.tab.h"
%}

DIGIT [0-9]
ALPHA [a-zA-Z]
CHARACTERS_BLOCK {QUOTES}({ALPHA}*{WHITESPACE}*{DIGIT}*)+{QUOTES}
NAME {ALPHA}([0-9]*{ALPHA}*)+
WHITESPACE [ \r\t\v\f]
LINEFEED \n
SINGLECOMMENT {SLASH}{SLASH}({DOT}*{WHITESPACE}*)+{LINEFEED}
MULTILINECOMMENT {MENOR}{MAS}({DOT}*{WHITESPACE}*{LINEFEED}*)+{MAS}{MAYOR}
SLASH [/]
DOT .
WILDCARD [*]
QUOTES [\"]
MAYOR [>]
MENOR [<]
MAS [+]
DIAG_INV [\\]

%%

","			{ return COMA; }
"["			{ return LEFT_BRACKET; }
"]"			{ return RIGHT_BRACKET; }
"::"			{ return DOBLE_COLON; }
"show"			{ return SHOW; }
"load"			{ return LOAD; }
"Dec"			{ return DEC; }
"Int"			{ return INTEGER; }
"Bnl"			{ return BNL; }
"tru"			{ return TRU; }
"fls"			{ return FLS; }
"Str"			{ return STR; }
"<="			{ return MENORIGUAL; }
"="			{ return IGUAL; }
">="			{ return MAYORIGUAL; }
"!="			{ return DIFERENTEIGUAL; }
"answer"		{ return ANSWER; }
"?"			{ return SIGNOINTERROGACION; }
"|"			{ return O; }
"@"			{ return ARROBA; }
"/"			{ return DIAG; }
"-"			{ return MENOS; }
"%"			{ return PSG; }
{MAYOR}		{ return MAYOR; }
{MENOR}		{ return MENOR; }
{MAS}			{ return MAS; }
{DIAG_INV}		{ return DIAG_INV; }
{DIGIT}+               { return INTEGER_VALUE; }
{NAME}			{ 
			//yylval = new compiler::Name(yytext);
			return NAME; 
			}
{CHARACTERS_BLOCK}     { return CHARACTERS_BLOCK; }
{QUOTES}		{ return QUOTES; }
{SINGLECOMMENT}        { return SINGLECOMMENT; }
{MULTILINECOMMENT}     { return MULTILINECOMMENT; }
":"			{ return COLON; }
";"			{ return SEMICOLON; }
"->"			{ return RIGHT_ARROW; }
"{"			{ return LEFT_CURLY_BRACE; }
"}"			{ return RIGHT_CURLY_BRACE; }
"("			{ return LEFT_PARENTHESIS; }
")"			{ return RIGHT_PARENTHESIS; }
"$"			{ return DOLLAR_SIGN; }
{WHITESPACE}
{LINEFEED}		++yylineno;

%%

#include <stdio.h>
