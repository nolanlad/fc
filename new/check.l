%{
	#include <stdio.h>
	#include "y.tab.h"
	#include "float.h"
	#include "math.h"
	#include <string.h>
        #include "../blocks/static_blocks.h"
	int yyparse();
        void set_token(int id, int sid);
        int scope = 0;
%}

%option noyywrap

%%
[ ]+ ;
[\t]                                  { scope++; }
"int"|"float"                         { set_token(TYPE,0);     return TYPE;   }
"if"                                  { set_token(IF,0);       return IF;     }
-?[0-9]+                              { set_token(NUM,INT);    return INT;    }
-?([0-9]*\.[0-9]+)([eE]?[+-]?[0-9]+)? { set_token(NUM,DOUBLE); return DOUBLE; }
-?[0-9]*\.                            { set_token(NUM,DOUBLE); return DOUBLE; }
[a-zA-Z]+                             { set_token(VAR,0);      return VAR;    } 
"\.EQ\."                              { set_token(OP,EQ);      return COMP;   } 
[=]                                   { set_token(ASSIGN,0);   return ASSIGN; }
[+\-\*\/]                             { set_token(OP,0);       return OP;     }
\(                                    { set_token(OPAREN,0);   return OPAREN; }
\)                                    { set_token(CPAREN,0);   return CPAREN; }
\,                                    { set_token(COMMA,0);    return COMMA;  }
[\n]                                  { set_token(NEWLINE,0);  return NEWLINE;}

. ECHO;
%%


