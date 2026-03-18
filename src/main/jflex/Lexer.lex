package br.maua.cic303;

%%

%class Lexer
%public
%unicode
%type Token
%line
%column

%{
    // Função auxiliar para gerar Tokens
    private Token token(Tag tag, String lexeme) {
        return new Token(tag, lexeme);
    }
%}

/* ========================================================================= */
/* MACROS (Expressões Regulares)                                             */
/* ========================================================================= */

WhiteSpace = [ \t\r\n\f]+

/* id: Começa com letra, seguido de letras ou números */
Identifier = [a-zA-Z][a-zA-Z0-9]*

/* number: Números inteiros ou decimais */
Number = [0-9]+(\.[0-9]+)?

%%
/* ========================================================================= */
/* REGRAS LÉXICAS                                                            */
/* ========================================================================= */

<YYINITIAL> {
    
    /* Ignorar espaços em branco */
    {WhiteSpace}    { /* Não faz nada */ }

    /* Pontuação e Atribuição */
    "="             { return token(Tag.ASSIGN, yytext()); }      
    "("             { return token(Tag.LPAREN, yytext()); }      
    ")"             { return token(Tag.RPAREN, yytext()); }      

    /* Operadores Matemáticos */
    "+" | "-"       { return token(Tag.ADD_OP, yytext()); }     
    "*" | "/"       { return token(Tag.MUL_OP, yytext()); }

    /* Identificadores e Números */
    {Identifier}    { return token(Tag.ID, yytext()); } 
    {Number}        { return token(Tag.NUMBER, yytext()); }

    /* Fallback: Qualquer outro caractere não reconhecido gera um Erro */
    .               { return token(Tag.ERROR, yytext()); }
}

<<EOF>>             { return token(Tag.EOF, ""); }