#include <assert.h>

#ifndef UTIL
#define UTIL

typedef char *string;
typedef char boolean;

#define TRUE 1
#define FALSE 0

void *checked_malloc(int);
string String(char *);

typedef struct U_boolList_ *U_boolList;
struct U_boolList_
{
    boolean head;
    U_boolList tail;
};
U_boolList U_BoolList(boolean head, U_boolList tail);

#endif
