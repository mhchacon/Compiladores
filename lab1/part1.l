%option yylineno
%option noyywrap

%{
#include <stdio.h>
#include <stdlib.h>
%}

%x COMENTARIO
%x STRING

%%



"/*" {
printf("INICIO DE COMENTARIO\n");
BEGIN(COMENTARIO);
}

<COMENTARIO>"*/" {
printf("FIM DE COMENTARIO\n");
BEGIN(INITIAL);

}

<COMENTARIO>\n {
/* ignora quebra de linha */
}

<COMENTARIO>. {
/* ignora qualquer outro caractere */
}

\" {
BEGIN(STRING);
}

<STRING>\" {
BEGIN(INITIAL);
}

<STRING>\n {
fprintf(stderr, "Erro: String nao fechada.\n");
exit(1);

}

<STRING>[^\"\n]+ {
/* ignora qualquer caractere dentro da string */
printf("LINHA %d: STRING(%s)\n", yylineno, yytext);
}


"else" { printf("LINHA %d: ELSE(%s)\n", yylineno,yytext); }
"if" { printf("LINHA %d: IF(%s)\n", yylineno, yytext); }
"while" { printf("LINHA %d: WHILE(%s)\n", yylineno,yytext); }
"import" { printf("LINHA %d: IMPORT(%s)\n", yylineno,yytext); }
"except" { printf("LINHA %d: EXCEPT(%s)\n", yylineno,yytext); }
"return" { printf("LINHA %d: RETURN(%s)\n", yylineno,yytext); }
"False" { printf("LINHA %d: False(%s)\n", yylineno,yytext); }
"elif" { printf("LINHA %d: ELIF(%s)\n", yylineno,yytext); }

[a-zA-Z_][a-zA-Z0-9_]* { printf("LINHA %d: IDENTIFIER(%s)\n", yylineno, yytext); }
[0-9]+\.[0-9]+ { printf("LINHA %d: REAL(%s)\n", yylineno, yytext); }
[0-9]+ { printf("LINHA %d: INTEGER(%s)\n", yylineno, yytext); }
"#".* { } 

[ \t\n]+ { }
. { printf("LINHA %d: SIMBOLO(%s)\n", yylineno, yytext); }


%%

int main(int argc, char **argv) {

if (argc < 2) {
fprintf(stderr, "Erro: Uso correto: %s <nome_do_arquivo_entrada>\n", argv[0]);
exit(1);
}

FILE *arquivo = fopen(argv[1], "r");
if (!arquivo) {
fprintf(stderr, "Erro: Nao foi possivel abrir o arquivo '%s'.\n", argv[1]);
exit(1);
}


yyin = arquivo;

yylex();

fclose(arquivo); 
return 0;
}