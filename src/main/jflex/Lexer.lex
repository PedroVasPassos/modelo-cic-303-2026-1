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

WhiteSpace = 

/* id: Começa com letra, seguido de letras ou números */
Identifier = 

/* number: Números inteiros ou decimais */
Number = 

%%
/* ========================================================================= */
/* REGRAS LÉXICAS                                                            */
/* ========================================================================= */

<YYINITIAL> {
    
    /* Ignorar espaços em branco */
    {WhiteSpace}    { /* Não faz nada */ }

    /* Pontuação e Atribuição */
    "="             
    "("             
    ")"             

    /* Operadores Matemáticos */
    "+" | "-"       
    "*" | "/"       

    /* Identificadores e Números */
    {Identifier}    
    {Number}        

    /* Fallback: Qualquer outro caractere não reconhecido gera um Erro */
    .               
}

<<EOF>>             { return token(Tag.EOF, ""); }