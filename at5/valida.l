%{
#include "valida.tab.h"
%}
%option noyywrap

%%

[ \t\n\r]+                  { /* ignora espaços, tabulações e quebras de linha */ }

"{"                         { return LBRACE; }
"}"                         { return RBRACE; }
"["                         { return LBRACKET; }
"]"                         { return RBRACKET; }
","                         { return COMMA; }
":"                         { return COLON; }

"true"                      { return TRUE_TOK; }
"false"                     { return FALSE_TOK; }
"null"                      { return NULL_TOK; }

\"[^\"\n]*\"                { return STRING; }

-?(0|[1-9][0-9]*)(\.[0-9]+)? { return NUMBER; }

.                           { return yytext[0]; }

%%