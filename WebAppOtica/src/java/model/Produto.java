/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Notezin
 */
public class Produto {
    private int idProduto;
    private String codigoProduto;
    private String nomeProduto;
    private String marca;
    private String tipoProduto;
    private double precoCusto;
    private double precoVenda;
    private int quantidadeEstoque;
    private Date dataCadastro;
    private String situacao;

    public void setIdProduto(int p_id) {
        this.idProduto = p_id;
    }

    public void setCodigoProduto(String p_codigo) {
        this.codigoProduto = p_codigo;
    }

    public void setNomeProduto(String p_nome) {
        this.nomeProduto = p_nome;
    }

    public void setMarca(String p_marca) {
        this.marca = p_marca;
    }

    public void setTipoProduto(String p_tipo) {
        this.tipoProduto = p_tipo;
    }

    public void setPrecoCusto(double p_custo) {
        this.precoCusto = p_custo;
    }

    public void setPrecoVenda(double p_venda) {
        this.precoVenda = p_venda;
    }

    public void setQuantidadeEstoque(int p_estoque) {
        this.quantidadeEstoque = p_estoque;
    }

    public void setDataCadastro(Date p_data) {
        this.dataCadastro = p_data;
    }

    public void setSituacao(String p_situacao) {
        this.situacao = p_situacao;
    }

    public int getIdProduto() {
        return this.idProduto;
    }

    public String getCodigoProduto() {
        return this.codigoProduto;
    }

    public String getNomeProduto() {
        return this.nomeProduto;
    }

    public String getMarca() {
        return this.marca;
    }

    public String getTipoProduto() {
        return this.tipoProduto;
    }

    public double getPrecoCusto() {
        return this.precoCusto;
    }

    public double getPrecoVenda() {
        return this.precoVenda;
    }

    public int getQuantidadeEstoque() {
        return this.quantidadeEstoque;
    }

    public Date getDataCadastro() {
        return this.dataCadastro;
    }

    public String getSituacao() {
        return this.situacao;
    }
}
