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
    /* (b) Verifica se nenhum argumento de arquivo foi passado */
    if (argc < 2) {
        printf("Erro: Nenhum arquivo de entrada foi fornecido.\n");
        printf("Uso correto: %s <nome_do_arquivo>\n", argv[0]);
        return 1; /* Encerra com codigo diferente de zero sem chamar yylex() */
    }

    /* (a) Abre o arquivo indicado em argv[1] com fopen */
    FILE *arquivo = fopen(argv[1], "r");

    /* (b) Verifica se o arquivo nao existe ou nao pode ser aberto */
    if (!arquivo) {
        printf("Erro: Nao foi possivel abrir o arquivo '%s'. Verifique se ele existe e tente novamente.\n", argv[1]);
        return 1; /* Encerra com codigo diferente de zero sem chamar yylex() */
    }

    /* (a) Redireciona yyin para o arquivo antes de chamar yylex() */
    yyin = arquivo;

    yylex();

    fclose(arquivo);

    return 0;
}