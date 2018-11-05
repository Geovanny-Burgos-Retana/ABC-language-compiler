/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package analizador.lexico;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFileChooser;
import javax.swing.filechooser.FileNameExtensionFilter;
import jflex.Main;

public class Interfaz extends javax.swing.JFrame {

    /**
     * Creates new form Interfaz
     */
    public Interfaz() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jPanel1 = new javax.swing.JPanel();
        jScrollPane1 = new javax.swing.JScrollPane();
        taTokens = new javax.swing.JTextArea();
        jSeparator1 = new javax.swing.JSeparator();
        jScrollPane2 = new javax.swing.JScrollPane();
        taErrores = new javax.swing.JTextArea();
        jPanel2 = new javax.swing.JPanel();
        btnGenerar = new javax.swing.JButton();
        jPanel3 = new javax.swing.JPanel();
        labelJFlex = new javax.swing.JLabel();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        jLabel8 = new javax.swing.JLabel();
        btnArchivo = new javax.swing.JButton();
        labelDir = new javax.swing.JLabel();
        jLabel9 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jPanel1.setLayout(new javax.swing.BoxLayout(jPanel1, javax.swing.BoxLayout.LINE_AXIS));

        taTokens.setColumns(20);
        taTokens.setRows(5);
        jScrollPane1.setViewportView(taTokens);

        jPanel1.add(jScrollPane1);

        jSeparator1.setOrientation(javax.swing.SwingConstants.VERTICAL);
        jSeparator1.setMaximumSize(new java.awt.Dimension(3767, 3767));
        jPanel1.add(jSeparator1);

        taErrores.setColumns(20);
        taErrores.setRows(5);
        jScrollPane2.setViewportView(taErrores);

        jPanel1.add(jScrollPane2);

        jPanel2.setLayout(new java.awt.BorderLayout());

        btnGenerar.setText("Generar");
        btnGenerar.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnGenerarActionPerformed(evt);
            }
        });
        jPanel2.add(btnGenerar, java.awt.BorderLayout.PAGE_START);

        jPanel3.setLayout(new java.awt.BorderLayout());
        jPanel3.add(labelJFlex, java.awt.BorderLayout.PAGE_START);

        jLabel1.setFont(new java.awt.Font("Dialog", 1, 14)); // NOI18N
        jLabel1.setText("Listado de Tokens Válidos");

        jLabel2.setFont(new java.awt.Font("Dialog", 1, 14)); // NOI18N
        jLabel2.setText("Listado de Errores Léxicos");

        jLabel3.setText("Token");

        jLabel4.setText("Tipo");

        jLabel5.setText("Línea (Apariciones)");

        jLabel6.setText("Línea (Apariciones)");

        jLabel7.setText("Tipo");

        jLabel8.setText("Token");

        btnArchivo.setText("Escoger archivo");
        btnArchivo.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                btnArchivoActionPerformed(evt);
            }
        });

        jLabel9.setFont(new java.awt.Font("Monotype Corsiva", 1, 24)); // NOI18N
        jLabel9.setForeground(new java.awt.Color(0, 0, 153));
        jLabel9.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel9.setText("Analizador Léxico - Sintáctico");
        jLabel9.setVerticalAlignment(javax.swing.SwingConstants.BOTTOM);
        jLabel9.setAlignmentY(0.8F);
        jLabel9.setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        jLabel9.setMaximumSize(new java.awt.Dimension(294, 67));
        jLabel9.setMinimumSize(new java.awt.Dimension(254, 57));
        jLabel9.setPreferredSize(new java.awt.Dimension(254, 87));

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .addGroup(layout.createSequentialGroup()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addComponent(jPanel2, javax.swing.GroupLayout.PREFERRED_SIZE, 167, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(btnArchivo, javax.swing.GroupLayout.PREFERRED_SIZE, 167, javax.swing.GroupLayout.PREFERRED_SIZE))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                                    .addGroup(layout.createSequentialGroup()
                                        .addComponent(labelDir, javax.swing.GroupLayout.PREFERRED_SIZE, 775, javax.swing.GroupLayout.PREFERRED_SIZE)
                                        .addGap(0, 0, Short.MAX_VALUE))
                                    .addComponent(jPanel3, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))
                        .addContainerGap())
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel3)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 161, Short.MAX_VALUE)
                        .addComponent(jLabel4)
                        .addGap(140, 140, 140)
                        .addComponent(jLabel5)
                        .addGap(144, 144, 144)
                        .addComponent(jLabel8)
                        .addGap(144, 144, 144)
                        .addComponent(jLabel7)
                        .addGap(134, 134, 134)
                        .addComponent(jLabel6)
                        .addGap(133, 133, 133))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(151, 151, 151)
                        .addComponent(jLabel1)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(jLabel2)
                        .addGap(194, 194, 194))))
            .addGroup(layout.createSequentialGroup()
                .addGap(418, 418, 418)
                .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 345, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(0, 0, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jLabel9, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(jPanel2, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(jPanel3, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(btnArchivo)
                    .addComponent(labelDir, javax.swing.GroupLayout.PREFERRED_SIZE, 32, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(21, 21, 21)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 33, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(13, 13, 13)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel3)
                    .addComponent(jLabel4)
                    .addComponent(jLabel8)
                    .addComponent(jLabel7)
                    .addComponent(jLabel6)
                    .addComponent(jLabel5))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, 447, Short.MAX_VALUE)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void btnGenerarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnGenerarActionPerformed
        try {
            /*Generar el archivo Flex*/
            File arch = new File("src/analizador/lexico/Lexer.java");
            //Reemplaza el archivo existente con el nuevo archivo limpio
            //si el archivo existe, eliminelo
            if (arch.exists()) {
                Path currentRelativePath = Paths.get("");
                String nuevoDir = currentRelativePath.toAbsolutePath().toString() + File.separator
                        + "src" + File.separator
                        + "analizador" + File.separator
                        + "lexico" + File.separator
                        + arch.getName();

                File archViejo = new File(nuevoDir);
                archViejo.delete();
            }

            //generar el nuevo archivo java a partir del flex
            String[] flex = {"src/analizador/lexico/Lexer.flex"};
            jflex.Main.main(flex);
            String archSintactico = "C:/Users/FranM/OneDrive/Documentos/Git Repositorios/ABC-language-compiler/src/analizador/lexico/Parser.cup";
            String[] asintactico = {"-parser", "AnalizadorSintactico", archSintactico};
            try {
                java_cup.Main.main(asintactico);
            } catch (Exception ex) {
                Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
            }
            boolean mvAS = moverArch("AnalizadorSintactico.java");
            boolean mvSym = moverArch("sym.java");
            if (mvAS && mvSym) {
                System.out.println("Generado!");
            }
            labelJFlex.setText("Archivo Flex cargado con exito.");
        } catch (Exception e) {
            labelJFlex.setText("Error: Archivo Flex no se pudo cargar");
        }
    }//GEN-LAST:event_btnGenerarActionPerformed

    private void btnArchivoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnArchivoActionPerformed
        try {
            JFileChooser chooser = new JFileChooser();
            FileNameExtensionFilter filter = new FileNameExtensionFilter("TEXT FILES", "txt", "text");
            chooser.setFileFilter(filter);
            int returnVal = chooser.showOpenDialog(null);
            if (returnVal == JFileChooser.APPROVE_OPTION) {
                String entrada = chooser.getSelectedFile().getPath();
                System.out.println(entrada);
                try {
                    LexerAnalyzer scanner = new LexerAnalyzer(new FileReader(entrada));
                    AnalizadorSintactico asin = new AnalizadorSintactico(scanner);
                    Object result = asin.parse().value;
                    taTokens.setText(scanner.toStringTokens());
                    taErrores.setText(scanner.toStringErrores());
                    //System.out.println(scanner.toStringErrores());
                    //asin.imprimirErrores();
                    System.out.println("\n*** Resultados finales ***");
                } catch (Exception ex) {
                    ex.printStackTrace();
                }

                /*BufferedReader bf = null;
                try {
                    //llamar a los tokens uno por uno, con la funcion nexttoken
                    bf = new BufferedReader(new FileReader(entrada));
                    //LexerAnalyzer a = new LexerAnalyzer(bf);
                    //Yytoken token = null;
                    do {
                        //token = a.nextToken();
                    } while (token != null);

                    taTokens.setText(a.toStringTokens());
                    taErrores.setText(a.toStringErrores());

                } catch (Exception ex) {
                    Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                } finally {
                    try {
                        bf.close();
                    } catch (IOException ex) {
                        Logger.getLogger(Main.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }*/
            }
            labelDir.setText("Archivo .txt cargado correctamente");
            //taRespuestas.setText("Archivo:" + chooser.getSelectedFile().getPath() + "\n\nRespuestas de Tokens guardados en los siguientes archivos:\nfile.txt -> Contiene los tokens analizados con sus respectivos detalles\nerrores.txt -> Contiene los errores encontrados durante el analisis");
        } catch (Exception e) {
            labelDir.setText("Error: no se pudo cargar el archivo");
        }
    }//GEN-LAST:event_btnArchivoActionPerformed

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Interfaz.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Interfaz.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Interfaz.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Interfaz.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Interfaz().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnArchivo;
    private javax.swing.JButton btnGenerar;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JScrollPane jScrollPane2;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JLabel labelDir;
    private javax.swing.JLabel labelJFlex;
    private javax.swing.JTextArea taErrores;
    private javax.swing.JTextArea taTokens;
    // End of variables declaration//GEN-END:variables

    public static boolean moverArch(String archNombre) {
        boolean efectuado = false;
        File arch = new File(archNombre);
        if (arch.exists()) {
            System.out.println("\n*** Moviendo " + arch + " \n***");
            Path currentRelativePath = Paths.get("");
            String nuevoDir = currentRelativePath.toAbsolutePath().toString()
                    + File.separator + "src" + File.separator
                    + "analizador" + File.separator
                    + "lexico" + File.separator + arch.getName();
            File archViejo = new File(nuevoDir);
            archViejo.delete();
            if (arch.renameTo(new File(nuevoDir))) {
                System.out.println("\n*** Generado " + archNombre + "***\n");
                efectuado = true;
            } else {
                System.out.println("\n*** No movido " + archNombre + " ***\n");
            }

        } else {
            System.out.println("\n*** Codigo no existente ***\n");
        }
        return efectuado;
    }

}
