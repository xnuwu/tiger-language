#include <stdlib.h>
#include "absyn.h"
#include "types.h"
#include "semant.h"
#include "env.h"
#include "errormsg.h"
#include "util.h"
#include <stdio.h>

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
            if(e.ty->kind != Ty_record) {
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
             EM_error(e->pos, "not support comment yet.");
        }
        break;
        case A_callExp: {
            E_enventry f = S_look(venv, e->u.call.func);
            if (f && f->kind == E_funEntry) {
                // validate function params type
                Ty_tyList paramTys = f -> u.fun.formals;
                A_expList args = e->u.call.args;
                
                while (paramTys && paramTys->head->kind != Ty_void && args)
                {
                    struct expty argTy = transExp(venv, tenv, args->head);
                    if (!is_equal_ty(paramTys->head, argTy.ty)) {
                        EM_error(args->head->pos, "function call param mismatch");
                    } else {
                        args = args->tail;
                        paramTys = paramTys->tail;
                    }
                }

                if (!args && paramTys && paramTys->head->kind != Ty_void) {
                    EM_error(e->pos, "%s function miss param", S_name(e->u.call.func));
                } else if (args && (!paramTys || (paramTys && paramTys->head->kind == Ty_void))) {
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
                } else if (left.ty->kind == Ty_int || left.ty->kind == Ty_string){
                    return expTy(NULL, Ty_Int());
                } else {
                        EM_error(e->u.op.right->pos, "lt/le/ge/gt compare only support integer/string");
                }
            }
            assert(0 && "Invalid operator in expression");
        }
        break;
        case A_recordExp: {
            Ty_ty typ = S_look(tenv, e->u.record.typ);
            if (!typ) {
                EM_error(e->pos, "undefined type");
            } else if (typ->kind != Ty_record) {
                EM_error(e->pos, "%s is not a record", S_name(e->u.record.typ));
            } else {
                Ty_fieldList tyList = typ->u.record;
                A_efieldList fieldList = e->u.record.fields;
                while (tyList && fieldList) {
                    struct expty fieldTy = transExp(venv, tenv, fieldList->head->exp);
                    if (tyList->head->name != fieldList->head->name) {
                        EM_error(fieldList->head->exp->pos, "%s is not a valid record field in %s", S_name(fieldList->head->name), S_name(e->u.record.typ));
                    }
                    if(!is_equal_ty(tyList->head->ty, fieldTy.ty)) {
                        EM_error(fieldList->head->exp->pos, "record field %s type not match", S_name(tyList->head->name));
                    } else {
                        fieldList = fieldList->tail;
                        tyList = tyList -> tail;
                    }

                    if(fieldList && !tyList) {
                        EM_error(fieldList->head->exp->pos, "field %s not exist in record %s", S_name(fieldList->head->name), S_name(e->u.record.typ));
                    } else if (!fieldList && tyList) {
                        EM_error(e->pos, "record %s missing field %s", S_name(e->u.record.typ), S_name(tyList->head->name));
                    } else {
                        return expTy(NULL, typ);
                    }
                }
            }         
        }
        break;
        case A_seqExp: {
            A_expList seq = e->u.seq;
            struct expty ety;
            while(seq) {
                ety = transExp(venv, tenv, seq->head);
                seq = seq -> tail;
            }
            return expTy(NULL, ety.ty);
        }
        break;
        case A_assignExp: {
            struct expty vty = transVar(venv, tenv, e->u.assign.var);
            struct expty ety = transExp(venv, tenv, e->u.assign.exp);
            if(!is_equal_ty(vty.ty, ety.ty)) {
                EM_error(e->pos, "exp can't assign to type");
            } else {
                return expTy(NULL, vty.ty);
            }
        }
        break;
        case A_ifExp: {
            struct expty iffexp, thenexp, elseexp;
            iffexp = transExp(venv, tenv, e->u.iff.test);
            if (iffexp.ty->kind != Ty_int) {
                EM_error(e->u.iff.test->pos, "if exp result must is integer value");
            }
            thenexp = transExp(venv, tenv, e->u.iff.then);
            if (e->u.iff.elsee) {
                // must return same type
                elseexp = transExp(venv, tenv, e->u.iff.elsee);
                if (!is_equal_ty(thenexp.ty, elseexp.ty)) {
                    EM_error(e->u.iff.elsee->pos, "then and else must return same type");
                } else {
                    return expTy(NULL, elseexp.ty);
                }
            } else {
                // must no return value
                if (thenexp.ty->kind != Ty_void) {
                    EM_error(e->u.iff.then->pos, "signle then should'nt return any type");
                } else {
                    return expTy(NULL, Ty_Void());
                }
            }

        } break;
        case A_whileExp: {
            struct expty whileexp = transExp(venv, tenv, e->u.whilee.test);
            if(whileexp.ty->kind != Ty_int) {
                EM_error(e->u.iff.test->pos, "while test exp result must is integer value");
            } else {
                struct expty bodyexp = transExp(venv, tenv, e->u.whilee.body);
                if (bodyexp.ty->kind != Ty_void) {
                     EM_error(e->u.iff.then->pos, "while body should'nt return any type");
                }
                return expTy(NULL, Ty_Void());
            }
        } break;
        case A_forExp: {
            // TODO for exp
            struct expty loexp, hiexp, bodyexp;
            loexp = transExp(venv, tenv, e->u.forr.lo);
            return expTy(NULL, Ty_Void());
        }
        break;
        case A_breakExp: {
            return expTy(NULL, Ty_Void());
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
                transDec(venv, tenv, d -> head);
            }
            exp = transExp(venv, tenv, e->u.let.body);
            S_endScope(tenv);
            S_endScope(venv);
            return exp;
        }
        break;
        case A_arrayExp: {
            Ty_ty typ = S_look(tenv, e->u.array.typ);
            if (!typ) {
                EM_error(e->pos, "undefined array type %s", S_name(e->u.array.typ));
            } else {
                struct expty initexp = transExp(venv, tenv, e->u.array.init);
                struct expty sizeexp = transExp(venv, tenv, e->u.array.size);
                if (sizeexp.ty->kind != Ty_int) {
                    EM_error(e->u.array.init->pos, "array size must be integer");
                }
                if (!is_equal_ty(typ->u.name.ty->u.array, initexp.ty)) {
                    EM_error(e->u.array.init->pos, "init type not match array type");
                }
                return expTy(NULL, typ);
            }
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
        printf("tran var dec %s\r\n", S_name(d->u.var.var));
    }
    break;
    case A_typeDec:
    {
        A_nametyList next = d->u.type;
        bool isCycleType = TRUE;
        // put header part, in case of recursive type define.
        while (next)
        {
            printf("tran type dec %s\r\n", S_name(next->head->name));
            S_enter(tenv, next->head->name, Ty_Name(next->head->name, NULL));
            next = next->tail;
        }
        // inject body part
        next = d->u.type;
        while (next)
        {
            Ty_ty ty = transTy(tenv, next->head->ty);
            if(isCycleType) {
                if(ty->kind != Ty_name) {
                    isCycleType = FALSE;
                }
            }
            Ty_ty nameTy = S_look(tenv, next->head->name);
            nameTy->u.name.ty = ty;
            next = next->tail;
        }
        if (isCycleType) {
            EM_error(d->pos, "illegal type cycle: cycle must contain Ty_record Ty_array or builtin-type");
        }
    }
    break;
    case A_functionDec:
    {
        // register function type
        A_fundecList next = d->u.function;
        A_fundec f;
        while(next) {
            f = next->head;
            printf("tran function dec %s\r\n", S_name(next->head->name));
            Ty_ty resultTy = NULL;
            if (f->result) {
                resultTy = S_look(tenv, f->result);
                if (!resultTy) {
                    EM_error(f->pos, "undefined function return type");
                }
            }
            if (!resultTy) {
                resultTy = Ty_Void();
            }
            Ty_tyList formalTys = makeFormalTyList(tenv, f->params);
            S_enter(venv, f->name, E_FunEntry(formalTys, resultTy));
            next = next->tail;
        }

        // register function body
        next = d->u.function;
        while(next) {
            f = next->head;
            E_enventry fnEntry = S_look(venv, f->name);
            Ty_tyList formalTys = fnEntry->u.fun.formals;
            Ty_ty resultTy = fnEntry->u.fun.result;
            S_beginScope(venv);
            {
                A_fieldList l;
                Ty_tyList t;
                for (l = f->params, t = formalTys; l; l = l->tail, t = t->tail)
                {
                    S_enter(venv, l->head->name, E_VarEntry(t->head));
                }
            }
            struct expty exTy = transExp(venv, tenv, f->body);
            if(!is_equal_ty(fnEntry->u.fun.result, exTy.ty)) {
                EM_error(f->body->pos, "incorrect return type");
            }
            S_endScope(venv);
            next = next->tail;
        }
    }
    break;
    }
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
        Ty_fieldList fields = makeFieldTys(tenv, t->u.record);
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
        next = next -> tail;
    }
    if (tailList == NULL) {
        tailList = Ty_TyList(Ty_Void(), NULL);
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