#include "absyn.h"
#include "symbol.h"
#include "types.h"
#include "util.h"

#ifndef SEMANT
#define SEMANT

//TODO add Tr_exp
typedef void* Tr_exp;

struct expty {
       Tr_exp exp;
       Ty_ty ty;
};

static struct expty expTy(Tr_exp exp, Ty_ty ty) {
       struct expty e;
       e.exp = exp;
       e.ty = ty;
       return e;
}

struct expty transVar(S_table venv, S_table tenv, A_var v);
struct expty transExp(S_table venv, S_table tenv, A_exp e);
void transDec(S_table venv, S_table tenv, A_dec d);
Ty_ty transTy(S_table tenv, A_ty t);
Ty_tyList makeFormalTyList(S_table tenv, A_fieldList params);
Ty_fieldList makeFieldTys(S_table tenv, A_fieldList fieldList) ;
static Ty_ty actual_ty(Ty_ty ty);
static boolean is_equal_ty(Ty_ty tTy, Ty_ty eTy);
void SEM_transProg(A_exp exp);

#endif