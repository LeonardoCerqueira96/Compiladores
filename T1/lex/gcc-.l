%{
	#define ARQ_SAIDA "relatorio.txt"
	#include <stdio.h>
	#include <stdlib.h>

	#ifndef FALSE
	#define FALSE 0
	#endif
	#ifndef TRUE
	#define TRUE 1
	#endif

	int num_erro = 0;
	int num_linha = 1;
%}

digito		[0-9]
numero		{digito}+
letra		[a-zA-z]
id			{letra}+
nlinha		\n
branco		[ \t]+
comentario	[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]

%%

"if"		{ fprintf(yyout, "%s %s\n", yytext, "IF"); }
"else"		{ fprintf(yyout, "%s %s\n", yytext, "ELSE"); }
"while"		{ fprintf(yyout, "%s %s\n", yytext, "WHILE"); }
"int"		{ fprintf(yyout, "%s %s\n", yytext, "INT"); }
"void"		{ fprintf(yyout, "%s %s\n", yytext, "VOID"); }
"return"	{ fprintf(yyout, "%s %s\n", yytext, "RETURN"); }
"input"		{ fprintf(yyout, "%s %s\n", yytext, "INPUT"); }
"output"	{ fprintf(yyout, "%s %s\n", yytext, "OUTPUT"); }

"+"			{ fprintf(yyout, "%s %s\n", yytext, "SOMA"); }
"-"			{ fprintf(yyout, "%s %s\n", yytext, "SUB"); }
"*"			{ fprintf(yyout, "%s %s\n", yytext, "MUL"); }
"/"			{ fprintf(yyout, "%s %s\n", yytext, "DIV"); }
"<"			{ fprintf(yyout, "%s %s\n", yytext, "MENOR"); }
"<="		{ fprintf(yyout, "%s %s\n", yytext, "MEIGUAL"); }
">"			{ fprintf(yyout, "%s %s\n", yytext, "MAIOR"); }
">="		{ fprintf(yyout, "%s %s\n", yytext, "MAIGUAL"); }
"=="		{ fprintf(yyout, "%s %s\n", yytext, "IGUAL"); }
"!="		{ fprintf(yyout, "%s %s\n", yytext, "DIF"); }
"="			{ fprintf(yyout, "%s %s\n", yytext, "ATRIB"); }
";"			{ fprintf(yyout, "%s %s\n", yytext, "PV"); }
","			{ fprintf(yyout, "%s %s\n", yytext, "V"); }
"("			{ fprintf(yyout, "%s %s\n", yytext, "AP"); }
")"			{ fprintf(yyout, "%s %s\n", yytext, "FP"); }
"["			{ fprintf(yyout, "%s %s\n", yytext, "ACO"); }
"]"			{ fprintf(yyout, "%s %s\n", yytext, "FCO"); }
"{"			{ fprintf(yyout, "%s %s\n", yytext, "ACH"); }
"}"			{ fprintf(yyout, "%s %s\n", yytext, "FCH"); }

{numero}	{ fprintf(yyout, "%s %s\n", yytext, "NUM"); }
{id}		{ fprintf(yyout, "%s %s\n", yytext, "ID"); }
{nlinha}	{ num_linha++; }

{branco}		{ /* Ignorar brancos */ }
{comentario}	{ /* Ignorar comentarios */ }

.			{ fprintf(yyout, "%s %s: Linha %d\n", yytext, "ERRO", num_linha), num_erro++; }

%%

int main(int argc, char  *argv[])
{
	yyin = fopen(argv[1], "r");
	yyout = fopen(ARQ_SAIDA, "w");
	yylex();
}

int yywrap()
{
	fprintf(yyout, "%d erro(s) encontrado(s)\n", num_erro);
	return 1;
}
