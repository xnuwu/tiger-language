lextest: driver.o lex.yy.o errormsg.o util.o
	clang-15 -g -o lextest driver.o lex.yy.o errormsg.o util.o

driver.o: driver.c tokens.h errormsg.h util.h
	clang-15 -g -c driver.c

errormsg.o: errormsg.c errormsg.h util.h
	clang-15 -g -c errormsg.c

lex.yy.o: lex.yy.c tokens.h errormsg.h util.h
	clang-15 -g -c lex.yy.c

lex.yy.c: tiger.lex
	lex tiger.lex

util.o: util.c util.h
	clang-15 -g -c util.c

clean: 
	rm -f a.out util.o driver.o lex.yy.o lex.yy.c errormsg.o