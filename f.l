%{
#include "fcomp.h"
%}

%%
[\t ]+ ;
-?[0-9]+   { set_token(NUMBER,INT);  }

-?([0-9]*\.[0-9]+)([eE]?[+-]?[0-9]+)? {  set_token(NUMBER,DOUBLE); }

-?[0-9]*\.  { set_token(NUMBER,DOUBLE); }

[a-zA-Z]+ {  set_token(COMMAND,NONE); }
 
\,    { set_token(COMMA,NONE); }

\(    { set_token(OPENPAREN,NONE); }

\)    { set_token(CLOSEPAREN,NONE); }

[\n]  { set_token(NEWLINE,NONE); }
[=]   { set_token(ASSIGN,NONE); }

. ECHO;
%%



void set_token(Id id, SubId sid){
   Token t;
   t.id = id; 
   t.sid = sid;
   t.text = (char*)malloc(sizeof(char)*(yyleng+1));
   strcpy(t.text,yytext);
   printf("%s %s\n",idstr[id],t.text);
   setter(Token_block,counter++,t);
}

void poop(int a[]){}

int main(){
   Token_block = new_block_Token();
   yylex();
   Parser p;
   p.token_list = Token_block; p.idx = 0;
}

