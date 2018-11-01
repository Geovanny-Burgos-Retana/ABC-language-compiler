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
                for (int i = 0; i < token.getLines().size(); i++) {
                    if (token.getLines().get(i).getNumLine() == line) {
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
Data_Type = "BOOLEAN" | "CHAR" | "INT" | "LONGINT" | "REAL" | "SHORTINT" | "STRING"
Scientific_Notation = [0-9]*\.[0-9]+([e|E][-+]{0,1}[0-9]+)
Real_Number = [0-9]+"."[0-9]+
IdentifierWrong = [A-Za-z][A-Za-z0-9]{127,500}  //500 es un valor fijo, se puede variar segun necesidad, sin embargo ente mas grande sea, mas estados requiere, haciendolo mas lento.
IdentifierWrong2 = [0-9][A-Za-z0-9]{0,126}
Identifier = [A-Za-z][A-Za-z0-9]{0,126}
StringLine = "\"".*"\""
StringBlock = "\""([^"\""]|{WHITE})*"\""
Numeral_Character = "#"([0-9] | [0-9][0-9] | [0-9][0-9][0-9])
DecIntegerLiteral = 0 | [1-9][0-9]*
Error = [^]

%%


/* Seccion de reglas lexicas */
<YYINITIAL> {
    // ---------------------------------- 1 ----------------------------------
    {CommentLine} { /*Ignore*/ }

    // ---------------------------------- 2 ----------------------------------
    {CommentBlock2} { /*Ignore*/ }

    // ---------------------------------- 3 ----------------------------------
    {DecIntegerLiteral} {
        addToken(new Yytoken(count, yytext(), Types_Tokens.LITERAL_NUMERAL), yyline);
        return symbol(sym.ENTERO, new Integer(yytext()));
    }

    // ---------------------------------- 4 ----------------------------------
    {CommentBlock} { /*Ignore*/ }

    // ---------------------------------- 5 ----------------------------------
    {Tabulator} { /*Ignore*/ }

    // ---------------------------------- 6 ----------------------------------
    {Space} { /*Ignore*/ }

    // ---------------------------------- 7 ----------------------------------
    {LineTerminator} { /*Ignore*/ }

    // ---------------------------------- 8 ----------------------------------
    {CommentBlock2Wrong} {
        addToken(new Yytoken(count, yytext(), Types_Tokens.ERROR), yyline);
    }

    // PALABRAS RESERVADAS -------------- 9 ----------------------------------
    "BEGIN" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_BEGIN, yytext());
    }
    "CONST" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_CONST, yytext());
    }
    "DO" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_DO, yytext());
    }
    "ELSE" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_ELSE, yytext());
    }
    "END" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_END, yytext());
    }
    "FALSE" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_FALSE, yytext());
    }
    "FOR" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_FOR, yytext());
    }
    "FUNCTION" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_FUNCTION, yytext());
    }
    "IF" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_IF, yytext());
    }
    "OF" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_OF, yytext());
    }
    "PROCEDURE" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_PROCEDURE, yytext());
    }
    "PROGRAM" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_PROGRAM, yytext());
    }
    "READ" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_READ, yytext());
    }
    "THEN" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_THEN, yytext());
    }
    "TO" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_TO, yytext());
    }
    "TRUE" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_TRUE, yytext());
    }
    "UNTIL" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_UNTIL, yytext());
    }
    "VAR" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_VAR, yytext());
    }
    "WHILE" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_WHITE, yytext());
    }
    "WRITE" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.RW_WRITE, yytext());
    }
    // ---------------------------------- 10 ----------------------------------
    {Data_Type} {
        addToken(new Yytoken(count, yytext(), Types_Tokens.PALABRA_RESERVADA), yyline);
        return symbol(sym.DATA_TYPE,  yytext());
    }

    // ---------------------------------- 11 ----------------------------------
    {Identifier} {
        addToken(new Yytoken(count, yytext(), Types_Tokens.IDENTIFICADOR), yyline);
        return symbol(sym.IDENTIFIER, yytext()); 
    }

    // ---------------------------------- 12 ----------------------------------
    {IdentifierWrong} {
        addToken(new Yytoken(count, yytext(), Types_Tokens.ERROR), yyline);
    }

    // ---------------------------------- 13 ----------------------------------
    {IdentifierWrong2} {
        addToken(new Yytoken(count, yytext(), Types_Tokens.ERROR), yyline);
    }
    
    // ---------------------------------- 14 ----------------------------------
    {Real_Number} {
        addToken(new Yytoken(count, yytext(), Types_Tokens.LITERAL_NUMERAL), yyline);
        return symbol(sym.REAL, new Double(yytext()));
    }

    // ---------------------------------- 15 ----------------------------------
    {Scientific_Notation} {
        addToken(new Yytoken(count, yytext(), Types_Tokens.LITERAL_NUMERAL), yyline);
        return symbol(sym.SCIENTIFIC_NOTATION, new Double(yytext()));
    }

    // ---------------------------------- 16 ----------------------------------
    {StringLine} {
        addToken(new Yytoken(count, yytext(), Types_Tokens.LITERAL_STRING), yyline);
        return symbol(sym.STRING_LINE, new String(yytext()));
    }

    // ---------------------------------- 17 ----------------------------------
    {StringBlock} {
        addToken(new Yytoken(count, yytext(), Types_Tokens.LITERAL_STRING), yyline);
        return symbol(sym.STRING_BLOCK, new String(yytext()));  
    }

    // ---------------------------------- 18 ----------------------------------
    {Numeral_Character} {
        addToken(new Yytoken(count, yytext(), Types_Tokens.LITERAL_STRING), yyline);
        return symbol(sym.NUMERAL_CHARACTER, new String(yytext()));
    }

    // OPERADORES ARITMETICOS ----------- 19 ----------------------------------
    "," {
        return symbol(sym.OP_COMMA);
    }
    ";" { 
        return symbol(sym.OP_SEMI); 
    }
    ":" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_TWOPOINTS);
    }
    "++" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_PLUSPLUS);
    }
    "--" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_LESSLESS);
    }
    ":=" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_TWOPOINTSEGUAL);
    }
    "+" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_PLUS);
    }
    "-" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_LESS);
    }
    "*" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_MULTIPLY);
    }
    "/" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_DIVIDE);
    }
    "MOD" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_MOD, yytext());
    }
    "(" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_LEFTPARENTHESIS);
    }
    ")" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_RIGHTPARENTHESIS);
    }
    "+=" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_PLUSEQUAL);
    }
    "-=" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_LESSEQUAL);
    }
    "*=" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_MULTEQUAL);
    }
    "/=" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_DIVEQUAL);
    }
    "DIV" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OP_DIV, yytext());
    }
       
    // OPERADORES BOOLEANOS ------------ 12 ----------------------------------
    "=" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OPB_EQUAL);
    }
    ">=" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OPB_GREATEREQUAL);
    }
    ">" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OPB_GREATER);
    }
    "<=" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OPB_LESSEQUAL);
    }
    "<" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OPB_LESS);
    }
    "<>" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OPB_DIFERENT);
    }
    "OR" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OPB_OR, yytext());
    }
    "AND" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OPB_AND, yytext());
    }
    "NOT" {
        addToken(new Yytoken(count, yytext(), Types_Tokens.OPERADOR), yyline);
        return symbol(sym.OPB_NOT, yytext());
    }

    // --------------------------------- 13 ----------------------------------
    {Error} {
        addToken(new Yytoken(count, yytext(), Types_Tokens.ERROR), yyline);
    }
}