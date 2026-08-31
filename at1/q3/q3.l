%option noyywrap

%%

"//".*                  { /* Ignora os comentarios de linha que vao ate o fim da linha */ }

"if"                    { printf("IF\n"); }
"else"                  { printf("ELSE\n"); }
"while"                 { printf("WHILE\n"); }
"return"                { printf("RETURN\n"); }

[a-zA-Z_][a-zA-Z0-9_]*  { printf("ID %s\n", yytext); }

[0-9]+\.[0-9]+          { printf("NUMBER %s\n", yytext); }
[0-9]+                  { printf("NUMBER %s\n", yytext); }

[ \t\n]+                { /* Ignora espacos, tabulacoes e quebras de linha */ }

.                       { printf("SIMBOLO %s\n", yytext); }

%%

int main(int argc, char **argv) {
    yylex();
    return 0;
}