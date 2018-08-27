%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>
	#include <string.h>
        #include "fcomp.h"
        #include "blocks/static_blocks.h"

	void yyerror(char *); 
	int yylex(void);
        int yyleng;
        char * yytext;
%}

%token DOUBLE INT BOOL ASSIGN OP TYPE CPAREN OPAREN COMMA NEWLINE IF COMP EQ

%union {
  char *s;
}

%token<s> VAR



%%
assignments: assignment assignments
   | assignment
   ;
assignment: 
   TYPE VAR ASSIGN expression { printf("Assignment.\n"); }
   | VAR ASSIGN expression    { printf("Assignment.\n"); }
   | VAR OPAREN args CPAREN   { printf("Func def\n");    }
   | VAR                      { printf("Func def\n");    }
   | NEWLINE                  { printf("New Line\n");    }
   | IF expression            { printf("If block\n");    }
   ;
args:
    VAR
   | args COMMA VAR
   ;
expression:
   number 
   | expression OP number
   | OPAREN expression CPAREN
   ;
number:
   DOUBLE 
 | INT 
 | BOOL ;
%%

void set_token(int id, int sid){
   Token t;
   t.id = id; 
   t.sid = sid;
   t.text = (char*)malloc(sizeof(char)*(yyleng+1));
   strcpy(t.text,yytext);
   printf("%s\n",t.text);
   setter(Token_block,counter++,t);
}

void print_block(struct blocked_Token   * block){
   for(int i=0; i< block->length; ++i){
      Token t = getter(block,i);
      printf("%s ",t.text);
   }
}
   

extern FILE *yyin;
int main()
{
 Token_block = new_block_Token();
 do
 {
 yyparse();
 }
 while (!feof(yyin));
 print_block(Token_block);
}
yyerror(s)
char *s;
{
 fprintf(stderr, "%s\n", s);
}
