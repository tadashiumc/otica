/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Notezin
 */
public class ItemOrdemServico {
    private int idItemOrdem;
    private Produto produto;
    private int quantidade;
    private double valorUnitario;
    private double valorTotal;

    // Construtor padrão
    public ItemOrdemServico() {}

    // Construtor com parâmetros
    public ItemOrdemServico(Produto produto, int quantidade, double valorUnitario) {
        this.produto = produto;
        this.quantidade = quantidade;
        this.valorUnitario = valorUnitario;
        this.valorTotal = quantidade * valorUnitario;
    }

    // Getters e Setters
    public int getIdItemOrdem() {
        return idItemOrdem;
    }

    public void setIdItemOrdem(int idItemOrdem) {
        this.idItemOrdem = idItemOrdem;
    }

    public Produto getProduto() {
        return produto;
    }

    public void setProduto(Produto produto) {
        this.produto = produto;
    }

    public int getQuantidade() {
        return quantidade;
    }

    public void setQuantidade(int quantidade) {
        this.quantidade = quantidade;
        recalcularValorTotal();
    }

    public double getValorUnitario() {
        return valorUnitario;
    }

    public void setValorUnitario(double valorUnitario) {
        this.valorUnitario = valorUnitario;
        recalcularValorTotal();
    }

    public double getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(double valorTotal) {
        this.valorTotal = valorTotal;
    }

    // Método para recalcular valor total
    public void recalcularValorTotal() {
        this.valorTotal = this.quantidade * this.valorUnitario;
    }
}
