package br.maua.cic303;

import org.junit.Test;
import static org.junit.Assert.*;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

public class ValidadorModeloTest {

    private List<Token> analisar(String codigo) throws Exception {
        Lexer lexer = new Lexer(new StringReader(codigo));
        List<Token> tokens = new ArrayList<>();
        Token t;
        while ((t = lexer.yylex()) != null && t.tag != Tag.EOF) {
            tokens.add(t);
        }
        return tokens;
    }

    @Test
    public void test01_ExpressaoEBNF() throws Exception {
        // A expressão exata que precisamos validar
        String expressao = "tempC = 5*(tempF - 32)/9";
        List<Token> tokens = analisar(expressao);
        
        // A sequência exata de Tags que o Lexer deve gerar para essa expressão
        Tag[] esperados = {
            Tag.ID,       // tempC
            Tag.ASSIGN,   // =
            Tag.NUMBER,   // 5
            Tag.MUL_OP,   // *
            Tag.LPAREN,   // (
            Tag.ID,       // tempF
            Tag.ADD_OP,   // -
            Tag.NUMBER,   // 32
            Tag.RPAREN,   // )
            Tag.MUL_OP,   // /
            Tag.NUMBER    // 9
        };

        assertEquals("O número de tokens extraídos está incorreto.", esperados.length, tokens.size());
        
        for (int i = 0; i < esperados.length; i++) {
            assertEquals("Erro de classificação no token da posição " + i, esperados[i], tokens.get(i).tag);
        }
        
        // Validando os lexemas principais para garantir que as Macros leram corretamente
        assertEquals("tempC", tokens.get(0).lexeme);
        assertEquals("5", tokens.get(2).lexeme);
        assertEquals("tempF", tokens.get(5).lexeme);
        assertEquals("32", tokens.get(7).lexeme);
    }
}