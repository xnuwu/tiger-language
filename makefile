a.out: parse.o y.tab.o lex.yy.o errormsg.o util.o prabsyn.o absyn.o symbol.o table.o env.o types.o semant.o
	cc -g parse.o y.tab.o lex.yy.o errormsg.o util.o prabsyn.o absyn.o symbol.o table.o env.o types.o semant.o

semant.o: semant.c semant.h types.h env.h
	cc -g -c semant.c

types.o: types.c types.h env.h
	cc -g -c types.c 

env.o: env.c env.h
	cc -g -c env.c

parse.o: parse.c errormsg.h util.h
	cc -g -c parse.c

prabsyn.o: prabsyn.c prabsyn.h util.h symbol.h absyn.h
	cc -g -c prabsyn.c

absyn.o: absyn.c absyn.h util.h symbol.h
	cc -g -c absyn.c

symbol.o: symbol.c symbol.h util.h table.h
	cc -g -c symbol.c

table.o: table.c table.h util.h
	cc -g -c table.c

y.tab.o: y.tab.c
	cc -g -c y.tab.c

y.tab.c: tiger.yacc
	/usr/local/bin/bison --version
	/usr/local/bin/bison -dvty tiger.yacc

y.tab.h: y.tab.c
	
errormsg.o: errormsg.c errormsg.h util.h
	cc -g -c errormsg.c

lex.yy.o: lex.yy.c y.tab.h errormsg.h util.h
	cc -g -c lex.yy.c

lex.yy.c: tiger.lex
	/usr/local/bin/flex --version
	/usr/local/bin/flex tiger.lex

util.o: util.c util.h
	cc -g -c util.c

clean: 
	rm -f y.output a.out util.o parse.o lex.yy.o errormsg.o y.tab.c y.tab.h y.tab.o env.o types.o semant.o y.tab.o prabsyn.o absyn.o symbol.o table.o lex.yy.c pr_exp.txt