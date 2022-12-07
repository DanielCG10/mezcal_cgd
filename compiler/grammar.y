%code requires {
	#include <string>
}
%{
	#include <math.h>
	#include <stdio.h>
	#include <stdlib.h>
	#include <iostream>
	#include <memory>
	#include <string>
	using namespace std;
	extern char *yytext;
	extern  int yylineno;
	std::string result;
	int yylex(void);	
	void yyerror(char const *);
%}

%define api.value.type { std::string }

%token  NAME COLON RIGHT_ARROW LEFT_CURLY_BRACE RIGHT_CURLY_BRACE 		SEMICOLON LEFT_PARENTHESIS RIGHT_PARENTHESIS SINGLECOMMENT 
	MULTILINECOMMENT QUOTES CHARACTERS_BLOCK INTEGER_VALUE 		DOLLAR_SIGN LEFT_BRACKET RIGHT_BRACKET MAYOR MENOR DOBLE_COLON 		SHOW LOAD DEC INTEGER BNL TRU FLS STR MENORIGUAL IGUAL MAYORIGUAL 	    DIFERENTEIGUAL ANSWER SIGNOINTERROGACION O ARROBA DIAG MENOS COMA 		PSG MAS DIAG_INV

%start input

%%

input:
	function function_list	{ result = std::string("#include <cstdio>\n #include <iostream> \n #include <string.h>\n using namespace std;\n") + $1 + $2; }
	;

function_list:
	function function_list                  { $$ = $1 + $2; }
	|
	%empty					{ $$ = ""; }
	;

function:
	name DOBLE_COLON LEFT_BRACKET RIGHT_BRACKET RIGHT_ARROW 		LEFT_BRACKET INTEGER RIGHT_BRACKET COLON LEFT_CURLY_BRACE 		statements RIGHT_CURLY_BRACE      
	{ 
		if($1 == "main"){
			$$ = "int main(int argc, char *argv[]){\n" + $11 + "\n}\n";
		}else{
			$$ = std::string("\n void ") + "_" + $1 + "()" + "{\n" + $11 + "\n}\n";
		} 
	}
	|
	%empty					{ $$ = ""; }
	;

statements:
	statements statement 
	{ $$ = $1 + $2; }
	|
	%empty					{ $$ = ""; }
	;

statement:
	loops	{ $$ = $1; }
	|
	bifurcation { $$ = $1; }
	|
	assignment SEMICOLON { $$ = $1; }
	|
	std_input SEMICOLON { $$ = $1; }
	|
	definition SEMICOLON { $$ = $1; }
	|
	std_output SEMICOLON { $$ = $1; }
	|
	MULTILINECOMMENT	{ $$ = ""; }
	|
	SINGLECOMMENT	{ $$ = ""; }
	|
	expression SEMICOLON { $$ = $1; }
	|
	operaciones SEMICOLON { $$ = $1; }
	;
	

bifurcation:
	LEFT_BRACKET logical_eval RIGHT_BRACKET SIGNOINTERROGACION 		LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE
		{ $$ = "if(" + $2 + "){\n" + $6 + "}\n"; }
	|
	LEFT_BRACKET logical_eval RIGHT_BRACKET SIGNOINTERROGACION MAS 		LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE
		{ $$ = " else if(" + $2 + "){\n" + $7 + "}\n"; }
	|
	O LEFT_CURLY_BRACE statements RIGHT_CURLY_BRACE
	{ $$ = "else {\n" + $3 + "}\n" ; }
	;
loops:
	LEFT_BRACKET logical_eval RIGHT_BRACKET ARROBA LEFT_CURLY_BRACE 		statements RIGHT_CURLY_BRACE
	{ $$ = "while(" + $2 + "){\n" + $6 + "}\n"; }
	|
	LEFT_BRACKET assignment DIAG_INV logical_eval DIAG_INV 	      	operaciones_dos RIGHT_BRACKET ARROBA LEFT_CURLY_BRACE 	statements RIGHT_CURLY_BRACE
	{ $$ = "for(" + $2 + $4 +";" + $6 + "){\n" + $10 + "}\n"; }
	;

logical_eval:
	DOLLAR_SIGN name LEFT_BRACKET DOLLAR_SIGN name RIGHT_BRACKET 
	comp_operator DOLLAR_SIGN name 
	{ $$ = $2 + "[" + $5 + "] " + $7 + $9; }
	|
	integer_value comp_operator integer_value
	{ $$ = $1 + $2 + $3; }
	|
	DOLLAR_SIGN name comp_operator DOLLAR_SIGN name 
	{ $$ = $2 + $3 + $5; }
	|
	DOLLAR_SIGN name comp_operator integer_value 
	{ $$ = $2 + $3 + $4; }
	;

comp_operator:
	IGUAL		{ $$ = "=="; }
	|
	MENORIGUAL	{ $$ = "<="; }
	|
	MENOR		{ $$ = "<"; }
	|
	MAYOR		{ $$ = ">"; }
	|
	MAYORIGUAL	{ $$ = ">="; }
	|
	DIFERENTEIGUAL	{ $$ = "!="; }
	;

assignment:
	name COLON DOLLAR_SIGN name LEFT_BRACKET DOLLAR_SIGN name 		RIGHT_BRACKET
	{$$ = $1 + "= "+ $4 + "["  + $7 + "] ;\n";}
	|
	name COLON DOLLAR_SIGN name LEFT_BRACKET integer_value 		RIGHT_BRACKET
	{$$ = $1 + "= "+ $4 + "["  + $6 + "] ;\n";}
	|
	name COLON LEFT_BRACKET integer_value COMA integer_value 		RIGHT_BRACKET 
	{$$ = $1 + "["  + $4 + "] = " + $6 +";\n";}
	|
	name COLON LEFT_BRACKET DOLLAR_SIGN name COMA DOLLAR_SIGN name 		RIGHT_BRACKET 
	{$$ = $1 + "["  + $5 + "] = " + $8 +";\n";}
	|
	name COLON integer_value
	{ $$ =  $1 + " = " + $3 + ";\n";}
	|
	name COLON characters_block
	{ $$ =  $1 + " = " + $3 + ";\n";}
	|
	name COLON TRU 
	{ $$ =  $1 + " = " + "true" + ";\n";}
	|
	name COLON FLS
	{ $$ =  $1 + " = " + "false" + ";\n";}
	|
	name COLON DOLLAR_SIGN ids
	{ $$ =  $1 + " = " + $4 + ";\n";}
	;
integer_value:
	INTEGER_VALUE { $$ = std::string(yytext); }
	;
std_input:
	LOAD COLON name { $$ = "\t cin >> " + $3 + ";\n"; }
	;

definition:
	name COLON INTEGER LEFT_BRACKET integer_value RIGHT_BRACKET
	 {$$ = "\t int " + $1 + "[" + $5 + "]" + ";\n"; }
	|
	name COLON INTEGER 	{ $$ = "\t int " + $1 + ";\n"; }
	|
	name COLON DEC  	{ $$ = "\t float " + $1 + ";\n"; }
	|
	name COLON STR		{ $$ = "\t string " + $1 + ";\n"; }
	|
	name COLON BNL		{ $$ = "\t bool " + $1 + ";\n"; }
	;

identifiers:
	identifiers ids	{ $$ = $1 + $2; }
	|
	%empty	{ $$ = ""; }
	;

ids:
	name	{ $$ = $1; }
	;

std_output:
	SHOW COLON DOLLAR_SIGN name COMA integer_value
	 { $$ = "\t cout << " + $4 + "[" + $6  + "] << endl;\n"; }
	|
	SHOW COLON characters_block	
	{ $$ = "\t cout << " + $3 + " << endl;\n"; }
	|
	SHOW COLON DOLLAR_SIGN name	
	{ $$ = "cout << " + $4 + " << endl;"; }
	|
	SHOW COLON characters_block COMA  DOLLAR_SIGN name COMA 		characters_block
	{ $$ = "\t cout << " + $3 + "<< " + $6 + " << endl;\n"; }
	;
expression:
	name LEFT_PARENTHESIS RIGHT_PARENTHESIS	{ $$ = std::string("\t _") + $1 + "();\n"; }
	;

characters_block: 
	CHARACTERS_BLOCK { $$ = std::string(yytext); }
	;

name:
	NAME    {  
		$$ = std::string(yytext);
		}
	;
operaciones:
	name COLON DOLLAR_SIGN name MAS integer_value
	{ $$ = "\n" + $1 + "=" + $4 + "+" + $6 + ";\n"; }
	;
operaciones_dos:
	name COLON DOLLAR_SIGN name MAS integer_value
	{ $$ =  $1 + "=" + $4 + "+" + $6; }
	;
%%

void yyerror (char const *x){
	printf ("Error: %s, en la linea:  %d\n", x, yylineno);
	exit(1);
}
