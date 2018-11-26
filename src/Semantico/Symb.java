/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Semantico;
    
/**
 *
 * @author gfran
 */
public class Symb {

    private String name;
    private String type_token;
    private String data_type;
    private int linea;
    private String ambito;
    private int qty_params;

    public Symb(String name, String type_token, String data_type, int linea, String ambito, int qty_params) {
        this.name = name;
        this.type_token = type_token;
        this.data_type = data_type;
        this.linea = linea;
        this.ambito = ambito;
        this.qty_params = qty_params;
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
     * @return the type_token
     */
    public String getType_token() {
        return type_token;
    }

    /**
     * @param type_token the type_token to set
     */
    public void setType_token(String type_token) {
        this.type_token = type_token;
    }

    /**
     * @return the data_type
     */
    public String getData_type() {
        return data_type;
    }

    /**
     * @param data_type the data_type to set
     */
    public void setData_type(String data_type) {
        this.data_type = data_type;
    }

    /**
     * @return the linea
     */
    public int getLinea() {
        return linea;
    }

    /**
     * @param linea the linea to set
     */
    public void setLinea(int linea) {
        this.linea = linea;
    }

    /**
     * @return the ambito
     */
    public String getAmbito() {
        return ambito;
    }

    /**
     * @param ambito the ambito to set
     */
    public void setAmbito(String ambito) {
        this.ambito = ambito;
    }

    /**
     * @return the qty_params
     */
    public int getQty_params() {
        return qty_params;
    }

    /**
     * @param qty_params the qty_params to set
     */
    public void setQty_params(int qty_params) {
        this.qty_params = qty_params;
    }

    @Override
    public String toString() {
        return "Symb{" + "name=" + name + ", type_token=" + type_token + ", data_type=" + data_type + ", linea=" + linea + ", ambito=" + ambito + ", qty_params=" + qty_params + '}';
    }    
}
