/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

import java.sql.*;
import model.Funcionario;
import config.ConectaDB;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class FuncionarioDAO {

    public boolean cadastrar(Funcionario p_funcionario) throws ClassNotFoundException {
        Connection conn = null;        
        try {           
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO funcionarios " +
            "(nome_completo, cpf, data_nascimento, email, telefone, cargo, data_admissao, salario, status) " +
            "VALUES ('" + p_funcionario.getNomeCompleto() 
            + "', '" + p_funcionario.getCpf() 
            + "', '" + new SimpleDateFormat("yyyy-MM-dd").format(p_funcionario.getDataNascimento()) 
            + "', '" + p_funcionario.getEmail() 
            + "', '" + p_funcionario.getTelefone() 
            + "', '" + p_funcionario.getCargo() 
            + "', '" + new SimpleDateFormat("yyyy-MM-dd").format(p_funcionario.getDataAdmissao()) 
            + "', " + p_funcionario.getSalario() 
            + ", '" + p_funcionario.getStatus() + "')";            
            stmt.executeUpdate(sql);
            System.out.println("Registro incluído com sucesso!");
            conn.close();
            return true;
        } catch (SQLException ex) {
            return false;
        }        
    }

    public List<Funcionario> consulta_geral() throws ClassNotFoundException {
        List<Funcionario> lst = new ArrayList<>();
        Connection conn = null;        
        try {           
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM funcionarios ORDER BY nome_completo";  
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Funcionario func = new Funcionario();
                func.setIdFuncionario(rs.getInt("id_funcionario"));
                func.setNomeCompleto(rs.getString("nome_completo"));
                func.setCpf(rs.getString("cpf"));
                func.setDataNascimento(rs.getDate("data_nascimento"));
                func.setEmail(rs.getString("email"));
                func.setTelefone(rs.getString("telefone"));
                func.setCargo(rs.getString("cargo"));
                func.setDataAdmissao(rs.getDate("data_admissao"));
                func.setSalario(rs.getDouble("salario"));
                func.setStatus(rs.getString("status"));
                lst.add(func);                
            }            
            conn.close();
            return lst.isEmpty() ? null : lst;
        } catch(SQLException ex) {
            ex.printStackTrace();
            return null;
        }        
    }

    public List<Funcionario> consultaPorNome(String nome) {
    List<Funcionario> funcionarios = new ArrayList<>();
    Connection conn = null;
    try {
        conn = ConectaDB.conectar();
        String sql = "SELECT * FROM funcionarios WHERE nome_completo LIKE ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%" + nome + "%");
        
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Funcionario funcionario = new Funcionario();
            funcionario.setIdFuncionario(rs.getInt("id_funcionario"));
            funcionario.setNomeCompleto(rs.getString("nome_completo"));
            funcionario.setCpf(rs.getString("cpf"));
            funcionario.setEmail(rs.getString("email"));
            funcionario.setTelefone(rs.getString("telefone"));
            funcionario.setDataNascimento(rs.getDate("data_nascimento"));
            funcionario.setCargo(rs.getString("cargo"));
            funcionario.setDataAdmissao(rs.getDate("data_admissao"));
            funcionario.setSalario(rs.getDouble("salario"));
            funcionario.setStatus(rs.getString("status"));
            
            funcionarios.add(funcionario);
        }
        
        conn.close();
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
    
    return funcionarios;
}
    
    public Funcionario consultaPorId(int idFuncionario) throws ClassNotFoundException {        
        Connection conn = null;        
        try {           
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM funcionarios WHERE id_funcionario = " + idFuncionario;  
            ResultSet rs = stmt.executeQuery(sql);
            Funcionario func = null;
            int n_reg = 0;
            while (rs.next()) {
                func = new Funcionario();
                func.setIdFuncionario(rs.getInt("id_funcionario"));
                func.setNomeCompleto(rs.getString("nome_completo"));
                func.setCpf(rs.getString("cpf"));
                func.setDataNascimento(rs.getDate("data_nascimento"));
                func.setEmail(rs.getString("email"));
                func.setTelefone(rs.getString("telefone"));
                func.setCargo(rs.getString("cargo"));
                func.setDataAdmissao(rs.getDate("data_admissao"));
                func.setSalario(rs.getDouble("salario"));
                func.setStatus(rs.getString("status"));
                n_reg++;
            }            
            conn.close();
            return n_reg == 0 ? null : func;
        } catch(SQLException ex) {
            ex.printStackTrace();
            return null;
        }        
    }

    public List<Funcionario> consulta_nome(String p_nome) throws ClassNotFoundException {
        List<Funcionario> lst = new ArrayList<>();
        Connection conn = null;        
        try {           
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM funcionarios WHERE nome_completo LIKE '%" + p_nome + "%' ORDER BY nome_completo";  
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Funcionario func = new Funcionario();
                func.setIdFuncionario(rs.getInt("id_funcionario"));
                func.setNomeCompleto(rs.getString("nome_completo"));
                func.setCpf(rs.getString("cpf"));
                func.setDataNascimento(rs.getDate("data_nascimento"));
                func.setEmail(rs.getString("email"));
                func.setTelefone(rs.getString("telefone"));
                func.setCargo(rs.getString("cargo"));
                func.setDataAdmissao(rs.getDate("data_admissao"));
                func.setSalario(rs.getDouble("salario"));
                func.setStatus(rs.getString("status"));
                lst.add(func);                
            }            
            conn.close();
            return lst.isEmpty() ? null : lst;
        } catch(SQLException ex) {
            ex.printStackTrace();
            return null;
        }        
    }

    public boolean excluir(int p_id) throws ClassNotFoundException {
        Connection conn = null;        
        try {           
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "DELETE FROM funcionarios WHERE id_funcionario = " + p_id;            
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
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }        
    }

    public boolean alterar(Funcionario p_funcionario) throws ClassNotFoundException {
        Connection conn = null;        
        try {           
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();            
            String sql = "UPDATE funcionarios SET " +
            "nome_completo = '" + p_funcionario.getNomeCompleto() + "', " +
            "cpf = '" + p_funcionario.getCpf() + "', " +
            "data_nascimento = '" + new SimpleDateFormat("yyyy-MM-dd").format(p_funcionario.getDataNascimento()) + "', " +
            "email = '" + p_funcionario.getEmail() + "', " +
            "telefone = '" + p_funcionario.getTelefone() + "', " +
            "cargo = '" + p_funcionario.getCargo() + "', " +
            "data_admissao = '" + new SimpleDateFormat("yyyy-MM-dd").format(p_funcionario.getDataAdmissao()) + "', " +
            "salario = " + p_funcionario.getSalario() + ", " +
            "status = '" + p_funcionario.getStatus() + "' " +
            "WHERE id_funcionario = " + p_funcionario.getIdFuncionario();            
            stmt.executeUpdate(sql);
            System.out.println("Registro alterado com sucesso!");
            conn.close();
            return true;
        } catch(SQLException ex) {
            ex.printStackTrace();
            return false;
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}