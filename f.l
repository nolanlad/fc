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

int test(Parser * p){
   struct blocked_Token * tl = p->token_list;
   Token tok = getter(tl,p->idx);
   while(p->idx < tl->length){
      p->idx++;
      Token tok = getter(tl,p->idx);
      if(tok.id == NUMBER)
          printf("%s %s\n",idstr[tok.id],tok.text);
      if(tok.id == NEWLINE)
          break;
   }
   return 0;
}

int match(Parser * p, Id pat[],int size){
   int start = (*p).idx;
   int c = 0;
   while(c < size){
      if(getter(p->token_list,start).id != pat[c])
        return 0;
      start++;
      c++;
   }
   
   return 1;
}

int main(){
   Token_block = new_block_Token();
   yylex();
   Parser p;
   p.token_list = Token_block; p.idx = 0;
   Id decl[] = {COMMAND, COMMAND, ASSIGN, NUMBER};
   if(match(&p,decl,4)){
      printf("match\n");
   }
   test(&p);
   test(&p);
   
}

