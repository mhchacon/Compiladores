calc: calc.y calc.l
	bison -d calc.y
	flex calc.l
	gcc -o calc calc.tab.c lex.yy.c -lm

delc: delc.y delc.l
	bison -d delc.y
	flex delc.l
	gcc -o delc delc.tab.c lex.yy.c

decl: delc.y delc.l
	bison -d delc.y
	flex delc.l
	gcc -o decl delc.tab.c lex.yy.c

clean:
	rm -f calc calc.tab.c calc.tab.h lex.yy.c delc delc.tab.c delc.tab.h decl decl.tab.c decl.tab.h