/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

import java.sql.*;
import model.Venda;
import model.ItemVenda;
import config.ConectaDB;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class VendaDAO {
    public boolean cadastrarVenda(Venda venda, List<ItemVenda> itens) {
    Connection conn = null;
    PreparedStatement pstmtVenda = null;
    PreparedStatement pstmtItem = null;
    PreparedStatement pstmtEstoque = null;
    
    try {
        conn = ConectaDB.conectar();
        conn.setAutoCommit(false);  // Iniciar transação

        // Inserir venda
        String sqlVenda = "INSERT INTO vendas " +
            "(id_cliente, id_funcionario, data_venda, valor_total, forma_pagamento, " +
            "numero_parcelas, desconto, status_venda, observacoes) VALUES " +
            "(?, ?, ?, ?, ?, ?, ?, ?, ?)";

        pstmtVenda = conn.prepareStatement(sqlVenda, Statement.RETURN_GENERATED_KEYS);
        
        // Configurar parâmetros da venda (código anterior)
        if (venda.getIdCliente() > 0) {
            pstmtVenda.setInt(1, venda.getIdCliente());
        } else {
            pstmtVenda.setNull(1, java.sql.Types.INTEGER);
        }

        if (venda.getIdFuncionario() > 0) {
            pstmtVenda.setInt(2, venda.getIdFuncionario());
        } else {
            pstmtVenda.setNull(2, java.sql.Types.INTEGER);
        }

        pstmtVenda.setTimestamp(3, new java.sql.Timestamp(venda.getDataVenda().getTime()));
        pstmtVenda.setDouble(4, venda.getValorTotal());
        pstmtVenda.setString(5, venda.getFormaPagamento());
        pstmtVenda.setInt(6, venda.getNumeroParcelas());
        pstmtVenda.setDouble(7, venda.getDesconto());
        pstmtVenda.setString(8, venda.getStatusVenda());
        pstmtVenda.setString(9, venda.getObservacoes());

        pstmtVenda.executeUpdate();

        // Recuperar ID da venda
        ResultSet rs = pstmtVenda.getGeneratedKeys();
        int idVenda = 0;
        if (rs.next()) {
            idVenda = rs.getInt(1);
        }

        // Preparar inserção de itens
        String sqlItem = "INSERT INTO itens_venda " +
            "(id_venda, id_produto, quantidade, valor_unitario, valor_total) VALUES " +
            "(?, ?, ?, ?, ?)";

        // Preparar atualização de estoque
        String sqlEstoque = "UPDATE produtos SET quantidade_estoque = quantidade_estoque - ? WHERE id_produto = ? AND quantidade_estoque >= ?";

        pstmtItem = conn.prepareStatement(sqlItem);
        pstmtEstoque = conn.prepareStatement(sqlEstoque);

        // Inserir itens da venda e atualizar estoque
        for (ItemVenda item : itens) {
            // Inserir item da venda
            pstmtItem.setInt(1, idVenda);
            pstmtItem.setInt(2, item.getIdProduto());
            pstmtItem.setInt(3, item.getQuantidade());
            pstmtItem.setDouble(4, item.getValorUnitario());
            pstmtItem.setDouble(5, item.getValorTotal());
            pstmtItem.executeUpdate();

            // Atualizar estoque
            pstmtEstoque.setInt(1, item.getQuantidade());
            pstmtEstoque.setInt(2, item.getIdProduto());
            pstmtEstoque.setInt(3, item.getQuantidade());
            int linhasAfetadas = pstmtEstoque.executeUpdate();

            // Verificar se o estoque foi suficiente
            if (linhasAfetadas == 0) {
                throw new SQLException("Estoque insuficiente para o produto com ID: " + item.getIdProduto());
            }
        }

        conn.commit();
        return true;
    } catch (SQLException | ClassNotFoundException ex) {
        if (conn != null) {
            try {
                conn.rollback();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        ex.printStackTrace();
        return false;
    } finally {
        try {
            if (pstmtVenda != null) pstmtVenda.close();
            if (pstmtItem != null) pstmtItem.close();
            if (pstmtEstoque != null) pstmtEstoque.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

}}