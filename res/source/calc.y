%{
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char *);
%}
%token  NUMBER
%%
lines :
        expr '\n'       { printf("= %g\n", $1); }
        |
        ;
expr  :
        expr '+' expr   { $$ = $1 + $3; }
        | expr '*' expr { $$ = $1 * $3; }
        | NUMBER        { $$ = $1; }
        ;
%%

void yyerror(char *s)
{
  printf(stderr, "%s\n", s);
}

int yywrap(void) {
  return 1;
}

int yylex()
{
  int c = getchar();
  if (isdigit(c)) {
    yylval = c - '0';
    return NUMBER;
  }

  return c;
}

int main(void)
{
  yylex();
  return 0;
}
