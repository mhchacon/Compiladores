%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
extern FILE *yyin;

char *sym_table[1000];
int sym_count = 0;
int var_count = 0;
char *current_type = NULL;

void add_var(char *name) {
    for(int i = 0; i < sym_count; i++) {
        if(strcmp(sym_table[i], name) == 0) {
            printf("erro: %s já foi declarada\n", name);
            free(name);
            return;
        }
    }
    sym_table[sym_count++] = strdup(name);
    printf("%s %s\n", current_type, name);
    var_count++;
    free(name);
}
%}

%union {
    char *sval;
}

%token <sval> TYPE ID

%%

program:
    decls { printf("+++++ %d variáveis declaradas\n", var_count); }
  ;

decls:
    /* vazio */
  | decls decl
  ;

decl:
    TYPE { current_type = $1; } id_list ';' { free(current_type); current_type = NULL; }
  ;

id_list:
    ID { add_var($1); }
  | id_list ',' ID { add_var($3); }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Erro: %s\n", s);
}

int main(int argc, char **argv) {
    if(argc > 1) {
        yyin = fopen(argv[1], "r");
        if(!yyin) {
            perror("fopen");
            return 1;
        }
    }
    yyparse();
    if(yyin) fclose(yyin);
    return 0;
}