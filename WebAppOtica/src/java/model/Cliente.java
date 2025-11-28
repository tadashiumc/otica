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
public class Cliente {
    private int idCliente;
    private String nomeCompleto;
    private String cpf;
    private Date dataNascimento;
    private String email;
    private String telefone;
    private String endereco;
    private String cidade;
    private String estado;
    private String observacoes;

    public void setIdCliente(int c_id) {
        this.idCliente = c_id;
    }

    public void setNomeCompleto(String c_nome) {
        this.nomeCompleto = c_nome;
    }

    public void setCpf(String c_cpf) {
        this.cpf = c_cpf;
    }

    public void setDataNascimento(Date c_nasc) {
        this.dataNascimento = c_nasc;
    }

    public void setEmail(String c_email) {
        this.email = c_email;
    }

    public void setTelefone(String c_tel) {
        this.telefone = c_tel;
    }

    public void setEndereco(String c_end) {
        this.endereco = c_end;
    }

    public void setCidade(String c_cid) {
        this.cidade = c_cid;
    }

    public void setEstado(String c_est) {
        this.estado = c_est;
    }

    public void setObservacoes(String c_obs) {
        this.observacoes = c_obs;
    }

    public int getIdCliente() {
        return this.idCliente;
    }

    public String getNomeCompleto() {
        return this.nomeCompleto;
    }

    public String getCpf() {
        return this.cpf;
    }

    public Date getDataNascimento() {
        return this.dataNascimento;
    }

    public String getEmail() {
        return this.email;
    }

    public String getTelefone() {
        return this.telefone;
    }

    public String getEndereco() {
        return this.endereco;
    }

    public String getCidade() {
        return this.cidade;
    }

    public String getEstado() {
        return this.estado;
    }

    public String getObservacoes() {
        return this.observacoes;
    }
    
    
    
}
