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
public class Funcionario {
    private int idFuncionario;
    private String nomeCompleto;
    private String cpf;
    private Date dataNascimento;
    private String email;
    private String telefone;
    private String cargo;
    private Date dataAdmissao;
    private double salario;
    private String status;

    public void setIdFuncionario(int f_id) {
        this.idFuncionario = f_id;
    }

    public void setNomeCompleto(String f_nome) {
        this.nomeCompleto = f_nome;
    }

    public void setCpf(String f_cpf) {
        this.cpf = f_cpf;
    }

    public void setDataNascimento(Date f_nasc) {
        this.dataNascimento = f_nasc;
    }

    public void setEmail(String f_email) {
        this.email = f_email;
    }

    public void setTelefone(String f_tel) {
        this.telefone = f_tel;
    }

    public void setCargo(String f_cargo) {
        this.cargo = f_cargo;
    }

    public void setDataAdmissao(Date f_admissao) {
        this.dataAdmissao = f_admissao;
    }

    public void setSalario(double f_salario) {
        this.salario = f_salario;
    }

    public void setStatus(String f_status) {
        this.status = f_status;
    }

    public int getIdFuncionario() {
        return this.idFuncionario;
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

    public String getCargo() {
        return this.cargo;
    }

    public Date getDataAdmissao() {
        return this.dataAdmissao;
    }

    public double getSalario() {
        return this.salario;
    }

    public String getStatus() {
        return this.status;
    }
}
