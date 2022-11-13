#include "util.h"

#ifndef SYMBOL
#define SYMBOL

typedef struct S_symbol_* S_symbol;

S_symbol S_Symbol(string);

string S_name(S_symbol);

typedef struct TAB_table_* S_table;

S_table S_empty(void);

void S_enter(S_table t, S_symbol sym, void *value);

void* S_look(S_table t, S_symbol sym);

void S_beginScope(S_table t);

void S_endScope(S_table t);


#endif
