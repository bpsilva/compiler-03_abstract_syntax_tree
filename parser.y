%{
#include<stdlib.h>
#include<stdio.h>
#include"hash.h"

extern FILE * yyin;
%}

%token KW_WORD  
%token KW_BOOL      
%token KW_BYTE    
%token KW_IF       
%token KW_THEN      
%token KW_ELSE     
%token KW_LOOP   
%token KW_INPUT  
%token KW_RETURN   
%token KW_OUTPUT 

%token OPERATOR_LE 
%token OPERATOR_GE 
%token OPERATOR_EQ 
%token OPERATOR_NE
%token OPERATOR_AND
%token OPERATOR_OR 

%token TOKEN_ERROR 

%union
{
	struct hash* symbol;
	int n;
}


%token SYMBOL_UNDEFINED 0
%token  SYMBOL_LIT_INTEGER 1
%token  SYMBOL_LIT_FLOATING 2
%token  SYMBOL_LIT_TRUE 3
%token  SYMBOL_LIT_FALSE 4
%token SYMBOL_LIT_CHAR 5
%token SYMBOL_LIT_STRING 6 
%token  SYMBOL_IDENTIFIER 7




%left '+' '-'
%left '*' '/'
%left '>' '<'

 
%left KW_IF KW_ELSE


%%

program: 
	|function_def program
	|global_var_def program
	;

global_var_def: 
	type SYMBOL_IDENTIFIER ':' value ';'
	|type '$'SYMBOL_IDENTIFIER ':' value ';'
	|type SYMBOL_IDENTIFIER '[' SYMBOL_LIT_INTEGER ']' ':' symbol_lit_seq ';'
	|type SYMBOL_IDENTIFIER '[' SYMBOL_LIT_INTEGER ']'';'		
	;

function_def: 
	type SYMBOL_IDENTIFIER '(' param ')' local_var_def_list '{' command_list '}'
	;

arg: 	
	|value ',' arg
	|SYMBOL_IDENTIFIER ',' arg
	|SYMBOL_IDENTIFIER 
	|value 
	;

command_list: 
	|simple_command ';' command_list
	;

simple_command: 
	|atrib
	|flux_control 
	|KW_INPUT SYMBOL_IDENTIFIER 
	|output
	|KW_RETURN expression
	;
atrib: 
	'+''+'SYMBOL_IDENTIFIER
	|SYMBOL_IDENTIFIER '+''+'
	|SYMBOL_IDENTIFIER '=' expression
	| SYMBOL_IDENTIFIER '[' expression ']' '=' expression
	;

expression:
	expression '+' expression
	|expression '-'expression
	|expression '*' expression
	|expression '/' expression
	|expression '>' expression 
	|expression '<' expression
	|SYMBOL_IDENTIFIER '[' expression ']' 
	|SYMBOL_IDENTIFIER
	|value
	|SYMBOL_IDENTIFIER '(' arg ')'
	|'&'SYMBOL_IDENTIFIER 
	|'$'SYMBOL_IDENTIFIER  
	;

value:	SYMBOL_LIT_INTEGER 
	|SYMBOL_LIT_FALSE 
	|SYMBOL_LIT_TRUE	  		
	|SYMBOL_LIT_CHAR   			
	|SYMBOL_LIT_STRING
	;
	
output:	KW_OUTPUT out
	;

out:	out ',' out
	SYMBOL_LIT_STRING
	|expression
	;

flux_control: 
	KW_IF '('expression')' then
	|KW_LOOP '(' simple_command ';' expression ';' simple_command ')' '{'command_list'}'
	;

then: 
	KW_THEN option else
	;
else: 
	| KW_ELSE option
	;

option: 
	'{'command_list'}' 
	|simple_command 
	;

local_var_def_list: 	
	|local_var_def local_var_def_list
	;

local_var_def: type SYMBOL_IDENTIFIER ':' value ';' 
	|type '$'SYMBOL_IDENTIFIER ':' value ';'
	;		
param: 
	|type SYMBOL_IDENTIFIER paramseq
	;

paramseq: 
	| ',' type SYMBOL_IDENTIFIER paramseq
	;

symbol_lit_seq:  
	value
	|value symbol_lit_seq
	; 
type: 	KW_WORD				
	| KW_BOOL			
	| KW_BYTE			

%%

int main(int arc, char **argv)
{

	yyin = fopen(argv[1], "r");
	exit (yyparse());

}

yyerror(s) char *s; {
       fprintf( stderr, "Syntax error. Linha: %i\n", getLineNumber() );
	exit(3);
       }
