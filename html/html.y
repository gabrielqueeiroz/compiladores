%{
#include <stdio.h>
extern FILE* yyin;

void yyerror(char *s);
int yylex(void);
int yyparse();
%}

%token TYPE
%token ALT WIDTH HEIGHT CLOSE STRING
%token PARAGRAPH_OPEN PARAGRAPH_CLOSE
%token LINK_OPEN LINK_CLOSE
%token HEADING1_OPEN HEADING1_CLOSE
%token HEADING2_OPEN HEADING2_CLOSE
%token HEADING3_OPEN HEADING3_CLOSE
%token HEADING4_OPEN HEADING4_CLOSE
%token HEADING5_OPEN HEADING5_CLOSE
%token HEADING6_OPEN HEADING6_CLOSE
%token IMAGE
%token BODY_OPEN BODY_CLOSE
%token HTML_OPEN HTML_CLOSE
%token UL_LIST_OPEN UL_LIST_CLOSE
%token OL_LIST_OPEN OL_LIST_CLOSE
%token BUTTON_OPEN BUTTON_CLOSE
%token LIST_OPEN LIST_CLOSE

%%
HTML_PAGE:
    TYPE HTML{YYACCEPT;}
    ;

HTML:
    HTML_OPEN BODY HTML_CLOSE
    ;

BODY:
    BODY_OPEN CONTENT BODY_CLOSE
    ;

CONTENT:
    PARAGRAPH
    | LINK
    | OL_LIST
    | HEADING
    | BUTTON
    | IMAGE_EXP
    | UL_LIST
    | CONTENT CONTENT
    ;

LINK:
    LINK_OPEN STRING CLOSE LINK_CLOSE
    ;

PARAGRAPH:
    PARAGRAPH_OPEN PARAGRAPH_CLOSE
    ;

OL_LIST:
    OL_LIST_OPEN LIST OL_LIST_CLOSE
    ;

UL_LIST:
    UL_LIST_OPEN LIST UL_LIST_CLOSE
    ;

LIST:
    LIST_OPEN LIST_CLOSE
    | LIST LIST
    ;

IMAGE_EXP:
    IMAGE STRING ALT STRING WIDTH STRING HEIGHT STRING CLOSE
    | IMAGE STRING ALT STRING CLOSE
    ;

BUTTON:
    BUTTON_OPEN BUTTON_CLOSE
    ;

HEADING:
    HEADING1_OPEN HEADING1_CLOSE
    | HEADING2_OPEN HEADING2_CLOSE
    | HEADING3_OPEN HEADING3_CLOSE
    | HEADING4_OPEN HEADING4_CLOSE
    | HEADING5_OPEN HEADING5_CLOSE
    | HEADING6_OPEN HEADING6_CLOSE
    ;

%%

void yyerror(char *s)
{
	printf("Error: %s\n", s);
}

int main(int argc, char *argv[])
{
	int result;
    yyin = fopen(argv[1], "r");
    result = yyparse();
    if (result == 0){
        printf("Correct\n");
    }
	return 0;
}