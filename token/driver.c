#include <stdio.h>
#include <stdlib.h>
#include "util.h"
#include "errormsg.h"
#include "tokens.h"

YYSTYPE yylval;

int yylex(void); /* prototype for the lexing function */

string toknames[] = {
    "ID", "STRING", "INT", "COMMA", "COLON", "SEMICOLON", "LPAREN",
    "RPAREN", "LBRACK", "RBRACK", "LBRACE", "RBRACE", "DOT", "PLUS",
    "MINUS", "TIMES", "DIVIDE", "EQ", "NEQ", "LT", "LE", "GT", "GE",
    "AND", "OR", "ASSIGN", "ARRAY", "IF", "THEN", "ELSE", "WHILE", "FOR",
    "TO", "DO", "LET", "IN", "END", "OF", "BREAK", "NIL", "FUNCTION",
    "VAR", "TYPE", "CMT"};

string tokname(int tok)
{
    return tok < 257 || tok > 300 ? "BAD_TOKEN" : toknames[tok - 257];
}

int colPos = 1;
int rowPos = 1;
extern int yyleng;

int main(int argc, char **argv)
{
    printf("start:\r\n");
    string fname;
    int tok;
    if (argc != 2)
    {
        fprintf(stderr, "usage: a.out filename\n");
        exit(1);
    }
    fname = argv[1];
    EM_reset(fname);
    for (;;)
    {
        tok = yylex();
        if (tok == 0) {
            break;
        }
        switch (tok)
        {
        case ID:
        case STRING:
            printf("%10s %3d:%-3d %s\n", tokname(tok), rowPos, colPos - yyleng, yylval.sval);
            break;
        case INT:
            printf("%10s %3d:%-3d %d\n", tokname(tok), rowPos, colPos - yyleng, yylval.ival);
            break;
        default:
            printf("%10s %3d:%-3d\n", tokname(tok), rowPos, colPos - yyleng);
        }
    }
    return 0;
}
