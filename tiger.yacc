%{
#include <stdio.h>
#include "util.h"
#include "symbol.h"
#include "errormsg.h"
#include "absyn.h"

int yylex(void);

A_exp absyn_root;

void yyerror(char* s) {
    EM_error(EM_tokPos, "%s", s);
}

%}

%union {
    int pos;
    int ival;
    string sval;
    A_var var;
    A_exp exp;
    A_dec dec;
    A_ty ty;
    A_decList declist;
    A_expList explist;
    A_field field;
    A_fieldList fieldlist;
    A_fundec fundec;
    A_fundecList fundeclist;
    A_namety namety;
    A_nametyList nametylist;
    A_efield efield;
    A_efieldList efieldlist;
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

%nonassoc LOW
%nonassoc TYPE FUNCTION
%nonassoc ID
%nonassoc LBRACK
%nonassoc DO OF
%nonassoc THEN
%nonassoc ELSE
%left COMMA
%left SEMICOLON
%left ASSIGN
%left OR
%left AND
%nonassoc EQ NEQ LT LE GT GE
%left PLUS MINUS
%left TIMES DIVIDE
%left UMINUS

%type <var> lvalue
%type <exp> exp program func_call_exp arith_exp comp_exp bool_exp record_create_exp array_create_exp if_exp loop_exp
%type <dec> dec typedeclist vardec fundeclist
%type <ty> ty
%type <declist> decs
%type <explist> expseq func_call_param_exp
%type <field> tyfield
%type <fieldlist> tyfields tyfields_no_empty
%type <fundec> fundec
%type <namety> typedec
%type <efieldlist> record_create_exp_no_empty

%start program

%%

program: exp    { absyn_root = $1;}

exp:            lvalue                                  { $$ = A_VarExp(EM_tokPos, $1); }
            |   NIL                                     { $$ = A_NilExp(EM_tokPos); }
            |   LPAREN RPAREN                           { $$ = A_SeqExp(EM_tokPos, NULL); }
            |   INT                                     { $$ = A_IntExp(EM_tokPos, $1); }
            |   STRING                                  { $$ = A_StringExp(EM_tokPos, $1); }
            |   CMT                                     { $$ = A_CommentExp(EM_tokPos); }
            |   LPAREN expseq RPAREN                    { $$ = A_SeqExp(EM_tokPos, $2); }
            |   MINUS exp %prec UMINUS                  { $$ = A_OpExp(EM_tokPos, A_minusOp, 0, $2); }
            |   func_call_exp                           { $$ = $1; }
            |   arith_exp                               { $$ = $1; }
            |   comp_exp                                { $$ = $1; }
            |   bool_exp                                { $$ = $1; }
            |   record_create_exp                       { $$ = $1; }
            |   array_create_exp                        { $$ = $1; }
            |   lvalue ASSIGN exp                       { $$ = A_AssignExp(EM_tokPos, $1, $3); }
            |   if_exp                                  { $$ = $1; }
            |   loop_exp                                { $$ = $1; }
            |   BREAK                                   { $$ = A_BreakExp(EM_tokPos); }
            |   LET decs IN expseq END                  { $$ = A_LetExp(EM_tokPos, $2, A_SeqExp(EM_tokPos, $4)); }

expseq: exp                                             { $$ = A_ExpList($1, NULL); }
      | expseq SEMICOLON exp                            { $$ = A_ExpList($3, $1); }

if_exp: IF exp THEN exp                                 { $$ = A_IfExp(EM_tokPos, $2, $4, NULL); }
      | IF exp THEN exp ELSE exp                        { $$ = A_IfExp(EM_tokPos, $2, $4, $6); }

loop_exp: WHILE exp DO exp                              { $$ = A_WhileExp(EM_tokPos, $2, $4); }
        | FOR ID ASSIGN exp TO exp DO exp               { $$ = A_ForExp(EM_tokPos, S_Symbol($2), $4, $6, $8); }

func_call_exp: ID LPAREN RPAREN                         { $$ = A_CallExp(EM_tokPos, S_Symbol($1), NULL); }
        | ID LPAREN func_call_param_exp RPAREN          { $$ = A_CallExp(EM_tokPos, S_Symbol($1), $3); }

func_call_param_exp: exp                                { $$ = A_ExpList($1, NULL); }          
                   | func_call_param_exp COMMA exp      { $$ = A_ExpList($3, $1); }          

arith_exp: exp PLUS exp                                 { $$ = A_OpExp(EM_tokPos, A_plusOp, $1, $3); }
         | exp MINUS exp                                { $$ = A_OpExp(EM_tokPos, A_minusOp, $1, $3); }
         | exp TIMES exp                                { $$ = A_OpExp(EM_tokPos, A_timesOp, $1, $3); }
         | exp DIVIDE exp                               { $$ = A_OpExp(EM_tokPos, A_divideOp, $1, $3); }

comp_exp: exp EQ exp                                    { $$ = A_OpExp(EM_tokPos, A_eqOp, $1, $3); }
        | exp NEQ exp                                   { $$ = A_OpExp(EM_tokPos, A_neqOp, $1, $3); }
        | exp LT exp                                    { $$ = A_OpExp(EM_tokPos, A_ltOp, $1, $3); }
        | exp LE exp                                    { $$ = A_OpExp(EM_tokPos, A_eqOp, $1, $3); }
        | exp GT exp                                    { $$ = A_OpExp(EM_tokPos, A_gtOp, $1, $3); }
        | exp GE exp                                    { $$ = A_OpExp(EM_tokPos, A_geOp, $1, $3); }

bool_exp: exp AND exp                                   { $$ = A_IfExp(EM_tokPos, $1, $3, A_IntExp(EM_tokPos, 0)); }
        | exp OR exp                                    { $$ = A_IfExp(EM_tokPos, $1, A_IntExp(EM_tokPos, 1), $3); }

record_create_exp: ID LBRACE RBRACE                                     { $$ = A_RecordExp(EM_tokPos, S_Symbol($1), NULL); }
                 | ID LBRACE record_create_exp_no_empty RBRACE          { $$ = A_RecordExp(EM_tokPos, S_Symbol($1), $3); }

record_create_exp_no_empty: ID EQ exp                                   { $$ = A_EfieldList(A_Efield(S_Symbol($1), $3), NULL); }
                          | record_create_exp_no_empty COMMA ID EQ exp  { $$ = A_EfieldList(A_Efield(S_Symbol($3), $5), $1); }

array_create_exp: ID LBRACK exp RBRACK OF exp                           { $$ = A_ArrayExp(EM_tokPos, S_Symbol($1), $3, $6); }

decs: /* empty */                                                       { $$ = NULL; }
    | decs dec                                                          { $$ = A_DecList($2, $1); }    

dec: typedeclist        { $$ = $1; }
   | vardec             { $$ = $1; }
   | fundeclist         { $$ = $1; }

typedeclist: typedec %prec LOW              { $$ = A_TypeDec(EM_tokPos, A_NametyList($1, NULL)); }
         | typedec typedeclist              { $$ = A_TypeDec(EM_tokPos, A_NametyList($1, $2->u.type)); }

typedec: TYPE ID EQ ty          { $$ = A_Namety(S_Symbol($2), $4); }

ty: ID                          { $$ = A_NameTy(EM_tokPos, S_Symbol($1)); }
  | LBRACE tyfields RBRACE      { $$ = A_RecordTy(EM_tokPos, $2);}
  | ARRAY OF ID                 { $$ = A_ArrayTy(EM_tokPos, S_Symbol($3)); }

tyfields: /* empty */           { $$ = NULL; }
        | tyfields_no_empty     { $$ = $1; }        

tyfields_no_empty : tyfield                                     { $$ = A_FieldList($1, NULL); }
                  | tyfields_no_empty COMMA tyfield             { $$ = A_FieldList($3, $1); }

tyfield: ID COLON ID                                            { $$ = A_Field(EM_tokPos, S_Symbol($1), S_Symbol($3)); }

vardec: VAR ID ASSIGN exp                                       { $$ = A_VarDec(EM_tokPos, S_Symbol($2), NULL, $4); }
      | VAR ID COLON ID ASSIGN exp                              { $$ = A_VarDec(EM_tokPos, S_Symbol($2), S_Symbol($4), $6); }

fundeclist: fundec %prec LOW    { $$ = A_FunctionDec(EM_tokPos, A_FundecList($1, NULL)); }
          | fundec fundeclist   { $$ = A_FunctionDec(EM_tokPos, A_FundecList($1, $2->u.function)); }

fundec: FUNCTION ID LPAREN tyfields RPAREN EQ exp               { $$ = A_Funcdec(EM_tokPos, S_Symbol($2), $4, NULL, $7); }
      | FUNCTION ID LPAREN tyfields RPAREN COLON ID EQ exp      { $$ = A_Funcdec(EM_tokPos, S_Symbol($2), $4, S_Symbol($7), $9); }

lvalue: ID                              { $$ = A_SimpleVar(EM_tokPos, S_Symbol($1)); }
      | lvalue DOT ID                   { $$ = A_FieldVar(EM_tokPos, $1, S_Symbol($3)); }
      | ID LBRACK exp RBRACK            { $$ = A_SubscriptVar(EM_tokPos, A_SimpleVar(EM_tokPos, S_Symbol($1)), $3); }
      | lvalue LBRACK exp RBRACK        { $$ = A_SubscriptVar(EM_tokPos, $1, $3); }

