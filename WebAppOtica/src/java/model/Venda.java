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
public class Venda {
    private int idVenda;
    private int idCliente;
    private int idFuncionario;
    private Date dataVenda;
    private double valorTotal;
    private String formaPagamento;
    private int numeroParcelas;
    private double desconto;
    private String statusVenda;
    private String observacoes;

    public void setIdVenda(int v_id) {
        this.idVenda = v_id;
    }

    public void setIdCliente(int v_idCliente) {
        this.idCliente = v_idCliente;
    }

    public void setIdFuncionario(int v_idFuncionario) {
        this.idFuncionario = v_idFuncionario;
    }

    public void setDataVenda(Date v_data) {
        this.dataVenda = v_data;
    }

    public void setValorTotal(double v_total) {
        this.valorTotal = v_total;
    }

    public void setFormaPagamento(String v_forma) {
        this.formaPagamento = v_forma;
    }

    public void setNumeroParcelas(int v_parcelas) {
        this.numeroParcelas = v_parcelas;
    }

    public void setDesconto(double v_desconto) {
        this.desconto = v_desconto;
    }

    public void setStatusVenda(String v_status) {
        this.statusVenda = v_status;
    }

    public void setObservacoes(String v_obs) {
        this.observacoes = v_obs;
    }

    public int getIdVenda() {
        return this.idVenda;
    }

    public int getIdCliente() {
        return this.idCliente;
    }

    public int getIdFuncionario() {
        return this.idFuncionario;
    }

    public Date getDataVenda() {
        return this.dataVenda;
    }

    public double getValorTotal() {
        return this.valorTotal;
    }

    public String getFormaPagamento() {
        return this.formaPagamento;
    }

    public int getNumeroParcelas() {
        return this.numeroParcelas;
    }

    public double getDesconto() {
        return this.desconto;
    }

    public String getStatusVenda() {
        return this.statusVenda;
    }

    public String getObservacoes() {
        return this.observacoes;
    }
}
