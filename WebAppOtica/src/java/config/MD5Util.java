/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Classe utilitária para criptografia MD5
 * @author Notezin
 */
public class MD5Util {

    /**
     * Converte uma string para hash MD5
     * @param texto Texto a ser criptografado
     * @return Hash MD5 da string
     */
    public static String criptografar(String texto) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(texto.getBytes());
            
            // Converter bytes para hexadecimal
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < messageDigest.length; i++) {
                String hex = Integer.toHexString(0xff & messageDigest[i]);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Verifica se uma senha está correta comparando com hash
     * @param senhaPlana Senha sem criptografia
     * @param senhaHash Hash armazenado no banco
     * @return true se as senhas correspondem
     */
    public static boolean verificar(String senhaPlana, String senhaHash) {
        String senhaPlanaHash = criptografar(senhaPlana);
        return senhaPlanaHash != null && senhaPlanaHash.equals(senhaHash);
    }
}
