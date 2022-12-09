#include "env.h"
#include "stdlib.h"

E_enventry E_VarEntry(Ty_ty ty) {
    E_enventry e = checked_malloc(sizeof(*e));
    e->kind = E_varEntry;
    e->u.var.ty = ty;
    return e;
}

E_enventry E_FunEntry(Ty_tyList formals, Ty_ty result) {
    E_enventry e = checked_malloc(sizeof(*e));
    e->kind = E_funEntry;
    e->u.fun.formals = formals;
    e->u.fun.result = result;
    return e;
}

S_table E_base_tenv(void) {
    S_table table = S_empty();
    S_enter(table, S_Symbol("int"), Ty_Int());
    S_enter(table, S_Symbol("string"), Ty_String());
    return table;
}

S_table E_base_venv(void) {
    S_table table = S_empty();

    // function print(s: string)
    S_enter(table, S_Symbol("print"), E_FunEntry(Ty_TyList(Ty_String(), NULL), Ty_Void()));
    
    // function flush()
    S_enter(table, S_Symbol("flush"), E_FunEntry(NULL, Ty_Void()));
    
    // function getchar(): string
    S_enter(table, S_Symbol("getchar"), E_FunEntry(NULL, Ty_String()));
    
    // function ord(s: string): int
    S_enter(table, S_Symbol("ord"), E_FunEntry(Ty_TyList(Ty_String(), NULL), Ty_Int()));
    
    // function chr(i: int): string
    S_enter(table, S_Symbol("chr"), E_FunEntry(Ty_TyList(Ty_Int(), NULL), Ty_String()));
    
    // function size(s: string): int
    S_enter(table, S_Symbol("size"), E_FunEntry(Ty_TyList(Ty_String(), NULL), Ty_Int()));
    
    // function substring(s: string, first: int, n: int) : string
    S_enter(table, S_Symbol("substring"), E_FunEntry(Ty_TyList(Ty_String(), Ty_TyList(Ty_Int(), Ty_TyList(Ty_Int(), NULL))), Ty_String()));
   
    // function concat(s1: string, s2: string): string
    S_enter(table, S_Symbol("concat"), E_FunEntry(Ty_TyList(Ty_String(), Ty_TyList(Ty_String(), NULL)), Ty_String()));
    
    // function not(i: int): int
    S_enter(table, S_Symbol("not"), E_FunEntry(Ty_TyList(Ty_Int(), NULL), Ty_Int()));
    
    // function exit(i: int)
    S_enter(table, S_Symbol("exit"), E_FunEntry(Ty_TyList(Ty_Int(), NULL), Ty_Void()));
    return table;
}