/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package analizador.lexico;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

/**
 *
 * @author FranM
 */
public class Assembler {
    public static String ASSAMBLER_CODE = "";
    public static int COUNTER_IF = 0;
    public static int COUNTER_WHILE = 0;
    
    public void generateIf(){
        COUNTER_IF = COUNTER_IF + 1;
        String temp = "start_if" + COUNTER_IF + ":" + "\n" + "CMP ..." + "\n" + "jmp exit_if" + COUNTER_IF + "\n";  // No escribe label de cierre hasta que termine de escribir el cuerpo del while
        ASSAMBLER_CODE = ASSAMBLER_CODE + temp;
    }
    
    public void exitLabelIf(){
        String temp = "exit_if" + COUNTER_IF + ":" + "\n" + "\n";
        ASSAMBLER_CODE = ASSAMBLER_CODE + temp;
    }
    
    public void generateWhile(){
        COUNTER_WHILE = COUNTER_WHILE + 1;
        String temp = "start_while" + COUNTER_WHILE + ":" + "\n" + "CMP ..." + "\n" + "jmp exit_while" + COUNTER_WHILE + "\n";  // No escribe label de cierre hasta que termine de escribir el cuerpo del while
        ASSAMBLER_CODE = ASSAMBLER_CODE + temp;
    }
    
    public void exitLabelWhile(){
        String temp = "exit_while" + COUNTER_WHILE + ":" + "\n" + "\n";
        ASSAMBLER_CODE = ASSAMBLER_CODE + temp;
    }
    
    public void generateGlobalVariables(String variable, String tipo){
        String temp;
        if(tipo.equals("STRING"))                                               //Si es String usa define word
            temp = variable + " dw " + "\n";
        else                                                                    //Si es otro usa define byte
            temp = variable + " db " + "\n";
        ASSAMBLER_CODE = temp + ASSAMBLER_CODE;                                 //Lo pone antes para que data segment quede de primero
    }
    
    public void AritmeticUnary(String operando, String operador, String resultado){
        String temp = null;
        switch (operador) {
            case ":=":
                temp = "mov " + resultado + "," + operando + "\n";
                break;
            case "++":
                temp = "mov ax," + operando + "\n" + "inc ax" + "\n" + "mov " + resultado + ",ax" + "\n" ;
                break;
            case "--":
                temp = "mov ax," + operando + "\n" + "dec ax" + "\n" + "mov " + resultado + ",ax" + "\n" ;
                break;
            case "+=":
                temp = "mov ax," + resultado + "\n" + "add ax," + operando + "\n" + "mov " + resultado + ",ax" + "\n" ;
                break;
            case "-=":
                temp = "mov ax," + resultado + "\n" + "sub ax," + operando + "\n" + "mov " + resultado + ",ax" + "\n" ;
                break;
            case "*=":
                temp = "mov al," + resultado + "\n" + "mov bl," + operando + "\n" + "mul bl" + "\n" + "mov " + resultado + ",al" + "\n";
                break;
            case "/=":
                temp = "mov al," + resultado + "\n" + "mov bl," + operando + "\n" + "div bl" + "\n" + "mov " + resultado + ",al" + "\n";
                break;
        }
        ASSAMBLER_CODE = ASSAMBLER_CODE + temp;
    }
    
    public void AritmeticBinary(String operando1, String operando2, String operador, String resultado){
        String temp = null;
        switch (operador) {
            case "+":
                temp = "mov ax," + operando1 + "\n" + "add ax," + operando2 + "\n" + "mov " + resultado + ",ax" + "\n" ;
                break;
            case "-":
                temp = "mov ax," + operando1 + "\n" + "sub ax," + operando2 + "\n" + "mov " + resultado + ",ax" + "\n" ;
                break;
            case "*":
                temp = "mov al," + operando1 + "\n" + "mov bl," + operando2 + "\n" + "mul bl" + "\n" + "mov " + resultado + ",al" + "\n";
                break;
            case "/":
                temp = "mov al," + operando1 + "\n" + "mov bl," + operando2 + "\n" + "div bl" + "\n" + "mov " + resultado + ",al" + "\n";
                break;
            case "MOD":
                temp = "mov al," + operando1 + "\n" + "mov bl, " + operando2 + "\n" + "div bl" + "\n" + "mov " + resultado + ",al" + "\n" ;
                break;
        }
        ASSAMBLER_CODE = ASSAMBLER_CODE + temp;
    }
    
    public void createAssemblerFile(){
        try {
            String arch = "Assembler.asm";
            BufferedWriter out = new BufferedWriter(new FileWriter(arch));
            out.write(ASSAMBLER_CODE);
            out.newLine();            
            out.close();
        } catch (IOException ex) {
            System.out.println("Error al generar archivo .asm");
        }
    }
}
