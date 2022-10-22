%{
#include <stdio.h>
#include "util.h"
#include "errormsg.h"

int yylex(void);

void yyerror(char* s) {
    EM_error(EM_tokPos, "%s", s);
}

%}

%union {
    int pos;
    int ival;
    string sval;
}

%token <sval> ID STRING
%token <ival> INT

%token 
  COMMA COLON SEMICOLON LPAREN RPAREN LBRACK RBRACK 
  LBRACE RBRACE DOT 
  PLUS MINUS TIMES DIVIDE EQ NEQ LT LE GT GE
  AND OR ASSIGN
  ARRAY IF THEN ELSE WHILE FOR TO DO LET IN END OF 
  BREAK NIL
  FUNCTION VAR TYPE CMT

%left COMMA
%left ASSIGN
%left OR
%left AND
%nonassoc EQ NEQ LT LE GT GE
%left PLUS MINUS
%left TIMES DIVIDE
%nonassoc UMINUS

%start program

%%

program: exp

exp:            lvalue  
            |   NIL
            |   LPAREN RPAREN
            |   INT
            |   STRING 
            |   CMT
            |   LPAREN expseq RPAREN 
            |   MINUS exp %prec UMINUS
            |   func_call_exp
            |   arith_exp
            |   comp_exp
            |   bool_exp
            |   record_create_exp
            |   array_create_exp
            |   lvalue ASSIGN exp
            |   if_exp
            |   loop_exp
            |   BREAK
            |   LET decs IN expseq END

expseq: exp
      | expseq SEMICOLON exp

if_exp: IF exp THEN exp
      | IF exp THEN exp ELSE exp

loop_exp: WHILE exp DO exp
        | FOR ID ASSIGN exp TO exp DO exp

func_call_exp: ID LPAREN RPAREN
        | ID LPAREN func_call_param_exp RPAREN

func_call_param_exp: exp
                   | func_call_param_exp COMMA exp

arith_exp: exp PLUS exp
         | exp MINUS exp
         | exp TIMES exp
         | exp DIVIDE exp

comp_exp: exp EQ exp
        | exp NEQ exp
        | exp LT exp
        | exp LE exp
        | exp GT exp
        | exp GE exp

bool_exp: exp AND exp
        | exp OR exp

record_create_exp: ID LBRACE RBRACE
                 | ID LBRACE record_create_exp_no_empty RBRACE

record_create_exp_no_empty: ID EQ exp
                          | record_create_exp_no_empty COMMA ID EQ exp

array_create_exp: ID LBRACK exp RBRACK OF exp

decs: /* empty */
    | decs dec

dec: typedec
   | vardec
   | fundec

typedec: TYPE ID EQ ty

ty: ID
  | LBRACE tyfields RBRACE
  | ARRAY OF ID

tyfields: /* empty */
        | tyfields_no_empty

tyfields_no_empty : tyfield
                  | tyfields_no_empty COMMA tyfield 

tyfield: ID COLON ID

vardec: VAR ID ASSIGN exp
      | VAR ID COLON ID ASSIGN exp

fundec: FUNCTION ID LPAREN tyfields RPAREN EQ exp
      | FUNCTION ID LPAREN tyfields RPAREN COLON ID EQ exp

lvalue: ID
      | lvalue DOT ID
      | lvalue LBRACK exp RBRACK