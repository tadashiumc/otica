/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

import java.sql.*;
import model.Cliente;
import config.ConectaDB;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;

/**
 * @author notezin
 */
public class ClienteDAO {
    public boolean cadastrar(Cliente p_cliente) throws ClassNotFoundException {
    Connection conn = null;        
    try {           
        conn = ConectaDB.conectar();
        Statement stmt = conn.createStatement();
        
        String sql = "INSERT INTO clientes " +
                     "(nome_completo, cpf, data_nascimento, email, telefone, endereco, cidade, estado, observacoes) " +
                     "VALUES ('" + p_cliente.getNomeCompleto() 
                     + "', '" + p_cliente.getCpf() 
                     + "', '" + new SimpleDateFormat("yyyy-MM-dd").format(p_cliente.getDataNascimento()) 
                     + "', '" + p_cliente.getEmail() 
                     + "', '" + p_cliente.getTelefone() 
                     + "', '" + p_cliente.getEndereco() 
                     + "', '" + p_cliente.getCidade() 
                     + "', '" + p_cliente.getEstado() 
                     + "', '" + p_cliente.getObservacoes() + "')";            
        
        stmt.executeUpdate(sql);
        System.out.println("Registro incluído com sucesso!");
        conn.close();
        return true;
    } catch (SQLException ex) {
        return false;
    }        
}

    public List<Cliente> consulta_geral() throws ClassNotFoundException {
    List<Cliente> lst = new ArrayList<>();
    Connection conn = null;        
    try {           
        conn = ConectaDB.conectar();
        Statement stmt = conn.createStatement();
        String sql = "SELECT * FROM clientes ORDER BY nome_completo";  
        ResultSet rs = stmt.executeQuery(sql);
        
        while (rs.next()) {
            Cliente cli = new Cliente();
            cli.setIdCliente(rs.getInt("id_cliente"));
            cli.setNomeCompleto(rs.getString("nome_completo"));
            cli.setCpf(rs.getString("cpf"));
            
            // Adicionando recuperação da data de nascimento
            cli.setDataNascimento(rs.getDate("data_nascimento"));
            
            cli.setEmail(rs.getString("email"));
            cli.setTelefone(rs.getString("telefone"));
            cli.setEndereco(rs.getString("endereco"));
            cli.setCidade(rs.getString("cidade"));
            cli.setEstado(rs.getString("estado"));
            cli.setObservacoes(rs.getString("observacoes"));
            
            lst.add(cli);                
        }            
        
        conn.close();
        return lst.isEmpty() ? null : lst;
    } catch(SQLException ex) {
        ex.printStackTrace();
        return null;
    }        
}

    public Cliente consultaPorId(int idCliente) throws ClassNotFoundException {        
    Connection conn = null;        
    try {           
        conn = ConectaDB.conectar();
        Statement stmt = conn.createStatement();
        String sql = "SELECT * FROM clientes WHERE id_cliente = " + idCliente;  
        ResultSet rs = stmt.executeQuery(sql);
        
        Cliente cli = null;
        int n_reg = 0;
        
        while (rs.next()) {
            cli = new Cliente();
            cli.setIdCliente(rs.getInt("id_cliente"));
            cli.setNomeCompleto(rs.getString("nome_completo"));
            cli.setCpf(rs.getString("cpf"));
            cli.setDataNascimento(rs.getDate("data_nascimento"));
            cli.setEmail(rs.getString("email"));
            cli.setTelefone(rs.getString("telefone"));
            cli.setEndereco(rs.getString("endereco"));
            cli.setCidade(rs.getString("cidade"));
            cli.setEstado(rs.getString("estado"));
            cli.setObservacoes(rs.getString("observacoes"));
            n_reg++;
        }            
        
        conn.close();
        return n_reg == 0 ? null : cli;
    } catch(SQLException ex) {
        ex.printStackTrace();
        return null;
    }        
}

    public List<Cliente> consulta_nome(String p_nome) throws ClassNotFoundException {
    List<Cliente> lst = new ArrayList<>();
    Connection conn = null;        
    try {           
        conn = ConectaDB.conectar();
        Statement stmt = conn.createStatement();
        String sql = "SELECT * FROM clientes WHERE nome_completo LIKE '%" + p_nome + "%' ORDER BY nome_completo";  
        ResultSet rs = stmt.executeQuery(sql);
        
        while (rs.next()) {
            Cliente cli = new Cliente();
            cli.setIdCliente(rs.getInt("id_cliente"));
            cli.setNomeCompleto(rs.getString("nome_completo"));
            cli.setCpf(rs.getString("cpf"));
            cli.setDataNascimento(rs.getDate("data_nascimento"));
            cli.setEmail(rs.getString("email"));
            cli.setTelefone(rs.getString("telefone"));
            cli.setEndereco(rs.getString("endereco"));
            cli.setCidade(rs.getString("cidade"));
            cli.setEstado(rs.getString("estado"));
            cli.setObservacoes(rs.getString("observacoes"));
            
            lst.add(cli);                
        }            
        
        conn.close();
        return lst.isEmpty() ? null : lst;
    } catch(SQLException ex) {
        ex.printStackTrace();
        return null;
    }        
}

    public List<Cliente> consultaPorNome(String nome) {
    List<Cliente> clientes = new ArrayList<>();
    Connection conn = null;
    try {
        conn = ConectaDB.conectar();
        String sql = "SELECT * FROM clientes WHERE nome_completo LIKE ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%" + nome + "%");
        
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Cliente cliente = new Cliente();
            cliente.setIdCliente(rs.getInt("id_cliente"));
            cliente.setNomeCompleto(rs.getString("nome_completo"));
            cliente.setCpf(rs.getString("cpf"));
            cliente.setEmail(rs.getString("email"));
            cliente.setTelefone(rs.getString("telefone"));
            cliente.setDataNascimento(rs.getDate("data_nascimento"));
            cliente.setEndereco(rs.getString("endereco"));
            cliente.setCidade(rs.getString("cidade"));
            cliente.setEstado(rs.getString("estado"));
            cliente.setObservacoes(rs.getString("observacoes"));
            
            clientes.add(cliente);
        }
        
        conn.close();
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
    
    return clientes;
}
    public boolean excluir(int p_id) throws ClassNotFoundException {
    Connection conn = null;        
    try {           
        conn = ConectaDB.conectar();
        Statement stmt = conn.createStatement();
        String sql = "DELETE FROM clientes WHERE id_cliente = " + p_id;            
        int result = stmt.executeUpdate(sql);
        
        conn.close();
        
        if (result > 0) {
            System.out.println("Registro excluído com sucesso! - " + result);
            return true;
        } else {
            return false;
        }            
    } catch(SQLException ex) {
        ex.printStackTrace();
        return false;
    } finally {
        // Garantir fechamento da conexão
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }        
}

    public boolean alterar(Cliente p_cliente) throws ClassNotFoundException {
    Connection conn = null;        
    try {           
        conn = ConectaDB.conectar();
        Statement stmt = conn.createStatement();            
        String sql = "UPDATE clientes SET " +
        "nome_completo = '" + p_cliente.getNomeCompleto() + "', " +
        "cpf = '" + p_cliente.getCpf() + "', " +
        "data_nascimento = '" + new SimpleDateFormat("yyyy-MM-dd").format(p_cliente.getDataNascimento()) + "', " +
        "email = '" + p_cliente.getEmail() + "', " +
        "telefone = '" + p_cliente.getTelefone() + "', " +
        "endereco = '" + p_cliente.getEndereco() + "', " +
        "cidade = '" + p_cliente.getCidade() + "', " +
        "estado = '" + p_cliente.getEstado() + "', " +
        "observacoes = '" + p_cliente.getObservacoes() + "' " +
        "WHERE id_cliente = " + p_cliente.getIdCliente();            
        
        stmt.executeUpdate(sql);
        System.out.println("Registro alterado com sucesso!");
        
        conn.close();
        return true;
    } catch(SQLException ex) {
        ex.printStackTrace();
        return false;
    } finally {
        // Garantir fechamento da conexão
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }}
}
