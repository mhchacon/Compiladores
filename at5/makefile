valida: lex.yy.c valida.tab.c
	gcc -o valida lex.yy.c valida.tab.c

lex.yy.c: valida.l valida.tab.h
	flex valida.l

valida.tab.c valida.tab.h: valida.y
	bison -d valida.y

clean:
	rm -f valida lex.yy.c valida.tab.c valida.tab.h