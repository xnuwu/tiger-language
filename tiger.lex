%{
#include <string.h>
#include <stdlib.h>
#include "util.h"
#include "errormsg.h"
#include "symbol.h"
#include "absyn.h"
#include "y.tab.h"

int charPos=1;

int yywrap(void)
{
 charPos=1;
 return 1;
}

extern int rowPos;
extern int colPos;

void adjust(void)
{
 EM_tokPos=charPos;
 charPos+=yyleng;
 colPos+=yyleng;
}

%}
%x COMMENT
BLANK               ([ \t\r\a]+)
ID                  ([_a-zA-Z][_a-zA-Z0-9]*)
STRING              (\042[^\042\n]*\042)

%%
{BLANK}	        {adjust(); continue;}
\n	            {adjust(); EM_newline(); continue;}
","	            {adjust(); return COMMA;}
":"             {adjust(); return COLON;}
";"             {adjust(); return SEMICOLON;}
"("             {adjust(); return LPAREN;}
")"             {adjust(); return RPAREN;}
"["             {adjust(); return LBRACK;}
"]"             {adjust(); return RBRACK;}
"{"             {adjust(); return LBRACE;}
"}"             {adjust(); return RBRACE;}
"."             {adjust(); return DOT;}
"+"             {adjust(); return PLUS;}
"-"             {adjust(); return MINUS;}
"*"             {adjust(); return TIMES;}
"/"             {adjust(); return DIVIDE;}
"="             {adjust(); return EQ;}
"<>"            {adjust(); return NEQ;}
"<"             {adjust(); return LT;}
"<="            {adjust(); return LE;}
">"             {adjust(); return GT;}
">="            {adjust(); return GE;}
"&"             {adjust(); return AND;}
"|"             {adjust(); return OR;}
":="            {adjust(); return ASSIGN;}
"array"         {adjust(); return ARRAY;}
"if"            {adjust(); return IF;}
"then"          {adjust(); return THEN;}
"else"          {adjust(); return ELSE;}
"while"         {adjust(); return WHILE;}
"for"           {adjust(); return FOR;}
"to"            {adjust(); return TO;}
"do"            {adjust(); return DO;}
"let"           {adjust(); return LET;}
"in"            {adjust(); return IN;}
"end"           {adjust(); return END;}
"of"            {adjust(); return OF;}
"break"         {adjust(); return BREAK;}
"nil"           {adjust(); return NIL;}
"function"      {adjust(); return FUNCTION;}
"var"           {adjust(); return VAR;}
"type"          {adjust(); return TYPE;}
[0-9]+	        {adjust(); yylval.ival=atoi(yytext); return INT;}
{ID}            {adjust(); yylval.sval=yytext; return ID;}
{STRING}        {adjust(); yylval.sval=yytext; return STRING;}
<INITIAL>"/**"  {adjust(); BEGIN(COMMENT); return CMT;}
<COMMENT>.      {adjust();}
<COMMENT>"**/"  {adjust(); BEGIN(INITIAL);}
<<EOF>>         {return 0;}
.	            {adjust(); EM_error(EM_tokPos,"illegal token");}
