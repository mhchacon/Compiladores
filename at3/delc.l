%{
#include "delc.tab.h"
#include <string.h>
%}

%%
"int"|"double"|"char"  { yylval.sval = strdup(yytext); return TYPE; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return ID; }
[ \t\n\r]+             { /* ignora espaços e quebras de linha */ }
.                      { return yytext[0]; }
%%

int yywrap() { return 1; }