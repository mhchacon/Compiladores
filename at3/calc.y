%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

void yyerror(const char *s);
int yylex(void);
extern FILE *yyin;

struct {
    char *name;
    double val;
} sym_table[1000];
int sym_count = 0;

void set_val(char *name, double val) {
    for(int i = 0; i < sym_count; i++) {
        if(strcmp(sym_table[i].name, name) == 0) {
            sym_table[i].val = val;
            return;
        }
    }
    sym_table[sym_count].name = strdup(name);
    sym_table[sym_count].val = val;
    sym_count++;
}

double get_val(char *name) {
    for(int i = 0; i < sym_count; i++) {
        if(strcmp(sym_table[i].name, name) == 0) {
            return sym_table[i].val;
        }
    }
    return 0.0;
}

void print_vars() {
    for(int i = 0; i < sym_count; i++) {
        printf("%s >>> %g\n", sym_table[i].name, sym_table[i].val);
    }
}
%}

%union {
    double dval;
    char *sval;
}

%token <dval> NUM
%token <sval> VAR
%token PRINT_VARS ASSIGN POW

%type <dval> expr

%left '+' '-'
%left '*' '/'
%right POW
%precedence UMINUS

%%

input:
    /* vazio */
  | input line
  ;

line:
    '\n'
  | stmt '\n'
  | stmt
  ;

stmt:
    VAR ASSIGN expr { set_val($1, $3); free($1); }
  | expr            { printf("=%g\n", $1); }
  | PRINT_VARS      { print_vars(); }
  ;

expr:
    NUM             { $$ = $1; }
  | VAR             { $$ = get_val($1); free($1); }
  | expr '+' expr   { $$ = $1 + $3; }
  | expr '-' expr   { $$ = $1 - $3; }
  | expr '*' expr   { $$ = $1 * $3; }
  | expr '/' expr   { $$ = $1 / $3; }
  | expr POW expr   { $$ = pow($1, $3); }
  | '-' expr %prec UMINUS { $$ = -$2; }
  | '(' expr ')'    { $$ = $2; }
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