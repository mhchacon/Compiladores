%{
#include <stdio.h>  
#include <stdlib.h>
#include "calc.tab.h"
%}

%%
"printar_variaveis" { return PRINT_VARS; }
">>>"               { return ASSIGN; }
"**"                 { return POW; }
[0-9]+(\.[0-9]+)?([eE][+-]?[0-9]+)? { yylval.dval = atof(yytext); return NUM; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.sval = strdup(yytext); return VAR; }
[ \t\r]+               { /* ignora espaços */ }
\n                     { return '\n'; }
.                      { return yytext[0]; }
%%

int yywrap() { return 1; }