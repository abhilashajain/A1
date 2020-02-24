%{
#include <stdio.h>
#include <string.h>
extern int l;

void setVar(char* ,int );
int getVar(char* );
int yyerror(char *);
int yylex();


struct symtabl{
	char id[20];
	int value;
}variables[100];

int vars= 0;
// pdeshpa2 :: setting or updating variables
void setVar(char* var_name,int newValue){
	
	
	int i=0;
	int flag = 0;	
	for(i = 0; i < vars; i++){
	  if(!strcmp(variables[i].id,var_name)){
		variables[i].value = newValue;
		flag = 1;
		break;				
		}
	}

	if(flag == 0){
	   vars++;
       	   strcpy(variables[i].id, var_name);
           variables[i].value = newValue;
	   
	}
	
}
//pdeshpa2 :: getting back variable values
int getVar(char* var_name){
	int i=0;
	for(i = 0; i < vars; i++){
		if(!strcmp(variables[i].id,var_name)){
			//printf("Variable found == %d",variables[i].value);
			return variables[i].value;
		}
	}
	
	return 0;
}	

%}

%token TOK_NEG TOK_MUL TOK_INT_NUM TOK_FLOAT_TYPE TOK_PRINTLN TOK_MAIN TOK_ID TOK_EQ TOK_LCURL TOK_RCURL TOK_SEMICOLON TOK_LBKT TOK_RBKT

%union{
        int int_val;
	char char_val[20];
}

%type<int_val> expr TOK_INT_NUM
%type<char_val> TOK_ID

%left TOK_EQ
%left TOK_ADD
%left TOK_MUL
%left '{' '}'

%%

Prog:
        TOK_MAIN TOK_LCURL Stmts TOK_RCURL
;

Stmts:
        | Stmt TOK_SEMICOLON Stmts
;

Stmt:
        | TOK_ID TOK_EQ expr
        {
                setVar($1,$3);
        }
        | TOK_PRINTLN TOK_ID
        {
			//printf(" $2 = %s\n", $2);
                fprintf(stdout, "%d\n", getVar($2));
        }| TOK_PRINTLN expr
        {
			//printf(" $2 = %s\n", $2);
                fprintf(stdout, "%d\n", $2);
        }| TOK_ID TOK_ADD TOK_EQ expr
        {
               		// fprintf(stdout, "the value is %d\n", $2);
			setVar( $1 ,getVar($1) + $4);
			
        }| TOK_ID TOK_MUL TOK_EQ expr
        {		
               		// fprintf(stdout, "$2 is %d\n", $2);
			setVar( $1 ,getVar($1) * $4);
			
        }
		
;


expr:
        	TOK_INT_NUM		
		{	
			//printf("%d\n", $1);
				$$ = $1;		
		}
		| TOK_ID		
		{	
				$$ = getVar($1);	
		}
		| TOK_NEG TOK_INT_NUM TOK_RBKT
		{	
				$$ = -($2);		
		}
	        | expr TOK_MUL expr	
		{	
				$$ = $1 * $3;	
		}
        	| expr TOK_ADD expr	
		{	
				$$ = $1 + $3;	
		}
		| TOK_LBKT expr TOK_RBKT
		{
				$$ = $2;
		}
;

%%

int yyerror(char *s)
{
	printf("Parsing Error - line %d\n", l); 
	return 0;
}

int main()
{
   yyparse();
   return 0;
}


