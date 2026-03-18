package br.maua.cic303;

public class Token {
    public final Tag tag;
    public final String lexeme;

    public Token(Tag tag, String lexeme) {
        this.tag = tag;
        this.lexeme = lexeme;
    }

    @Override
    public String toString() {
        return "<" + tag + ", '" + lexeme + "'>";
    }
}