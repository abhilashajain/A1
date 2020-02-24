%{
#include <stdio.h>
#include "calc.tab.h"
int l=0;
%}

digit	([0-9])
var	[a-z][a-zA-Z0-9]*
var2 [0-9a-z]*
%%

"print"		{       return(TOK_PRINTLN);	}
"main()"	{	return(TOK_MAIN);	}
"="		{	return(TOK_EQ);		}
"+"		{	return(TOK_ADD);	}
"(-"		{	return(TOK_NEG);	}
"*"		{	return(TOK_MUL);	}
"{"		{	return(TOK_LCURL);	}
"}"		{	return(TOK_RCURL);	}
";"		{	return(TOK_SEMICOLON);	}
"("		{	return(TOK_LBKT);	}
")"		{	return(TOK_RBKT);	}
	

" "  ;
{digit}+	{
		sscanf(yytext, "%d", &(yylval.int_val));
		//printf("\ndigit = %s \n",yytext);
		return TOK_INT_NUM;
	
		}

{var}	{	sscanf(yytext, "%s", yylval.char_val);
		//printf("\nvar = %s \n",yytext);
		return(TOK_ID);		}

[\n]	l++;
[\t] 


{var2}   {	printf("\nLexical error: %s \n",yytext); 
				return(yytext[0]);	}	
"-"  	{	printf("\nLexical error: %s \n",yytext); 
				return(yytext[0]);	}	
 
. {printf("Invalid character '%c', ignored\n", 
			yytext[0]);
	}

%%

