/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import Semantico.Symb;
import analizador.lexico.LexerAnalyzer;
import java_cup.runtime.*;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Stack;
import java_cup.runtime.XMLElement;

/**
 *
 * @author gfran
 */
public class NewClass extends java_cup.runtime.lr_parser {

    @Override
    public short[][] production_table() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public short[][] action_table() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public short[][] reduce_table() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int start_state() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int start_production() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int EOF_sym() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public int error_sym() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public Symbol do_action(int i, lr_parser l, Stack stack, int i1) throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    protected void init_actions() throws Exception {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    private ArrayList<String> errores = new ArrayList<>();
    private ArrayList<String> errSemanticos = new ArrayList<>();
    private ArrayList<String> multi_vars = new ArrayList<>();
    private ArrayList<String> params_funct = new ArrayList<>();
    private LexerAnalyzer scanner;
    private ArrayList<Symb> tableSymb = new ArrayList<>();
    private String funct_current;
    private String type_current;

    public String toStringErrores() {
        String value = "";
        for (String error : errores)
            value += error + "\n";
        return value;
    }

    @Override
    protected int error_sync_size () { return 1; }

    @Override
    public void unrecovered_syntax_error(Symbol cur_token){
        if(cur_token == null || cur_token.value == null) { //No se encontró token END
            reportar_error("Error fatal de sintaxis al final del programa.", null);
        }
        else { //Por si acaso
            reportar_error("Error fatal de sintaxis en " + cur_token.value.toString(), cur_token);
        }        
    }

    public void imprimirErrores() {
        System.out.println("\nErrores sintácticos: ");
        for (String error : errores) {
            System.out.println(error);
        }
    }    
    
    /* Reporte de error encontrado. */
    public void report_error(String message, Object info) {
        StringBuilder m = new StringBuilder("ERROR");
        if (info instanceof java_cup.runtime.Symbol) {
            java_cup.runtime.Symbol s = ((java_cup.runtime.Symbol) info);
            if (s.left >= 0) {                
                m.append(" in line "+(s.left+1));
                if (s.right >= 0)
                    m.append(", column "+(s.right+1));
            }
        }
        m.append(" : "+message);
        System.out.println(m.toString());
        errores.add(m.toString());
    }



    @Override
    public void syntax_error(Symbol s){
        System.out.println("compiler has detected a syntax error at line " + s.left 
            + " column " + s.right);
    }
   
    /* Cuando se encuentra un error de donde el sistema no puede
        recuperarse, se lanza un error fatal. Se despliega el mensaje
        de error y se finaliza la ejecucion. */
    public void report_fatal_error(String message, Object info) {
        report_error(message, info);
        System.out.println("ENTRO");
        //System.exit(1);
    }

    public void reportar_error(String message, Object info) {
        StringBuilder m = new StringBuilder("Error");
        if (info instanceof java_cup.runtime.Symbol) {
            java_cup.runtime.Symbol s = ((java_cup.runtime.Symbol) info);
            if (s.left >= 0) {                
                m.append(" en la línea "+(s.left+1));
                if (s.right >= 0)
                    m.append(", columna "+(s.right+1));
            }
        }
        m.append(" : " + message);
        System.out.println(m.toString());
        errores.add(m.toString());
    }

    public boolean add_to_TS(String name, String type_token, String data_type, int line, String ambito, int qty_params) {        
        for (Symb sym: tableSymb) {           
            if (name.equals(sym.getName()) && ambito.equals(sym.getAmbito())) {
                errSemanticos.add("Doblemente declarada: " + name);
                return false;
            }
        }        
        return true;
    }
    
    public void add_multiVars_to_TS(String dt){
        for (String var : multi_vars) {
            add_to_TS(var, "VAR", dt, scanner.current_line(), "GLOBAL", 0);
        }
        multi_vars.clear();
    }
    
    public void prueba(String id, String dt){        
        params_funct.add(dt);
        add_to_TS(id, "PARAM", dt, scanner.current_line(), funct_current, 0);
    }
    
    public boolean increment_numParams(String id_funct) {
        for (Symb symb : tableSymb) {
            if (id_funct.equals(symb.getName())) {
                symb.setQty_params(symb.getQty_params() + 1);
                return true;
            }
        }
        return false;
    }
    
    public void params_into_TS(String id, String dt){
        add_to_TS(id, "PARAM", dt, scanner.current_line(), funct_current, 0);
        increment_numParams(id.toString());
    }
    
    public void sentence_into_TS1(String id1, int line){
        if (existSymb(id1)) {
            ArrayList<String> ids = new ArrayList<>();
            ids.add(id1);
            if(!corroborateTypes(ids)) {
                errSemanticos.add("Tipos incompatibles. Linea: " + line);
            }
        }
    }
    
    public void sentence_into_TS2(String id1, String id2, int line){
        if (existSymb(id1) && existSymb(id2)) {
            ArrayList<String> ids = new ArrayList<>();
            ids.add(id1);
            ids.add(id2);
            if(!corroborateTypes(ids)) {
                errSemanticos.add("Tipos incompatibles. Linea: " + line);
            }
        }
    }
    
    public void sentence_into_TS3(String id1, String id2, String id3, int line){
        if (existSymb(id1)) {
            ArrayList<String> ids = new ArrayList<>();
            ids.add(id1);
            ids.add(id2);
            ids.add(id3);
            if(!corroborateTypes(ids)) {
                errSemanticos.add("Tipos incompatibles. Linea: " + line);
            }
        }
    }
    
    public String toStringErrSem() {
        String value = "****** ERRORES SEMANTICOS ******\n";
        for (String errSemantico : errSemanticos) {
            value += errSemantico + "\n";
        }
        return value;
    }
    
    public boolean existSymb(String id) {
        for (Symb symb : tableSymb) {
            if (id.equals(symb.getName()) && (funct_current.equals(symb.getAmbito()) || symb.getAmbito().equals("GLOBAL"))) {
                return true;
            }
        }
        errSemanticos.add("No declarada: " + id);
        return false;
    }
    
    public Symb getSymbTable(String id) {
        for (Symb symb : tableSymb) {
            if (id.equals(symb.getName())) {
                return symb;
            }
        }
        return null;
    }
    
    public boolean corroborateTypes(ArrayList<String> ids) {        
        Symb sym = getSymbTable(ids.get(0));
        for (String id : ids) {
            for (Symb symb : tableSymb) {
                if(id.equals(symb.getName())){
                    if (sym.getType_token().equals(symb.getType_token())) {
                        break;
                    } else {
                        return false;
                    }
                }
            }
        }
        return true;
    }
}
