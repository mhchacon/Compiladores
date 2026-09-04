%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;

void yyerror(const char *s);
%}

%token LBRACE RBRACE LBRACKET RBRACKET COMMA COLON
%token TRUE_TOK FALSE_TOK NULL_TOK STRING NUMBER

%%
json: value ;

value: STRING
     | NUMBER
     | TRUE_TOK
     | FALSE_TOK
     | NULL_TOK
     | object
     | array
     ;

object: LBRACE RBRACE
      | LBRACE members RBRACE
      ;

members: pair
       | members COMMA pair
       ;

pair: STRING COLON value
    ;

array: LBRACKET RBRACKET
     | LBRACKET elements RBRACKET
     ;

elements: value
        | elements COMMA value
        ;
%%

void yyerror(const char *s) {
    /* Função vazia propositalmente para suprimir as mensagens de erro padrão do Bison */
}

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            printf("JSON COM ERRO\n");
            return 1;
        }
    }
    
    /* yyparse() retorna 0 se a sintaxe for válida até o EOF, e 1 se encontrar erros */
    if (yyparse() == 0) {
        printf("JSON OK\n");
    } else {
        printf("JSON COM ERRO\n");
    }
    
    if (yyin) {
        fclose(yyin);
    }
    
    return 0;
}