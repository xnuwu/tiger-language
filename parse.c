#include <stdio.h>
#include "util.h"
#include "symbol.h"
#include "absyn.h"
#include "errormsg.h"
#include "parse.h"
#include "prabsyn.h"

extern int yyparse(void);
extern A_exp absyn_root;

int colPos = 1;
int rowPos = 1;

A_exp parse(string fname)
{
    EM_reset(fname);
    if (yyparse() == 0) {
        /* parsing worked */
        fprintf(stderr, "Parsing successful!\n");
        return absyn_root;
    } else {
        fprintf(stderr, "Parsing failed\n");
        return NULL;
    }
}

int main() {
    FILE* fp = fopen("pr_exp.txt", "wb");
    parse("program.tig");
    pr_exp(fp, absyn_root, 0);
    fflush(fp);
    fclose(fp);
    return 0;
}