%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <math.h>
	#include <string.h>
        #include "fcomp.h"
        #include "../blocks/static_blocks.h"

	void yyerror(char *); 
        void print_code(var_init  * v);
        void var_init_c(var_init * v);
        void reset();
	int yylex(void);
        int yyleng;
        char * yytext;
        int assign_type;
        var_init v;

#define showtoken(in) (#in)
%}

%token DOUBLE INT BOOL ASSIGN OP TYPE CPAREN OPAREN COMMA NEWLINE IF COMP EQ NUM

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
   | VAR ASSIGN expression    { 

       v.token_list = Token_block;
       v.r_type     = assign_type;
       v.eltype = VARINIT;
       //var_init_c(&v);
   }
   | args ASSIGN expression{ 

       v.token_list = Token_block;
       v.r_type     = assign_type;
       v.eltype = VARINIT;
       //var_init_c(&v);
   }
   | VAR OPAREN args CPAREN   { printf("Func def\n");    }
   | VAR                      { printf("Func def\n");    }
   | NEWLINE{ 
          print_code(&v);
          reset();                 
   }
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
   DOUBLE { assign_type = DOUBLE; }
   | INT  { assign_type = INT; }
   | BOOL 
   | DOUBLE COMMA number
   ;
%%

void set_token(int id, int sid){
   Token t;
   t.id = id; 
   t.sid = sid;
   t.text = (char*)malloc(sizeof(char)*(yyleng+1));
   strcpy(t.text,yytext);
   //printf("%s\n",t.text);
   setter(Token_block,counter++,t);
}

void print_block(struct blocked_Token   * block){
   for(int i=0; i< block->length; ++i){
      Token t = getter(block,i);
   }
}


void var_init_c(var_init * v){
    bool expr = false;
    if(v->r_type == DOUBLE)
        printf("double ");
    else
        printf("int ");
    for(int i =0; i< (v->token_list)->length; ++i){
        Token _t = getter(v->token_list,i);
        if(_t.id == COMMA && !expr)
            printf(" , ");
        if(expr && _t.id != NEWLINE)
            printf("%s",_t.text);
        if(_t.id == VAR)
            printf("%s",_t.text);
        if(_t.id == ASSIGN){
            printf(" = ");
            expr = true;
        }
        
    }
    printf(";\n");
}

void print_code(var_init  * v){
    if(v->eltype == VARINIT)
        var_init_c(v);
    else
        printf("unimplemented code type");
}

void reset(){
    Token_block = new_block_Token();
    counter = 0;
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
 
}
yyerror(s)
char *s;
{
 fprintf(stderr, "%s\n", s);
}
