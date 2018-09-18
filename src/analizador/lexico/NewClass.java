/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package analizador.lexico;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

/**
 *
 * @author geovanny
 */
public class NewClass {

    private int count; // Este lleva la cuenta de los TOKENS y es también el identificador
    private ArrayList<Token> tokens = new ArrayList<>();

    /**
     * Escribe los resultados en un archivo de salida
     * @throws IOException 
     */
    /*private void writeFileOutput() throws IOException {
        String filename = "output.out";
        BufferedWriter out = new BufferedWriter(new FileWriter(filename));
        for (Token token : tokens) {
            out.write(token.toString());
            out.newLine();
        }
        out.close();
    }*/
    
    /**
     * Valida la inserción de un nuevo token, si exite agrega la line o aumenta las ocurrencias del TOKEN en la misma linea
     * @param newToken
     * @param line
     * @return 
     */
    /*private boolean addToken(Token newToken, int line) {
        for (Token token : tokens) {
            if (token.getName().equals(newToken.getName()) && token.getType().equals(newToken.getType())) {
                for (int i = 0; i < token.getLines().size(); i++) {
                    if (token.getLines().get(i).equals(line)) {
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
        tokens.add(newToken);
        return true;
    }*/
}
