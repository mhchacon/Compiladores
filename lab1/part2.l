%option noyywrap
%option yylineno

%{
#include <stdio.h>
#include <stdlib.h> 
%}

%x texto
%x COMENTARIO

%%

"/*" {
    BEGIN(COMENTARIO);
}

<COMENTARIO>"*/" {
    BEGIN(INITIAL);
}

<COMENTARIO>\n {
    /* ignora quebra de linha */
}

<COMENTARIO>. {
    /* ignora qualquer outro caractere */
}

\" { BEGIN(texto); }

<texto>\" { BEGIN(INITIAL); }

<texto>\n { 
    fprintf(stderr, "Erro: String nao fechada na linha %d.\n", yylineno);
    exit(1);
}

<texto>[^\"\n]+ { 
    printf("LINHA %d: STRING(%s)\n", yylineno, yytext); 
}

[ \t\n]+ { /* Ignorar espaços em branco e quebras de linha */ }

"se"              { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"senao"           { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"retorne"         { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"inicio"          { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"fim"             { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"booleano"        { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"para"            { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"de"              { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"inteiro"         { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"faz"             { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"ate"             { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"nao"             { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"real"            { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"faca"            { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"repita_enquanto" { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"leia"            { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }
"funcao"          { printf("LINHA %d: KEYWORD(%s)\n", yylineno, yytext); }

"+"               { printf("LINHA %d: OPERATOR(%s)\n", yylineno, yytext); }
"-"               { printf("LINHA %d: OPERATOR(%s)\n", yylineno, yytext); }
"*"               { printf("LINHA %d: OPERATOR(%s)\n", yylineno, yytext); }
"/"               { printf("LINHA %d: OPERATOR(%s)\n", yylineno, yytext); }
"%"               { printf("LINHA %d: OPERATOR(%s)\n", yylineno, yytext); }
"="               { printf("LINHA %d: OPERATOR(%s)\n", yylineno, yytext); }
"!="              { printf("LINHA %d: OPERATOR(%s)\n", yylineno, yytext); }
"<"               { printf("LINHA %d: OPERATOR(%s)\n", yylineno, yytext); }
">"               { printf("LINHA %d: OPERATOR(%s)\n", yylineno, yytext); }
"<="              { printf("LINHA %d: OPERATOR(%s)\n", yylineno, yytext); }
">="              { printf("LINHA %d: OPERATOR(%s)\n", yylineno, yytext); }
"&&"              { printf("LINHA %d: OPERATOR(%s)\n", yylineno, yytext); }
"||"              { printf("LINHA %d: OPERATOR(%s)\n", yylineno, yytext); }
"!"               { printf("LINHA %d: OPERATOR(%s)\n", yylineno, yytext); }

"("               { printf("LINHA %d: DELIMITER(%s)\n", yylineno, yytext); }
")"               { printf("LINHA %d: DELIMITER(%s)\n", yylineno, yytext); }
"["               { printf("LINHA %d: DELIMITER(%s)\n", yylineno, yytext); }
"]"               { printf("LINHA %d: DELIMITER(%s)\n", yylineno, yytext); }
"{"               { printf("LINHA %d: DELIMITER(%s)\n", yylineno, yytext); }
"}"               { printf("LINHA %d: DELIMITER(%s)\n", yylineno, yytext); }
";"               { printf("LINHA %d: DELIMITER(%s)\n", yylineno, yytext); }
"$"               { printf("LINHA %d: DELIMITER(%s)\n", yylineno, yytext); }

[0-9]+\.[0-9]+    { printf("LINHA %d: REAL(%s)\n", yylineno, yytext); }
[0-9]+            { printf("LINHA %d: INTEGER(%s)\n", yylineno, yytext); }
[a-zA-Z_][a-zA-Z0-9_]* { printf("LINHA %d: IDENTIFIER(%s)\n", yylineno, yytext); }

.                 { printf("LINHA %d: SIMBOLO(%s)\n", yylineno, yytext); }

%%

int main(int argc, char **argv) {
    
    if (argc < 2) {
        fprintf(stderr, "Erro: Uso correto: %s <nome_do_arquivo>\n", argv[0]);
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