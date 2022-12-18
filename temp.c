#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "temp.h"
#include "table.h"
#include "symbol.h"

struct Temp_temp_ {
    int num;
};

string Temp_labelstring(Temp_label s) {
    return S_name(s);
}

static int labels = 0;

Temp_label Temp_newlabel(void) {
    char buf[100];
    sprintf(buf, "L%d", labels++);
    return Temp_namedlabel(String(buf));
}

Temp_label Temp_namedlabel(string s) {
    return S_Symbol(s);
}

static int temps = 100;

Temp_temp Temp_newtemp(void) {
    Temp_temp p = (Temp_temp) checked_malloc(sizeof(*p));
    p->num = temps++;
    char buf[16];
    sprintf(buf, "T%d", p->num);
    Temp_enter(Temp_name(), p, String(buf));
    return p;
}

struct Temp_map_ {
    TAB_table tab;
    Temp_map under;
};

Temp_map Temp_name(void) {
    static Temp_map m = NULL;
    if (!m) {
        m = Temp_empty();
    }
    return m;
}

Temp_map newMap(TAB_table tab, Temp_map under) {
    Temp_map m = checked_malloc(sizeof(*m));
    m->tab = tab;
    m->under = under;
    return m;
}

Temp_map Temp_empty(void) {
    return newMap(TAB_empty(), NULL);
}

Temp_map Temp_layerMap(Temp_map over, Temp_map under) {
    if (over == NULL) {
        return under;
    } else {
        return newMap(over->tab, Temp_layerMap(over->under, under));
    }
}

void Temp_enter(Temp_map m, Temp_temp t, string s) {
    assert(m && m->tab);
    TAB_enter(m->tab, t, s);
}

string Temp_look(Temp_map m, Temp_temp t) {
    string s;
    assert(m && m->tab);
    s = TAB_look(m->tab, t);
    if (s) {
        return s;
    } else if (m->under) {
        return Temp_look(m->under, t);
    } else {
        return NULL;
    }
}

Temp_tempList Temp_TempList(Temp_temp head, Temp_tempList tail) {
    Temp_tempList p = (Temp_tempList) checked_malloc(sizeof(*p));
    p->head = head;
    p->tail = tail;
    return p;
}

Temp_labelList Temp_LabelList(Temp_label head, Temp_labelList tail) {
    Temp_labelList p = (Temp_labelList) checked_malloc(sizeof(*p));
    p -> head = head;
    p -> tail = tail;
}

static FILE *outfile;
void showit(Temp_temp t, string str) {
    fprintf(outfile, "t%d -> %s\n", t->num, str);
}

void Temp_dumpMap(FILE* out, Temp_map map) {
    outfile = out;
    TAB_dump(map -> tab, (void(*)(void*, void*)) showit);
    if(map->under) {
        fprintf(out, "------------\n");
        Temp_dumpMap(out, map -> under);
    }
}