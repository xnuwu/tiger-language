#include "absyn.h"
#include "symbol.h"
#include "types.h"

struct expty transVar(S_table venv, S_table tenv, A_var v);
struct expty transExp(S_table venv, S_table tenv, A_exp e);
void         transDec(S_table venv, S_table tenv, A_dec d);
       Ty_ty transTy(               S_table tenv, A_ty t);