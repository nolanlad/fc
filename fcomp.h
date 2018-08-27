#ifndef __FCOMP_H__
#define __FCOMP_H__
#include <stdio.h>
#include "blocks/static_blocks.h"


typedef enum id{
NUMBER, 
COMMA, 
OPENPAREN, 
CLOSEPAREN,
COMMAND, 
ASSIGN, 
NEWLINE,
COMP,
IF       } Id;

char * idstr[] = {
"NUMBER",
"COMMA",
"OPENPAREN", 
"CLOSEPAREN",
"COMMAND", 
"ASSIGN", 
"NEWLINE",
"COMP",
"IF"       };

typedef enum subid{
NONE,
DOUBLE,
INT
}  SubId;

typedef struct token{
    Id id;
    SubId sid;
    char * text;
}  Token;

typedef struct parser{
    struct blocked_Token * token_list;
    int idx;
}  Parser;

typedef Token * PATTERN;

dynamic_block(Token);
struct blocked_Token   * Token_block;

Token tt;
void set_token(Id id, SubId sid);

int is_c_func(Parser p, Token next, Token stop);

int counter = 0;


#endif //__FCOMP_H__
