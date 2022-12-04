#include <stdlib.h>
#include "absyn.h"
#include "types.h"
#include "semant.h"
#include "env.h"
#include "errormsg.h"
#include "util.h"

struct expty transVar(S_table venv, S_table tenv, A_var v)
{
    switch (v->kind) {
        case A_simpleVar: {
            E_enventry x = S_look(venv, v->u.simple);
            if (x && x->kind == E_varEntry)
            {
                return expTy(NULL, actual_ty(x->u.var.ty));
            }
            else
            {
                EM_error(v->pos, "undefined variable %s", S_name(v->u.simple));
            }
        }
        break;
        case A_fieldVar: {
            struct expty e = transVar(venv, tenv, v->u.field.var);
            if(e.ty->kind != Ty_Record) {
                EM_error(v->u.field.var->pos, "variable not a record type");
            } else {
                Ty_fieldList f;
                for(f = e.ty->u.record; f; f = f->tail) {
                    if (f->head->name == v->u.field.sym) {
                        return expTy(NULL, actual_ty(f->head->ty));
                    }
                }
                EM_error(v->pos, "no such field %s in record type", S_name(v->u.field.sym));
            }
        }
        break;
        case A_subscriptVar: {
            struct expty varTy = transVar(venv, tenv, v->u.subscript.var);
            if (varTy.ty->kind != Ty_array) {
                EM_error( v->u.subscript.var->pos, "variable not a array");
            } else {
                struct expty e = transExp(venv, tenv, v->u.subscript.exp);
                if (e.ty->kind != Ty_int) {
                    EM_error(v->pos, "subscript index must be Integer");
                } else {
                    return expTy(NULL, actual_ty(varTy.ty->u.array));
                }
            }
        }
        break;
    }
    assert(0);
}

struct expty transExp(S_table venv, S_table tenv, A_exp e) {
    switch (e->kind)
    {
        case A_varExp: {
            return transVar(venv, tenv, e->u.var);
        }
        break;
        case A_nilExp: {
            return expTy(NULL, Ty_Nil());
        }
        break;
        case A_intExp: {
            return expTy(NULL, Ty_Int());
        }
        break;
        case A_stringExp: {
            return expTy(NULL, Ty_String());
        }
        break;
        case A_commentExp: {
            // TODO handle comment
        }
        break;
        case A_callExp: {
            E_enventry f = S_look(venv, e->u.call.func);
            if (f && f->kind == E_funEntry) {
                // validate function params type
                Ty_tyList paramTys = f -> u.fun.formals;
                A_expList args = e->u.call.args;
                
                while (paramTys && args)
                {
                    struct expty argTy = transExp(venv, tenv, args->head);
                    if (!is_equal_ty(paramTys->head, argTy.ty)) {
                        EM_error(args->head->pos, "function call param mismatch");
                    } else {
                        args = args->tail;
                        paramTys = paramTys->tail;
                    }
                }

                if (!args && paramTys) {
                    EM_error(e->pos, "function miss param");
                } else if (args && !paramTys) {
                    EM_error(args->head->pos, "function call with too much args");
                } else {
                    return expTy(NULL, actual_ty(f->u.fun.result));
                }
            } else {
                EM_error(e->pos, "undefined function %s", S_name(e->u.call.func));
            }
        }
        break;
        case A_opExp:
        {
            A_oper oper = e->u.op.oper;
            struct expty left = transExp(venv, tenv, e->u.op.left);
            struct expty right = transExp(venv, tenv, e->u.op.right);
            if (oper == A_plusOp || oper == A_minusOp || oper == A_timesOp || oper == A_divideOp)
            {
                if (left.ty->kind != Ty_int)
                {
                    EM_error(e->u.op.left->pos, "integer required");
                }
                if (right.ty->kind != Ty_int)
                {
                    EM_error(e->u.op.right->pos, "integer required");
                }
                return expTy(NULL, Ty_Int());
            }
            if (oper == A_eqOp || oper == A_neqOp) {
                if (left.ty->kind == Ty_record) {
                    if (right.ty->kind != Ty_record && right.ty->kind != Ty_nil) {
                        EM_error(e->u.op.right->pos, "record compare with a no record/nil value");
                    } else {
                        return expTy(NULL, Ty_Int());
                    }
                }
                if (left.ty->kind == Ty_nil) {
                    if (!is_equal_ty(left.ty, right.ty)) {
                        EM_error(e->u.op.right->pos, "nil compare with a invalid type");
                    } else {
                        return expTy(NULL, Ty_Int());
                    }
                }

                if (left.ty->kind == Ty_int) {
                    if (!is_equal_ty(left.ty, right.ty)) {
                        EM_error(e->u.op.right->pos, "integer compare with a not integer value");
                    } else {
                        return expTy(NULL, Ty_Int());
                    }
                }
                if (left.ty->kind == Ty_string) {
                     if (!is_equal_ty(left.ty, right.ty)) {
                        EM_error(e->u.op.right->pos, "string compare with a not string value");
                    } else {
                        return expTy(NULL, Ty_Int());
                    }
                }
                
                if (left.ty->kind == Ty_array) {
                     if (!is_equal_ty(left.ty, right.ty)) {
                        EM_error(e->u.op.right->pos, "array compare with a invalid type");
                    } else {
                        return expTy(NULL, Ty_Int());
                    }
                }

                EM_error(e->u.op.left->pos, "unexpect expression in comparsion");
            }

            if (oper == A_ltOp || oper == A_leOp || oper == A_geOp || oper == A_gtOp) {
                if (!is_equal_ty(left.ty, right.ty)) {
                    EM_error(e->u.op.right->pos, "lt/le/ge/gt compare with a invalid type");
                } else if (left.ty == Ty_int || left.ty == Ty_string){
                    return expTy(NULL, Ty_Int());
                } else {
                        EM_error(e->u.op.right->pos, "lt/le/ge/gt compare only support integer/string");
                }
            }
            assert(0 && "Invalid operator in expression");
        }
        break;
        case A_recordExp: {
            
        }
        break;
        case A_letExp:
        {
            struct expty exp;
            A_decList d;
            S_beginScope(venv);
            S_beginScope(tenv);
            for (d = e->u.let.decs; d; d = d->tail)
            {
                transDec(venv, tenv, d);
            }
            exp = transExp(venv, tenv, e);
            S_endScope(tenv);
            S_endScope(venv);
            return exp;
        }
        break;
    }
    assert(0);
}

void transDec(S_table venv, S_table tenv, A_dec d)
{
    switch (d->kind)
    {
    case A_varDec:
    {
        struct expty e = transExp(venv, tenv, d->u.var.init);
        S_enter(venv, d->u.var.var, E_VarEntry(e.ty));
    }
    break;
    case A_typeDec:
    {
        A_nametyList next = d->u.type;
        while (next)
        {
            S_enter(tenv, next->head->name, next->head->ty);
            next = next->tail;
        }
    }
    break;
    case A_functionDec:
    {
        A_fundec f = d->u.function->head;
        Ty_ty resultTy = S_look(tenv, f->result);
        Ty_tyList formalTys = makeFormalTyList(tenv, f->params);
        S_enter(venv, f->name, E_FunEntry(formalTys, resultTy));
        S_beginScope(venv);
        {
            A_fieldList l;
            Ty_tyList t;
            for (l = f->params, t = formalTys; l; l = l->tail, t = t->tail)
            {
                S_enter(venv, l->head->name, E_VarEntry(t->head));
            }
        }
        transExp(venv, tenv, f->body);
        S_endScope(venv);
    }
    break;
    }
    assert(0);
}

Ty_ty transTy(S_table tenv, A_ty t)
{
    switch (t->kind)
    {
    case A_nameTy:
    {
        Ty_ty ty = S_look(tenv, t->u.name);
        if (!ty) {
            EM_error(t->pos, "undefined type %s", S_name(t->u.name));
        }
        return ty;
    }
    case A_recordTy:
    {
        Ty_fieldList fields = makeFieldTys(t->u.record);
        return Ty_Record(fields);
    }
    case A_arrayTy:
    {
        Ty_ty ty = S_look(tenv, t->u.name);
        if (!ty) {
            EM_error(t->pos, "undefined type %s", S_name(t->u.name));
        }
        return Ty_Array(ty);
    }
    }
    assert(0);
}

Ty_tyList makeFormalTyList(S_table tenv, A_fieldList params)
{
    Ty_tyList tailList = NULL;
    A_fieldList next = params;
    while (next)
    {
        A_field param = next->head;
        Ty_ty paramTy = S_look(tenv, param->typ);
        if (paramTy)
        {
            tailList = Ty_TyList(paramTy, tailList);
        }
        else
        {
            EM_error(next->head->pos, "function param undefined type %s", param->name);
        }
    }
    return tailList;
}

Ty_fieldList makeFieldTys(S_table tenv, A_fieldList fieldList) {
    Ty_fieldList fieldTys = NULL;
    Ty_fieldList tailList = fieldTys;
    A_fieldList fields = fieldList;
    for(; fields; fields = fields->tail ) {
        Ty_ty ty = S_look(tenv, fields->head->typ);
        if (!ty) {
            EM_error(fields->head->pos, "undefined type %s", S_name(fields->head->typ));
        }
        if (fieldTys) {
            tailList -> tail = Ty_FieldList(Ty_Field(fields->head->name, ty), NULL);
            tailList = tailList->tail;
        } else {
            fieldTys = Ty_FieldList(Ty_Field(fields->head->name, ty), NULL);
            tailList = fieldTys;
        }
    }
    return fieldTys;
}

Ty_ty actual_ty(Ty_ty ty)
{
    if (ty->kind == Ty_name)
    {
        return actual_ty(ty->u.name.ty);
    }

    return ty;
}

boolean is_equal_ty(Ty_ty tTy, Ty_ty eTy) {
    Ty_ty actualType = actual_ty(tTy);
    int tKind = actualType->kind;
    int eKind = eTy->kind;

    if ((tKind == Ty_record || tKind == Ty_array) && eKind == tKind) {
        return TRUE;
    }

    if (tKind == Ty_record && eKind == Ty_nil) {
        return TRUE;
    }

    if (tKind != Ty_record && tKind != Ty_array && eKind == tKind) {
        return TRUE;
    }
    return FALSE;
}
void SEM_transProg(A_exp exp)
{
    S_table venv = E_base_venv();
    S_table tenv = E_base_tenv();
    transExp(venv, tenv, exp);
}