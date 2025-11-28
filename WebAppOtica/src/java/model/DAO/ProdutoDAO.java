/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

import java.sql.*;
import model.Produto;
import config.ConectaDB;
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;

public class ProdutoDAO {
    public boolean cadastrar(Produto p_produto) throws ClassNotFoundException {
        Connection conn = null;        
        try {           
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "INSERT INTO produtos " +
            "(codigo_produto, nome_produto, marca, tipo_produto, preco_custo, preco_venda, quantidade_estoque, data_cadastro, situacao) " +
            "VALUES ('" + p_produto.getCodigoProduto() 
            + "', '" + p_produto.getNomeProduto() 
            + "', '" + p_produto.getMarca() 
            + "', '" + p_produto.getTipoProduto() 
            + "', " + p_produto.getPrecoCusto() 
            + ", " + p_produto.getPrecoVenda() 
            + ", " + p_produto.getQuantidadeEstoque() 
            + ", '" + new SimpleDateFormat("yyyy-MM-dd").format(p_produto.getDataCadastro()) 
            + "', '" + p_produto.getSituacao() + "')";            
            stmt.executeUpdate(sql);
            System.out.println("Registro incluído com sucesso!");
            conn.close();
            return true;
        } catch (SQLException ex) {
            return false;
        }        
    }

    public List<Produto> consulta_geral() throws ClassNotFoundException {
        List<Produto> lst = new ArrayList<>();
        Connection conn = null;        
        try {           
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM produtos ORDER BY nome_produto";  
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Produto prod = new Produto();
                prod.setIdProduto(rs.getInt("id_produto"));
                prod.setCodigoProduto(rs.getString("codigo_produto"));
                prod.setNomeProduto(rs.getString("nome_produto"));
                prod.setMarca(rs.getString("marca"));
                prod.setTipoProduto(rs.getString("tipo_produto"));
                prod.setPrecoCusto(rs.getDouble("preco_custo"));
                prod.setPrecoVenda(rs.getDouble("preco_venda"));
                prod.setQuantidadeEstoque(rs.getInt("quantidade_estoque"));
                prod.setDataCadastro(rs.getDate("data_cadastro"));
                prod.setSituacao(rs.getString("situacao"));
                lst.add(prod);                
            }            
            conn.close();
            return lst.isEmpty() ? null : lst;
        } catch(SQLException ex) {
            ex.printStackTrace();
            return null;
        }        
    }

    public List<Produto> consultaPorNome(String nome) {
    List<Produto> produtos = new ArrayList<>();
    Connection conn = null;
    try {
        conn = ConectaDB.conectar();
        String sql = "SELECT * FROM produtos WHERE nome_produto LIKE ? AND quantidade_estoque > 0 AND situacao = 'Ativo'";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%" + nome + "%");
        
        ResultSet rs = pstmt.executeQuery();
        
        while (rs.next()) {
            Produto produto = new Produto();
            produto.setIdProduto(rs.getInt("id_produto"));
            produto.setCodigoProduto(rs.getString("codigo_produto"));
            produto.setNomeProduto(rs.getString("nome_produto"));
            produto.setMarca(rs.getString("marca"));
            produto.setTipoProduto(rs.getString("tipo_produto"));
            produto.setPrecoCusto(rs.getDouble("preco_custo"));
            produto.setPrecoVenda(rs.getDouble("preco_venda"));
            produto.setQuantidadeEstoque(rs.getInt("quantidade_estoque"));
            produto.setDataCadastro(rs.getDate("data_cadastro"));
            produto.setSituacao(rs.getString("situacao"));
            
            produtos.add(produto);
        }
        
        conn.close();
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
    }
    
    return produtos;
}
    
    public Produto consultaPorId(int idProduto) throws ClassNotFoundException {        
        Connection conn = null;        
        try {           
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM produtos WHERE id_produto = " + idProduto;  
            ResultSet rs = stmt.executeQuery(sql);
            Produto prod = null;
            int n_reg = 0;
            while (rs.next()) {
                prod = new Produto();
                prod.setIdProduto(rs.getInt("id_produto"));
                prod.setCodigoProduto(rs.getString("codigo_produto"));
                prod.setNomeProduto(rs.getString("nome_produto"));
                prod.setMarca(rs.getString("marca"));
                prod.setTipoProduto(rs.getString("tipo_produto"));
                prod.setPrecoCusto(rs.getDouble("preco_custo"));
                prod.setPrecoVenda(rs.getDouble("preco_venda"));
                prod.setQuantidadeEstoque(rs.getInt("quantidade_estoque"));
                prod.setDataCadastro(rs.getDate("data_cadastro"));
                prod.setSituacao(rs.getString("situacao"));
                n_reg++;
            }            
            conn.close();
            return n_reg == 0 ? null : prod;
        } catch(SQLException ex) {
            ex.printStackTrace();
            return null;
        }        
    }

    public List<Produto> consulta_nome(String p_nome) throws ClassNotFoundException {
        List<Produto> lst = new ArrayList<>();
        Connection conn = null;        
        try {           
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM produtos WHERE nome_produto LIKE '%" + p_nome + "%' ORDER BY nome_produto";  
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Produto prod = new Produto();
                prod.setIdProduto(rs.getInt("id_produto"));
                prod.setCodigoProduto(rs.getString("codigo_produto"));
                prod.setNomeProduto(rs.getString("nome_produto"));
                prod.setMarca(rs.getString("marca"));
                prod.setTipoProduto(rs.getString("tipo_produto"));
                prod.setPrecoCusto(rs.getDouble("preco_custo"));
                prod.setPrecoVenda(rs.getDouble("preco_venda"));
                prod.setQuantidadeEstoque(rs.getInt("quantidade_estoque"));
                prod.setDataCadastro(rs.getDate("data_cadastro"));
                prod.setSituacao(rs.getString("situacao"));
                lst.add(prod);                
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
            String sql = "DELETE FROM produtos WHERE id_produto = " + p_id;            
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

    public boolean alterar(Produto p_produto) throws ClassNotFoundException {
        Connection conn = null;        
        try {           
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();            
            String sql = "UPDATE produtos SET " +
            "codigo_produto = '" + p_produto.getCodigoProduto() + "', " +
            "nome_produto = '" + p_produto.getNomeProduto() + "', " +
            "marca = '" + p_produto.getMarca() + "', " +
            "tipo_produto = '" + p_produto.getTipoProduto() + "', " +
            "preco_custo = " + p_produto.getPrecoCusto() + ", " +
            "preco_venda = " + p_produto.getPrecoVenda() + ", " +
            "quantidade_estoque = " + p_produto.getQuantidadeEstoque() + ", " +
            "data_cadastro = '" + new SimpleDateFormat("yyyy-MM-dd").format(p_produto.getDataCadastro()) + "', " +
            "situacao = '" + p_produto.getSituacao() + "' " +
            "WHERE id_produto = " + p_produto.getIdProduto();            
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