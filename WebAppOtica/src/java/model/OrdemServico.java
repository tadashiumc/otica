/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
import java.util.List;
import java.util.ArrayList;

public class OrdemServico {
    private int idOrdem;
    private Cliente cliente;
    private Funcionario funcionario;
    private Date dataAbertura;
    private Date dataFechamento;
    private String statusOrdem;
    private String descricaoProblem;
    private String solucaoTecnica;
    private double valorTotal;
    private String garantia;
    private List<ItemOrdemServico> itens;

    // Construtor padrão
    public OrdemServico() {
        this.itens = new ArrayList<>();
        this.dataAbertura = new Date();
    }

    // Construtor com parâmetros
    public OrdemServico(Cliente cliente, Funcionario funcionario, String statusOrdem, 
                        String descricaoProblem, String solucaoTecnica, 
                        double valorTotal, String garantia) {
        this();
        this.cliente = cliente;
        this.funcionario = funcionario;
        this.statusOrdem = statusOrdem;
        this.descricaoProblem = descricaoProblem;
        this.solucaoTecnica = solucaoTecnica;
        this.valorTotal = valorTotal;
        this.garantia = garantia;
    }

    // Método para adicionar item
    public void adicionarItem(ItemOrdemServico item) {
        if (this.itens == null) {
            this.itens = new ArrayList<>();
        }
        this.itens.add(item);
        this.valorTotal += item.getValorTotal();
    }

    // Método para calcular valor total
    public void calcularValorTotal() {
        this.valorTotal = 0.0;
        if (this.itens != null) {
            for (ItemOrdemServico item : this.itens) {
                this.valorTotal += item.getValorTotal();
            }
        }
    }

    // Getters e Setters
    public int getIdOrdem() {
        return idOrdem;
    }

    public void setIdOrdem(int idOrdem) {
        this.idOrdem = idOrdem;
    }

    public Cliente getCliente() {
        return cliente;
    }

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public Funcionario getFuncionario() {
        return funcionario;
    }

    public void setFuncionario(Funcionario funcionario) {
        this.funcionario = funcionario;
    }

    public Date getDataAbertura() {
        return dataAbertura;
    }

    public void setDataAbertura(Date dataAbertura) {
        this.dataAbertura = dataAbertura;
    }

    public Date getDataFechamento() {
        return dataFechamento;
    }

    public void setDataFechamento(Date dataFechamento) {
        this.dataFechamento = dataFechamento;
    }

    public String getStatusOrdem() {
        return statusOrdem;
    }

    public void setStatusOrdem(String statusOrdem) {
        this.statusOrdem = statusOrdem;
    }

    public String getDescricaoProblem() {
        return descricaoProblem;
    }

    public void setDescricaoProblem(String descricaoProblem) {
        this.descricaoProblem = descricaoProblem;
    }

    public String getSolucaoTecnica() {
        return solucaoTecnica;
    }

    public void setSolucaoTecnica(String solucaoTecnica) {
        this.solucaoTecnica = solucaoTecnica;
    }

    public double getValorTotal() {
        return valorTotal;
    }

    public void setValorTotal(double valorTotal) {
        this.valorTotal = valorTotal;
    }

    public String getGarantia() {
        return garantia;
    }

    public void setGarantia(String garantia) {
        this.garantia = garantia;
    }

    public List<ItemOrdemServico> getItens() {
        return itens;
    }

        public void setItens(List<ItemOrdemServico> itens) {
        this.itens = itens;
    }
}
