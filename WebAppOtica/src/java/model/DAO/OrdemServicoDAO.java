/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.DAO;

import java.sql.*;
import model.OrdemServico;
import model.ItemOrdemServico;
import model.Produto;
import model.Cliente;
import model.Funcionario;
import config.ConectaDB;
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;

/**
 *
 * @author Notezin
 */
public class OrdemServicoDAO {

    /**
     * Cadastra uma nova ordem de serviço no banco de dados
     */
    public boolean cadastrar(OrdemServico ordem) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            
            String sql = "INSERT INTO ordem_servico " +
                    "(id_cliente, id_funcionario, data_abertura, status_ordem, " +
                    "descricao_problema, solucao_tecnica, valor_total, garantia) " +
                    "VALUES (" + ordem.getCliente().getIdCliente() +
                    ", " + ordem.getFuncionario().getIdFuncionario() +
                    ", '" + sdf.format(ordem.getDataAbertura()) +
                    "', '" + ordem.getStatusOrdem() +
                    "', '" + ordem.getDescricaoProblem() +
                    "', '" + (ordem.getSolucaoTecnica() != null ? ordem.getSolucaoTecnica() : "") +
                    "', " + ordem.getValorTotal() +
                    ", '" + ordem.getGarantia() + "')";
            
            int resultado = stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
            
            if (resultado > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int idOrdem = generatedKeys.getInt(1);
                    ordem.setIdOrdem(idOrdem);
                    
                    // Cadastrar itens da ordem de serviço
                    if (ordem.getItens() != null && !ordem.getItens().isEmpty()) {
                        for (ItemOrdemServico item : ordem.getItens()) {
                            cadastrarItem(conn, idOrdem, item);
                        }
                    }
                }
                conn.close();
                return true;
            }
            conn.close();
            return false;
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * Cadastra um item da ordem de serviço
     */
    private boolean cadastrarItem(Connection conn, int idOrdem, ItemOrdemServico item) throws SQLException {
        Statement stmt = conn.createStatement();
        
        String sql = "INSERT INTO itens_ordem_servico " +
                "(id_ordem, id_produto, quantidade, valor_unitario, valor_total) " +
                "VALUES (" + idOrdem +
                ", " + item.getProduto().getIdProduto() +
                ", " + item.getQuantidade() +
                ", " + item.getValorUnitario() +
                ", " + item.getValorTotal() + ")";
        
        return stmt.executeUpdate(sql) > 0;
    }

    /**
     * Consulta todas as ordens de serviço
     */
    public List<OrdemServico> consulta_geral() throws ClassNotFoundException {
        List<OrdemServico> lista = new ArrayList<>();
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM ordem_servico ORDER BY data_abertura DESC";
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                OrdemServico ordem = construirOrdemDoBD(rs, conn);
                lista.add(ordem);
            }
            
            conn.close();
            return lista.isEmpty() ? null : lista;
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    /**
     * Consulta ordem de serviço por ID
     */
    public OrdemServico consultaPorId(int idOrdem) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM ordem_servico WHERE id_ordem = " + idOrdem;
            ResultSet rs = stmt.executeQuery(sql);
            
            OrdemServico ordem = null;
            if (rs.next()) {
                ordem = construirOrdemDoBD(rs, conn);
                // Carregar itens
                ordem.setItens(consultarItens(conn, idOrdem));
            }
            
            conn.close();
            return ordem;
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    /**
     * Consulta ordens de serviço por cliente
     */
    public List<OrdemServico> consultaPorCliente(int idCliente) throws ClassNotFoundException {
        List<OrdemServico> lista = new ArrayList<>();
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM ordem_servico WHERE id_cliente = " + idCliente + " ORDER BY data_abertura DESC";
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                OrdemServico ordem = construirOrdemDoBD(rs, conn);
                lista.add(ordem);
            }
            
            conn.close();
            return lista.isEmpty() ? null : lista;
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    /**
     * Consulta ordens de serviço por status
     */
    public List<OrdemServico> consultaPorStatus(String status) throws ClassNotFoundException {
        List<OrdemServico> lista = new ArrayList<>();
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM ordem_servico WHERE status_ordem = '" + status + "' ORDER BY data_abertura DESC";
            ResultSet rs = stmt.executeQuery(sql);
            
            while (rs.next()) {
                OrdemServico ordem = construirOrdemDoBD(rs, conn);
                lista.add(ordem);
            }
            
            conn.close();
            return lista.isEmpty() ? null : lista;
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    /**
     * Consulta itens de uma ordem de serviço
     */
    private List<ItemOrdemServico> consultarItens(Connection conn, int idOrdem) throws SQLException {
        List<ItemOrdemServico> itens = new ArrayList<>();
        Statement stmt = conn.createStatement();
        String sql = "SELECT ios.*, p.* FROM itens_ordem_servico ios " +
                "JOIN produtos p ON ios.id_produto = p.id_produto " +
                "WHERE ios.id_ordem = " + idOrdem;
        
        ResultSet rs = stmt.executeQuery(sql);
        
        while (rs.next()) {
            ItemOrdemServico item = new ItemOrdemServico();
            item.setIdItemOrdem(rs.getInt("id_item_ordem"));
            
            // Construir objeto Produto
            Produto produto = new Produto();
            produto.setIdProduto(rs.getInt("id_produto"));
            produto.setNomeProduto(rs.getString("nome_produto"));
            produto.setCodigoProduto(rs.getString("codigo_produto"));
            produto.setPrecoVenda(rs.getDouble("preco_venda"));
            item.setProduto(produto);
            
            item.setQuantidade(rs.getInt("quantidade"));
            item.setValorUnitario(rs.getDouble("valor_unitario"));
            item.setValorTotal(rs.getDouble("valor_total"));
            
            itens.add(item);
        }
        
        return itens;
    }

    /**
     * Atualiza uma ordem de serviço
     */
    public boolean alterar(OrdemServico ordem) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            
            String sql = "UPDATE ordem_servico SET " +
                    "status_ordem = '" + ordem.getStatusOrdem() + "', " +
                    "descricao_problema = '" + ordem.getDescricaoProblem() + "', " +
                    "solucao_tecnica = '" + (ordem.getSolucaoTecnica() != null ? ordem.getSolucaoTecnica() : "") + "', " +
                    "valor_total = " + ordem.getValorTotal() + ", " +
                    "garantia = '" + ordem.getGarantia() + "'";
            
            if (ordem.getDataFechamento() != null) {
                sql += ", data_fechamento = '" + sdf.format(ordem.getDataFechamento()) + "'";
            }
            
            sql += " WHERE id_ordem = " + ordem.getIdOrdem();
            
            stmt.executeUpdate(sql);
            System.out.println("Ordem de serviço alterada com sucesso!");
            
            conn.close();
            return true;
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * Muda o status de uma ordem de serviço
     */
    public boolean atualizarStatus(int idOrdem, String novoStatus) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            
            String sql = "UPDATE ordem_servico SET status_ordem = '" + novoStatus + "'";
            
            if ("Concluída".equals(novoStatus)) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                sql += ", data_fechamento = '" + sdf.format(new java.util.Date()) + "'";
            }
            
            sql += " WHERE id_ordem = " + idOrdem;
            
            stmt.executeUpdate(sql);
            System.out.println("Status atualizado com sucesso!");
            
            conn.close();
            return true;
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * Deleta uma ordem de serviço e seus itens
     */
    public boolean excluir(int idOrdem) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            
            // Deletar itens da ordem primeiro (constraint)
            Statement stmt = conn.createStatement();
            String sqlItens = "DELETE FROM itens_ordem_servico WHERE id_ordem = " + idOrdem;
            stmt.executeUpdate(sqlItens);
            
            // Deletar ordem
            stmt = conn.createStatement();
            String sqlOrdem = "DELETE FROM ordem_servico WHERE id_ordem = " + idOrdem;
            int resultado = stmt.executeUpdate(sqlOrdem);
            
            conn.close();
            
            if (resultado > 0) {
                System.out.println("Ordem de serviço excluída com sucesso!");
                return true;
            } else {
                return false;
            }
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    /**
     * Método auxiliar para construir uma OrdemServico a partir do ResultSet
     */
    private OrdemServico construirOrdemDoBD(ResultSet rs, Connection conn) throws SQLException, ClassNotFoundException {
        OrdemServico ordem = new OrdemServico();
        ordem.setIdOrdem(rs.getInt("id_ordem"));
        
        // Carregar cliente
        ClienteDAO clienteDAO = new ClienteDAO();
        Cliente cliente = clienteDAO.consultaPorId(rs.getInt("id_cliente"));
        ordem.setCliente(cliente);
        
        // Carregar funcionário
        FuncionarioDAO funcDAO = new FuncionarioDAO();
        Funcionario funcionario = funcDAO.consultaPorId(rs.getInt("id_funcionario"));
        ordem.setFuncionario(funcionario);
        
        ordem.setDataAbertura(rs.getTimestamp("data_abertura"));
        
        Timestamp dataFech = rs.getTimestamp("data_fechamento");
        if (dataFech != null) {
            ordem.setDataFechamento(new java.util.Date(dataFech.getTime()));
        }
        
        ordem.setStatusOrdem(rs.getString("status_ordem"));
        ordem.setDescricaoProblem(rs.getString("descricao_problema"));
        ordem.setSolucaoTecnica(rs.getString("solucao_tecnica"));
        ordem.setValorTotal(rs.getDouble("valor_total"));
        ordem.setGarantia(rs.getString("garantia"));
        
        // Carregar itens
        ordem.setItens(consultarItens(conn, rs.getInt("id_ordem")));
        
        return ordem;
    }

    /**
     * Retorna estatísticas das ordens de serviço
     */
    public int countPorStatus(String status) throws ClassNotFoundException {
        Connection conn = null;
        try {
            conn = ConectaDB.conectar();
            Statement stmt = conn.createStatement();
            String sql = "SELECT COUNT(*) as total FROM ordem_servico WHERE status_ordem = '" + status + "'";
            ResultSet rs = stmt.executeQuery(sql);
            
            if (rs.next()) {
                return rs.getInt("total");
            }
            
            conn.close();
            return 0;
            
        } catch (SQLException ex) {
            ex.printStackTrace();
            return 0;
        }
    }
}
