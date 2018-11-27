/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package analizador.lexico;

/**
 *
 * @author geovanny
 */
public class AnalizadorLexico {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        Assembler asm = new Assembler();
        asm.generateIf();
        asm.exitLabelIf();
        asm.generateIf();
        asm.exitLabelIf();
        asm.generateIf();
        asm.exitLabelIf();
        asm.generateWhile();
        asm.exitLabelWhile();
        asm.generateWhile();
        asm.exitLabelWhile();
        asm.generateGlobalVariables("Variable1", "STRING");
        asm.generateGlobalVariables("Variable2", "INT");
        asm.AritmeticUnary("a", ":=", "b");
        asm.AritmeticUnary("a", "++", "b");
        asm.AritmeticUnary("a", "--", "b");
        asm.AritmeticUnary("a", "+=", "b");
        asm.AritmeticUnary("a", "-=", "b");
        asm.AritmeticUnary("a", "*=", "b");
        asm.AritmeticUnary("a", "/=", "b");
        asm.AritmeticBinary("b", "c", "+", "a");
        asm.AritmeticBinary("b", "c", "-", "a");
        asm.AritmeticBinary("b", "c", "*", "a");
        asm.AritmeticBinary("b", "c", "/", "a");
        asm.AritmeticBinary("b", "c", "MOD", "a");
        asm.createAssemblerFile();
        
        MainInterfaz interfaz = new MainInterfaz();
        interfaz.setVisible(true);
    }
    
}
