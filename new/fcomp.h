#ifndef __FCOMP_H__
#define __FCOMP_H__
#include <stdio.h>
#include "blocks/static_blocks.h"

typedef struct token{
    int id;
    int sid;
    char * text;
}  Token;

typedef struct parser{
    struct blocked_Token * token_list;
    int idx;
}  Parser;


dynamic_block(Token);
struct blocked_Token   * Token_block;

Token tt;
void set_token(int id, int sid);

int is_c_func(Parser p, Token next, Token stop);

int counter = 0;


#endif //__FCOMP_H__