/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package analizador.lexico;

import java.util.ArrayList;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

/**
 *
 * @author geovanny
 */
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
        return name + " " + type + " " + lines;
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

%{
    private int count; // Este lleva la cuenta de los TOKENS y es también el identificador
    private ArrayList<Yytoken> tokens = new ArrayList<>();

    /**
     * Escribe los resultados en un archivo de salida
     * @throws IOException 
     */
    private void writeOutputFile() throws IOException {
        String filename = "output.out";
        BufferedWriter out = new BufferedWriter(new FileWriter(filename));
        for (Yytoken token : tokens) {
            out.write(token.toString());
            out.newLine();
        }
        out.close();
    }
    
    /**
     * Valida la inserción de un nuevo token, si exite agrega la line o aumenta las ocurrencias del TOKEN en la misma linea
     * @param newToken
     * @param line
     * @return 
     */
    private boolean addToken(Yytoken newToken, int line) {
        for (Yytoken token : tokens) {
            if (token.getName().equals(newToken.getName()) && token.getType().equals(newToken.getType())) {
                System.out.println("Entro2");
                for (int i = 0; i < token.getLines().size(); i++) {
                    System.out.println("Entro1");
                    if (token.getLines().get(i).equals(line)) {
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
%}

// Inicializador de variables
%init{
    count = 0;
    tokens = new ArrayList<Yytoken>();
%init}
%eof{
    try{
        this.writeOutputFile();
    }catch(IOException ioe){
        ioe.printStackTrace();
    }
%eof}

// Activador del conteo de lineas
%line

/* Declaraciones de las expresiones regulares */
Comment = "(*" [^*] ~"*)" | "{" [^*] ~"}"
CommentLine = "//".*
LineTerminator = \r|\n|\r\n
Space = " "
Tabulator = \t
Reserved_Word = "AND" | "ARRAY" | "BEGIN" | "BOOLEAN" | "BYTE" | "CASE" | "CHAR" | "CONST" | "DIV" | "DO" | "DOWNTO" | "ELSE" | "END" | "FALSE" | "FILE" | "FOR" | "FORWARD" | "FUNCTION" | "GOTO" | "IF" | "IN" | "INLINE" | "INT" | "LABEL" | "LONGINT" | "MOD" | "NIL" | "NOT" | "OF" | "OR" | "PACKED" | "PROCEDURE" | "PROGRAM" | "READ" | "REAL" | "RECORD" | "REPEAT" | "SET" | "SHORTINT" | "STRING" | "THEN" | "TO" | "TRUE" | "TYPE" | "UNTIL" | "VAR" | "WHILE" | "WITH" | "WRITE" | "XOR"
Identifer = [A-Za-z][A-Za-z0-9]*
Real_Number = [0-9]+"."[0-9]+
Scientific_Notation = {Integer}+("e"|"E")("-"|""){Integer}+
String = "\""[^\n\r]+"\""
Numeral_Character = "#"([0-9] | [0-9][0-9] | [0-9][0-9][0-9])
Operator = "," | ";" | "++" | "--" | ">=" | ">" | "<=" | "<" | "<>" | "=" | "+" | "-" | "*" | "/" | "(" | ")" | "[" | "]" | ":=" | "." | ":" | "+=" | "-=" | "*=" | "/=" | ">>" | "<<" | "<<=" | ">>="

Digit = [0-9]
Integer = [1-9]{Digit}+
%%


/* Seccion de reglas lexicas */
%%
// ---------------------------------- 1 ----------------------------------
{Comment}    {
    /*Ignore*/
}
// ---------------------------------- 2 ----------------------------------
{CommentLine} {
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
{Reserved_Word} {
   Yytoken token = new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA);
    addToken(token, yyline);
    return token;
}
// ---------------------------------- 7 ----------------------------------
{Identifer} {
    Yytoken token = new Yytoken(count, yytext(), Types_Tokens.IDENTIFICADOR);
    addToken(token, yyline);
    return token;
}
// ---------------------------------- 8 ----------------------------------
{Real_Number} {
    Yytoken token = new Yytoken(count, yytext(), Types_Tokens.LITERAL);
    addToken(token, yyline);
    return token;
}
// ---------------------------------- 9 ----------------------------------
{Scientific_Notation} {
    Yytoken token = new Yytoken(count, yytext(), Types_Tokens.LITERAL);
    addToken(token, yyline);
    return token;
}
// --------------------------------- 10 ----------------------------------
{String} {
    Yytoken token = new Yytoken(count, yytext(), Types_Tokens.LITERAL);
    addToken(token, yyline);
    return token;
}
// --------------------------------- 11 ----------------------------------
{Numeral_Character} {
    Yytoken token = new Yytoken(count, yytext(), Types_Tokens.LITERAL);
    addToken(token, yyline);
    return token;
}
// --------------------------------- 12 ----------------------------------
{Operator} {
    Yytoken token = new Yytoken(count, yytext(), Types_Tokens.LITERAL);
    addToken(token, yyline);
    return token;
}
. {
    
}