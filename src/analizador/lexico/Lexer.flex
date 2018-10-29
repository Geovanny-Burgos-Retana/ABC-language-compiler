package analizador.lexico;

import java.util.ArrayList;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java_cup.runtime.*;
import java.io.Reader;

class Yytoken {
    
    private int id; //Identificador único para cada TOKEN
    private String name; //Nombre del TOKEN
    private Types_Tokens type;  //Tipo del TOKEN (Identificador, Operador, Palabra Reservada, Literal)
    private ArrayList<Line> lines = new ArrayList<>();  //Arreglos de lineas y ocurrencias
    
    public Yytoken(int id, String name, Types_Tokens type) {
        this.id = id;
        this.name = name;
        this.type = type;
    }

    @Override
    public String toString() {
        String token = name + "\t" + "\t" + type + "\t" + "\t" + lines;
        return token;
    }

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }
    
    /**
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * @param name the name to set
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * @return the type
     */
    public Types_Tokens getType() {
        return type;
    }

    /**
     * @param type the type to set
     */
    public void setType(Types_Tokens type) {
        this.type = type;
    }

    /**
     * @return the lines
     */
    public ArrayList<Line> getLines() {
        return lines;
    }

    /**
     * @param lines the lines to set
     */
    public void setLines(ArrayList<Line> lines) {
        this.lines = lines;        
    }
    
}

/********** Seccion de opciones y declaraciones de JFlex **********/
%%
%function nextToken
%public
%class LexerAnalyzer
%unicode
%cup

%{
    private int count; // Este lleva la cuenta de los TOKENS y es también el identificador
    private ArrayList<Yytoken> tokens = new ArrayList<>();    
    
    /**
     * Valida la inserción de un nuevo token, si exite agrega la line o aumenta las ocurrencias del TOKEN en la misma linea
     * @param newToken
     * @param line
     * @return 
     */
    private boolean addToken(Yytoken newToken, int line) {
        for (Yytoken token : tokens) {
            if (token.getName().toUpperCase().equals(newToken.getName().toUpperCase()) && token.getType().equals(newToken.getType())) {
                System.out.println("Entro2");
                for (int i = 0; i < token.getLines().size(); i++) {
                    System.out.println("Entro1");
                    if (token.getLines().get(i).getNumLine() == line) {
                        System.out.println("Entro");
                        token.getLines().get(i).setOccurrences(token.getLines().get(i).getOccurrences() + 1);
                        return true;
                    }
                }
                token.getLines().add(new Line(line));
                return true;
            }
        }
        count++;
        newToken.setId(count);
        newToken.getLines().add(new Line(line));
        tokens.add(newToken);
        return true;
    }

    /**
     * @return the lines
     */
    public ArrayList<Yytoken> getTokens() {
        return tokens;
    }
    
    @Override
    public String toString() {
        String value = "";
        for (Yytoken token : tokens) {
            value += token.toString() + "\n";
        }
        return value;
    }

    public String toStringTokens() {
        String value = "";
        for (Yytoken token : tokens) {
            if(!token.getType().equals(Types_Tokens.ERROR)){
                value += token.toString() + "\n";
            }            
        }
        return value;
    }
    
    public String toStringErrores() {
        String value = "";
        for (Yytoken token : tokens) {
            if(token.getType().equals(Types_Tokens.ERROR)){
                value += token.toString() + "\n";
            }            
        }
        return value;
    }

    /*  Generamos un java_cup.Symbol para guardar el tipo de token 
        encontrado */
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    
    /* Generamos un Symbol para el tipo de token encontrado 
       junto con su valor */
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

// Inicializador de variables
%init{
    count = 0;
    tokens = new ArrayList<Yytoken>();
%init}

// Activador del conteo de lineas
%line
%column

/* Declaraciones de las expresiones regulares */
WHITE =[ \t\r\n]
CommentBlock2 = "(""*"([^"*)"]|{WHITE})*"*"")" | "{"([^"}"]|{WHITE})*"}"
CommentLine = "//".*
CommentBlock = "//".* | "(*".*"*)" | "{".*"}"
CommentBlock2Wrong = "(""*"([^"*)"]|{WHITE})* | "{"([^"}"]|{WHITE})*
LineTerminator = \r|\n|\r\n
Space = " "
Tabulator = \t
Reserved_Word = "ARRAY" | "BEGIN" | "BOOLEAN" | "BYTE" | "CHAR" | "CONST" | "DO" | "ELSE" | "END" | "FALSE" | "FUNCTION" | "IF" | "INT" | "LONGINT" | "OF" | "PROCEDURE" | "PROGRAM" | "READ" | "REAL" | "SHORTINT" | "STRING" | "THEN" | "TO" | "TRUE" | "UNTIL" | "VAR" | "WHILE" | "WRITE"
Scientific_Notation = [0-9]*\.[0-9]+([e|E][-+]{0,1}[0-9]+)
Real_Number = [0-9]+"."[0-9]+
IdentifierWrong = [A-Za-z][A-Za-z0-9]{127,500}  //500 es un valor fijo, se puede variar segun necesidad, sin embargo ente mas grande sea, mas estados requiere, haciendolo mas lento.
IdentifierWrong2 = [0-9][A-Za-z0-9]{0,126}
Identifier = [A-Za-z][A-Za-z0-9]{0,126}
StringLine = "\"".*"\""
StringBlock = "\""([^"\""]|{WHITE})*"\""
Numeral_Character = "#"([0-9] | [0-9][0-9] | [0-9][0-9][0-9])
Operator = "," | ";" | "++" | "--" | ">=" | ">" | "<=" | "<" | "<>" | "=" | "+" | "-" | "*" | "/" | "(" | ")" | "[" | "]" | ":=" | "." | ":" | "+=" | "-=" | "*=" | "/=" | ">>" | "<<" | "<<=" | ">>="
DecIntegerLiteral = 0 | [1-9][0-9]*
Error = [^]

%%


/* Seccion de reglas lexicas */
<YYINITIAL> {
    // ---------------------------------- 1 ----------------------------------
    {CommentLine} {
        /*Ignore*/
    }

    {CommentBlock2} {
        /*Ignore*/
    }

    {DecIntegerLiteral} {
        Yytoken token = new Yytoken(count, yytext(), Types_Tokens.LITERAL_NUMERAL);
        addToken(token, yyline);
        return symbol(sym.ENTERO, new Integer(yytext()));
    }
    // ---------------------------------- 2 ----------------------------------
    {CommentBlock} {
        /*Ignore*/
    }
    // ---------------------------------- 3 ----------------------------------
    {Tabulator} {
        /*Ignore*/
    }
    // ---------------------------------- 4 ----------------------------------
    {Space} {
        /*Ignore*/
    }
    // ---------------------------------- 5 ----------------------------------
    {LineTerminator} {
        /*Ignore*/
    }
    // ---------------------------------- 6 ----------------------------------
    {CommentBlock2Wrong} {
        Yytoken token = new Yytoken(count, yytext(), Types_Tokens.ERROR);
        addToken(token, yyline);
        return token;
    }

    {Reserved_Word} {
        Yytoken token = new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA);
        addToken(token, yyline);
        return symbol(sym.RESERVED_WORD,  yytext());
    }
    // ---------------------------------- 7 ----------------------------------
    {Identifier} {
        Yytoken token = new Yytoken(count, yytext(), Types_Tokens.IDENTIFICADOR);
        addToken(token, yyline);
        return symbol(sym.IDENTIFIER, yytext()); 
    }

    {IdentifierWrong} {
        Yytoken token = new Yytoken(count, yytext(), Types_Tokens.ERROR);
        addToken(token, yyline);
        return token;
    }

    {IdentifierWrong2} {
        Yytoken token = new Yytoken(count, yytext(), Types_Tokens.ERROR);
        addToken(token, yyline);
        return token;
    }
    // ---------------------------------- 8 ----------------------------------
    {Real_Number} {
        Yytoken token = new Yytoken(count, yytext(), Types_Tokens.LITERAL_NUMERAL);
        addToken(token, yyline);
        return symbol(sym.REAL, new Double(yytext()));
    }
    // ---------------------------------- 9 ----------------------------------
    {Scientific_Notation} {
        Yytoken token = new Yytoken(count, yytext(), Types_Tokens.LITERAL_NUMERAL);
        addToken(token, yyline);
        return 
    }
    // --------------------------------- 10 ----------------------------------
    {StringLine} {
        Yytoken token = new Yytoken(count, yytext(), Types_Tokens.LITERAL_STRING);
        addToken(token, yyline);
        return symbol(sym.STRING_LINE, new String(yytext()));
    }

    {StringBlock} {
        Yytoken token = new Yytoken(count, yytext(), Types_Tokens.LITERAL_STRING);
        addToken(token, yyline);
        return symbol(sym.STRING_BLOCK, new String(yytext()));  
    }
    // --------------------------------- 11 ----------------------------------
    {Numeral_Character} {
        Yytoken token = new Yytoken(count, yytext(), Types_Tokens.LITERAL_STRING);
        addToken(token, yyline);
        return symbol(sym.NUMERAL_CHARACTER, new String(yytext()));
    }
    // --------------------------------- 12 ----------------------------------
    {Operator} {
        Yytoken token = new Yytoken(count, yytext(), Types_Tokens.OPERADOR);
        addToken(token, yyline);
        return token;
    }
    // --------------------------------- 13 ----------------------------------
    {Error} {
        Yytoken token = new Yytoken(count, yytext(), Types_Tokens.ERROR);
        addToken(token, yyline);
        return token;
    }
}