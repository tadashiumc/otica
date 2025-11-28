/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

import java.sql.*;
import model.Usuario;
import config.ConectaDB;
import config.MD5Util;
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;

/**
 * DAO para gerenciar usuários
 * @author Notezin
 */
public class UsuarioDAO {

    /**
     * Faz login do usuário verificando usuário e senha
     * @param nomeUsuario Nome de usuário
     * @param senha Senha em texto plano
     * @return Objeto Usuario se login for bem-sucedido, null caso contrário
     */
    public Usuario login(String nomeUsuario, String senha) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            
            String sql = "SELECT * FROM usuarios WHERE nome_usuario = '" + nomeUsuario + "' AND status = 'Ativo'";
            ResultSet rs = stmt.executeQuery(sql);
            
            if (rs.next()) {
                String senhaHashBD = rs.getString("senha");
                
                // Verificar senha
                if (MD5Util.verificar(senha, senhaHashBD)) {
                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("id_usuario"));
                    usuario.setNomeUsuario(rs.getString("nome_usuario"));
                    usuario.setEmail(rs.getString("email"));
                    usuario.setPerfil(rs.getString("perfil"));
                    usuario.setStatus(rs.getString("status"));
                    usuario.setDataCadastro(rs.getDate("data_cadastro"));
                    
                    conn.close();
                    return usuario;
                }
            }
            
            conn.close();
            return null;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    /**
     * Cadastra um novo usuário
     * @param usuario Objeto Usuario com dados
     * @return true se cadastro bem-sucedido
     */
    public boolean cadastrar(Usuario usuario) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            
            // Criptografar senha
            String senhaCriptografada = MD5Util.criptografar(usuario.getSenha());
            
            String sql = "INSERT INTO usuarios " +
                    "(nome_usuario, email, senha, perfil, status, data_cadastro) " +
                    "VALUES ('" + usuario.getNomeUsuario() +
                    "', '" + usuario.getEmail() +
                    "', '" + senhaCriptografada +
                    "', '" + usuario.getPerfil() +
                    "', '" + usuario.getStatus() +
                    "', '" + new SimpleDateFormat("yyyy-MM-dd").format(usuario.getDataCadastro()) + "')";
            
            stmt.executeUpdate(sql);
            System.out.println("Usuário cadastrado com sucesso!");
            conn.close();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * Consulta usuário por ID
     * @param idUsuario ID do usuário
     * @return Objeto Usuario
     */
    public Usuario consultaPorId(int idUsuario) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM usuarios WHERE id_usuario = " + idUsuario;
            ResultSet rs = stmt.executeQuery(sql);
            
            Usuario usuario = null;
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("id_usuario"));
                usuario.setNomeUsuario(rs.getString("nome_usuario"));
                usuario.setEmail(rs.getString("email"));
                usuario.setPerfil(rs.getString("perfil"));
                usuario.setStatus(rs.getString("status"));
                usuario.setDataCadastro(rs.getDate("data_cadastro"));
            }
            
            conn.close();
            return usuario;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    /**
     * Consulta todos os usuários
     * @return Lista de usuários
     */
    public List<Usuario> consulta_geral() throws ClassNotFoundException {
        List<Usuario> lista = new ArrayList<>();
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM usuarios ORDER BY nome_usuario";
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setIdUsuario(rs.getInt("id_usuario"));
                usuario.setNomeUsuario(rs.getString("nome_usuario"));
                usuario.setEmail(rs.getString("email"));
                usuario.setPerfil(rs.getString("perfil"));
                usuario.setStatus(rs.getString("status"));
                usuario.setDataCadastro(rs.getDate("data_cadastro"));
                
                lista.add(usuario);
            }
            
            conn.close();
            return lista.isEmpty() ? null : lista;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    /**
     * Verifica se nome de usuário já existe
     * @param nomeUsuario Nome a verificar
     * @return true se existe
     */
    public boolean existeNomeUsuario(String nomeUsuario) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT COUNT(*) as total FROM usuarios WHERE nome_usuario = '" + nomeUsuario + "'";
            ResultSet rs = stmt.executeQuery(sql);
            
            if (rs.next()) {
                return rs.getInt("total") > 0;
            }
            
            conn.close();
            return false;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * Altera um usuário
     * @param usuario Objeto Usuario com dados
     * @return true se alteração bem-sucedida
     */
    public boolean alterar(Usuario usuario) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            
            String sql = "UPDATE usuarios SET " +
                    "email = '" + usuario.getEmail() +
                    "', perfil = '" + usuario.getPerfil() +
                    "', status = '" + usuario.getStatus() +
                    "' WHERE id_usuario = " + usuario.getIdUsuario();
            
            stmt.executeUpdate(sql);
            System.out.println("Usuário alterado com sucesso!");
            conn.close();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * Altera senha de um usuário
     * @param idUsuario ID do usuário
     * @param novaSenha Nova senha em texto plano
     * @return true se alteração bem-sucedida
     */
    public boolean alterarSenha(int idUsuario, String novaSenha) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            
            String senhaCriptografada = MD5Util.criptografar(novaSenha);
            
            String sql = "UPDATE usuarios SET senha = '" + senhaCriptografada +
                    "' WHERE id_usuario = " + idUsuario;
            
            stmt.executeUpdate(sql);
            System.out.println("Senha alterada com sucesso!");
            conn.close();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * Exclui um usuário
     * @param idUsuario ID do usuário
     * @return true se exclusão bem-sucedida
     */
    public boolean excluir(int idUsuario) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "DELETE FROM usuarios WHERE id_usuario = " + idUsuario;
            
            int resultado = stmt.executeUpdate(sql);
            conn.close();
            
            if (resultado > 0) {
                System.out.println("Usuário excluído com sucesso!");
                return true;
            }
            return false;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }
}
