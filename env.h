#include "types.h"

typedef struct E_enventry_ *E_enventry;

struct E_enventry_ {
    enum {
        E_varEntry,
        E_funEntry
    } kind;
    union {
        struct {
            Ty_ty ty;
        } var;
        struct {
            Ty_tyList formals;
            Ty_tyList result;
        } fun;
    } u;
};

E_enventry E_VarEntry(Ty_ty ty);
E_enventry E_FunEntry(Ty_tyList formals, Ty_ty result);

/** Ty_ty environment */
S_table E_base_tenv(void);
/** E_enventry environment */
S_table E_base_venv(void);