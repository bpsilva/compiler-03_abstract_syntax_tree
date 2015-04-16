%{
#include<stdlib.h>
#include<stdio.h>

#include "AST.c"
#include "hash.h"
  
astree_node* astree;

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
	struct astree_node *astree;
	int n;

}



%token <symbol>SYMBOL_UNDEFINED 0
%token  <symbol>SYMBOL_LIT_INTEGER 1
%token  <symbol>SYMBOL_LIT_FLOATING 2
%token  <symbol>SYMBOL_LIT_TRUE 3
%token <symbol> SYMBOL_LIT_FALSE 4
%token <symbol>SYMBOL_LIT_CHAR 5
%token <symbol>SYMBOL_LIT_STRING 6 
%token  <symbol>SYMBOL_IDENTIFIER 7

%type <astree> type init expression output_rest program global_var_def function_def  arg command_list simple_command atrib value  flux_control then else option local_var_def_list local_var_def param paramseq symbol_lit_seq 


%left '+' '-'
%left '*' '/'
%left '>' '<'
%left "&&" "||"

 
%left KW_IF KW_ELSE



%%
init: program 		{astree = $1;}
	;
program: 					{$$ = 0;}
	|type function_def program		{$$ = astcreate(FUNC_DEF,0,$1,$2,$3,0);}
	|type global_var_def program		{$$ = astcreate(GLOBAL_VAR_DEF,0,$1,$2,$3,0);}
	;

global_var_def: 	
	SYMBOL_IDENTIFIER ':' value ';'	
			{$$ = astcreate(GLOBAL_VAR_DEF_INIT, 0,
				astcreate(SYMBOL_IDENTIFIER,$1,0,0,0,0),
				$3,0,0);}	

	|'$'SYMBOL_IDENTIFIER ':' value ';'
			{$$ = astcreate(GLOBAL_VAR_DEF_PTR, 0,
				astcreate(SYMBOL_IDENTIFIER,$2,0,0,0,0),
				$4,0,0);}		

	|SYMBOL_IDENTIFIER '[' SYMBOL_LIT_INTEGER ']' ':' symbol_lit_seq ';' 
				{$$ = astcreate(GLOBAL_VAR_DEF_VEC_INIT,0,
						astcreate(SYMBOL_IDENTIFIER,$1,0,0,0,0),
						astcreate( SYMBOL_LIT_INTEGER,$3,0,0,0,0),
						$6,0);}		

	|SYMBOL_IDENTIFIER '[' SYMBOL_LIT_INTEGER ']'';'	 	
				{$$ = astcreate(GLOBAL_VAR_DEF_VEC,0,
						astcreate(SYMBOL_IDENTIFIER,$1,0,0,0,0),
						astcreate( SYMBOL_LIT_INTEGER,$3,0,0,0,0),
						0,0);}
	;

function_def: 
	SYMBOL_IDENTIFIER '(' param ')' local_var_def_list  command_list 
			{$$ = astcreate(FUNC_DEF,
					0,
					astcreate(SYMBOL_IDENTIFIER,$1,0,0,0,0)
					,$3,$5,$6);}	
	;

command_list: '{' commands '}'

commands: 
	|simple_command ';' commands
	;

simple_command: 
	|atrib
	|flux_control 
	|KW_INPUT SYMBOL_IDENTIFIER 
	|KW_OUTPUT expression output_rest
	|KW_RETURN expression
	;
atrib: 
	'+''+'SYMBOL_IDENTIFIER
	|SYMBOL_IDENTIFIER '+''+'
	|SYMBOL_IDENTIFIER '=' expression
	| SYMBOL_IDENTIFIER '[' expression ']' '=' expression
	;

expression:
	expression '+' expression			{$$ = astcreate(EXP_ADD,0,$1,$3,0,0);}
	|expression '-'expression			{$$ = astcreate(EXP_SUB,0,$1,$3,0,0);}
	|expression '*' expression			{$$ = astcreate(EXP_MUL,0,$1,$3,0,0);}
	|expression '/' expression			{$$ = astcreate(EXP_DIV,0,$1,$3,0,0);}
	|expression '>' expression 			{$$ = astcreate(EXP_MORE,0,$1,$3,0,0);}
	|expression '<' expression 			{$$ = astcreate(EXP_LESS,0,$1,$3,0,0);}
	|expression "||" expression 			{$$ = astcreate(EXP_OR,0,$1,$3,0,0);}
	|expression "&&" expression 			{$$ = astcreate(EXP_AND,0,$1,$3,0,0);}
	|SYMBOL_IDENTIFIER '[' expression ']' 		{$$ = astcreate(EXP_ARRAY_ACCESS,0,astcreate(SYMBOL_IDENTIFIER,$1,0,0,0,0),$3,0,0);}
	|SYMBOL_IDENTIFIER				{$$ = astcreate(SYMBOL_IDENTIFIER,$1,0,0,0,0);}
	|value						{$$ = $1;}
	|SYMBOL_IDENTIFIER '(' arg ')'			{$$ = astcreate(EXP_FUNC_CALL,0,astcreate(SYMBOL_IDENTIFIER,$1,0,0,0,0),$3,0,0);}
	|'&'SYMBOL_IDENTIFIER 
	|'$'SYMBOL_IDENTIFIER  
	;


arg: 						
	|value ',' arg					{$$ = astcreate(ARG_SEQ,0,$1,$3,0,0);}
	|SYMBOL_IDENTIFIER ',' arg			{$$ = astcreate(ARG_SEQ,0,astcreate(SYMBOL_IDENTIFIER,$1,0,0,0,0),$3,0,0);}
	|SYMBOL_IDENTIFIER 				{$$ = astcreate(SYMBOL_IDENTIFIER,$1,0,0,0,0);}
	|value 						{$$ = $1;}
	;


value:	SYMBOL_LIT_INTEGER 				{$$ = astcreate(SYMBOL_IDENTIFIER,$1,0,0,0,0);}
	|SYMBOL_LIT_FALSE 				{$$ = astcreate(SYMBOL_LIT_FALSE,$1,0,0,0,0);}
	|SYMBOL_LIT_TRUE	  			{$$ = astcreate(SYMBOL_LIT_TRUE,$1,0,0,0,0);}
	|SYMBOL_LIT_CHAR   				{$$ = astcreate(SYMBOL_LIT_CHAR,$1,0,0,0,0);}
	|SYMBOL_LIT_STRING				{$$ = astcreate(SYMBOL_LIT_STRING,$1,0,0,0,0);}
	;
	
output_rest:						{$$ = 0;}
	|',' expression output_rest			{$$ = astcreate(OUT_REST,0,$2,$3,0,0);}
	;


flux_control: 
	KW_IF '('expression')' then			{$$ = astcreate(KW_IF,0,$3,$5,0,0);}
	|KW_LOOP '(' simple_command ';' expression ';' simple_command ')' command_list {$$ = astcreate(KW_LOOP,0,$3,$5,$7,$9);}
	;

then: 
	KW_THEN option else 				{$$ = astcreate(KW_THEN,0,$2,$3,0,0);}
	;
else: 							{$$ = 0;}
	| KW_ELSE option 				{$$ = astcreate(KW_ELSE,0,$2,0,0,0);}
	;

option: 
	command_list 					{$$ = $1;}
	|simple_command 				{$$ = $1;}
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
	value						{$$ = $1;}
	|value symbol_lit_seq				{$$ = astcreate(SYMBOL_LIT_SEQ,0,$1,$2,0,0);}
	; 
type: 	KW_WORD		{$$ = astcreate(KW_WORD,0,0,0,0,0);}	
	| KW_BOOL	{$$ = astcreate(KW_BOOL,0,0,0,0,0);}	
	| KW_BYTE	{$$ = astcreate(KW_BYTE,0,0,0,0,0);}	
	;
%%

int main(int arc, char **argv)
{

int out;
	yyin = fopen(argv[1], "r");
	out = yyparse();
	printast(astree, 0);
	exit (out);

}

yyerror(s) char *s; {
       fprintf( stderr, "Syntax error. Linha: %i\n", getLineNumber() );
	exit(3);
       }
