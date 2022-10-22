a.out: parse.o y.tab.o lex.yy.o errormsg.o util.o
	cc -g parse.o y.tab.o lex.yy.o errormsg.o util.o

parse.o: parse.c errormsg.h util.h
	cc -g -c parse.c

y.tab.o: y.tab.c
	cc -g -c y.tab.c

y.tab.c: tiger.yacc
	bison -dvty tiger.yacc

y.tab.h: y.tab.c
	echo "y.tab.h was created at the same time as y.tab.c"

errormsg.o: errormsg.c errormsg.h util.h
	cc -g -c errormsg.c

lex.yy.o: lex.yy.c y.tab.h errormsg.h util.h
	cc -g -c lex.yy.c

# lex.yy.c: tiger.lex
# 	lex tiger.lex

util.o: util.c util.h
	cc -g -c util.c

clean: 
	rm -f y.output a.out util.o parse.o lex.yy.o errormsg.o y.tab.c y.tab.h y.tab.o