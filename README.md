# WebApp Ótica - Sistema de Gestão 🕶️

> Um sistema web completo de gestão para lojas de ótica, desenvolvido em Java/JSP com integração ao MySQL.

## 📋 Sumário

- [Visão Geral](#visão-geral)
- [Funcionalidades](#funcionalidades)
- [Tecnologias](#tecnologias)
- [Requisitos](#requisitos)
- [Instalação](#instalação)
- [Estrutura do Projeto](#estrutura-do-projeto)
- [Como Usar](#como-usar)
- [Banco de Dados](#banco-de-dados)
- [Autores](#autores)

## 🎯 Visão Geral

O **WebApp Ótica** é uma solução de software desenvolvida para fins acadêmicos que gerencia as operações de uma loja de ótica. O sistema oferece funcionalidades completas para cadastro e controle de clientes, funcionários, produtos, vendas e ordens de serviço.

**Versão:** 1.0  
**Status:** Em Desenvolvimento  
**Autor:** Notezin  
**Instituição:** Faculdade (Projeto Acadêmico)

## ✨ Funcionalidades

### 👥 Gestão de Clientes
- ✅ Cadastro de novos clientes
- ✅ Consulta de clientes (por ID ou nome)
- ✅ Alteração de dados de clientes
- ✅ Exclusão de registros
- ✅ Listagem completa com paginação

### 👔 Gestão de Funcionários
- ✅ Cadastro de novos funcionários
- ✅ Consulta e listagem de funcionários
- ✅ Alteração de informações
- ✅ Exclusão de registros
- ✅ Gerenciamento de perfis de acesso

### 📦 Gestão de Produtos
- ✅ Cadastro de produtos (óculos, lentes, acessórios)
- ✅ Controle de estoque em tempo real
- ✅ Consulta por nome ou código
- ✅ Alteração de preços e especificações
- ✅ Exclusão de produtos descontinuados
- ✅ Rastreamento de marca e tipo de produto

### 💰 Gestão de Vendas
- ✅ Carrinho de compras interativo
- ✅ Seleção múltipla de produtos
- ✅ Cálculo automático de totais
- ✅ Processamento de vendas
- ✅ Histórico de transações

### 🔧 Ordem de Serviço
- ✅ Criação de ordens de serviço técnicas
- ✅ Acompanhamento de serviços
- ✅ Consulta de ordens
- ✅ Edição de status
- ✅ Exclusão de registros

### 🔐 Sistema de Autenticação
- ✅ Login com usuário e senha
- ✅ Criptografia MD5 de senhas
- ✅ Controle de sessão
- ✅ Diferentes perfis de acesso (Admin, Vendedor, Técnico)
- ✅ Sistema de logout
- ✅ Cadastro de novos usuários

## 🛠️ Tecnologias

### Backend
- **Linguagem:** Java 24
- **Servidor:** Apache Tomcat 9.0+
- **Framework:** JSP (JavaServer Pages)
- **Banco de Dados:** MySQL 8.0+
- **Driver:** mysql-connector-java-8.0.30

### Frontend
- **HTML5**
- **CSS3**
- **JavaScript (Vanilla)**
- **Bootstrap 5.2.3**
- **Font Awesome 6.0.0**

### Ferramentas de Desenvolvimento
- **IDE:** NetBeans IDE
- **Build Tool:** Apache Ant
- **Versionamento:** Git

## 📋 Requisitos

### Requisitos de Sistema
- **Java:** JDK 24 ou superior
- **Tomcat:** 9.0 ou superior
- **MySQL:** 8.0 ou superior
- **RAM:** Mínimo 2GB
- **Espaço em Disco:** 500MB

### Dependências
- MySQL JDBC Driver 8.0.30
- Bootstrap 5.2.3 (CDN)
- Font Awesome 6.0.0 (CDN)

## 🚀 Instalação

### 1. Pré-requisitos
Certifique-se de ter instalado:
```bash
# Verificar versões
java -version
mysql --version
```

### 2. Clonar o Repositório
```bash
git clone https://github.com/tadashiumc/WebAppOtica.git
cd WebAppOtica/WebAppOtica/WebAppOtica
```

### 3. Criar Banco de Dados
```bash
# Conectar ao MySQL
mysql -u root -p

# Executar os scripts SQL
mysql> source setup/database_schema.sql;
```

### 4. Configurar Conexão com Banco de Dados
Editar o arquivo `src/java/config/ConectaDB.java`:

```java
public class ConectaDB {
    public static Connection conectar() throws ClassNotFoundException{
        Connection conn = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            // Alterar as credenciais conforme necessário
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/otica",
                "root",      // usuário MySQL
                ""           // senha MySQL
            );
        }
        catch(SQLException ex){
            System.out.println("Erro - SQL: " + ex);
        }
        return conn;
    }
}
```

### 5. Acessar a Aplicação
```
http://localhost:8080/WebAppOtica
```

## 📁 Estrutura do Projeto

```
WebAppOtica/
├── src/
│   └── java/
│       ├── model/
│       │   ├── Usuario.java
│       │   ├── Cliente.java
│       │   ├── Funcionario.java
│       │   ├── Produto.java
│       │   ├── Venda.java
│       │   ├── ItemVenda.java
│       │   ├── OrdemServico.java
│       │   ├── ItemOrdemServico.java
│       │   └── DAO/
│       │       ├── UsuarioDAO.java
│       │       ├── ClienteDAO.java
│       │       ├── FuncionarioDAO.java
│       │       ├── ProdutoDAO.java
│       │       ├── VendaDAO.java
│       │       ├── OrdemServicoDAO.java
│       │       └── (mais DAOs...)
│       └── config/
│           ├── ConectaDB.java
│           └── MD5Util.java
│
├── web/
│   ├── index.jsp                 # Página de login
│   ├── home.jsp                  # Dashboard principal
│   ├── logout.jsp                # Logout
│   │
│   ├── clientes.html             # Menu clientes
│   ├── clientecadastro/           # Cadastro de clientes
│   ├── clienteconsulta/           # Consulta de clientes
│   ├── clientealterar/            # Alteração de dados
│   ├── clienteapagar/             # Exclusão
│   │
│   ├── funcionarios.html          # Menu funcionários
│   ├── funccad/                   # Cadastro de funcionários
│   ├── funcconsult/               # Consulta de funcionários
│   ├── funcionarioalterar/        # Alteração
│   ├── funcionarioApagar/         # Exclusão
│   │
│   ├── produtos.html              # Menu produtos
│   ├── cadprod/                   # Cadastro de produtos
│   ├── produtoconsulta/           # Consulta de produtos
│   ├── produtoalterar/            # Alteração
│   ├── produtoapagar/             # Exclusão
│   │
│   ├── checkout.jsp               # Carrinho de compras / Vendas
│   ├── processarVenda.jsp         # Processamento de vendas
│   │
│   ├── ordemservico/              # Módulo de Ordem de Serviço
│   │   ├── ordem_servico.jsp
│   │   ├── consulta_ordem.jsp
│   │   ├── detalhe_ordem.jsp
│   │   ├── editar_ordem.jsp
│   │   └── excluir_ordem.jsp
│   │
│   └── META-INF/
│       └── context.xml
│
├── nbproject/                      # Configuração NetBeans
├── build/                          # Pasta de build
├── dist/                           # Distribuição (WAR)
├── build.xml                       # Configuração Ant
└── README.md                       # Este arquivo
```

### Descrição dos Diretórios Principais

| Diretório | Descrição |
|-----------|-----------|
| `src/java/model/` | Classes de modelo (entidades) |
| `src/java/model/DAO/` | Data Access Objects para operações com BD |
| `src/java/config/` | Configurações (conexão BD, utilitários) |
| `web/` | Arquivos JSP, HTML e recursos front-end |
| `nbproject/` | Metadados do NetBeans |

## 💻 Como Usar

### 1. Fazer Login
- Primeiramente crie o banco de dados e a tabela de usuarios.
- Acesse `http://localhost:8080/WebAppOtica`
- Va em criar conta, preencha os campos, após finalizar o cadastro o usuario e senha ja estão disponiveis para uso.

### 2. Navegar pelo Dashboard
Após o login, você terá acesso a:
- **Clientes:** Gerenciar base de clientes
- **Funcionários:** Gerenciar equipe
- **Produtos:** Controlar estoque
- **Vendas:** Realizar vendas e gerar pedidos
- **Ordem de Serviço:** Gerenciar atendimentos técnicos

### 3. Realizar uma Venda
```
1. Clique em "Vendas"
2. Selecione um cliente (se necessário criar novo)
3. Clique em "Novo Pedido"
4. Selecione produtos do estoque
5. Defina quantidades
6. Clique em "Adicionar ao Carrinho"
7. Revise o total
8. Clique em "Finalizar Venda"
```

### 4. Criar Nova Ordem de Serviço
```
1. Acesse "Ordem de Serviço" no dashboard
2. Clique em "Nova Ordem"
3. Preencha os dados do cliente e serviço
4. Defina prioridade e data estimada
5. Clique em "Salvar"
```

## 🗄️ Banco de Dados

Nomear como "otica"

### Schema Principal



#### Tabela: usuarios
```sql
CREATE TABLE usuarios (
  idUsuario INT PRIMARY KEY AUTO_INCREMENT,
  nomeUsuario VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  senha VARCHAR(255) NOT NULL,
  perfil VARCHAR(50) NOT NULL,
  status VARCHAR(20) DEFAULT 'ativo',
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

#### Tabela: clientes
```sql
CREATE TABLE clientes (
  idCliente INT PRIMARY KEY AUTO_INCREMENT,
  nomeCliente VARCHAR(100) NOT NULL,
  cpf VARCHAR(11) UNIQUE,
  email VARCHAR(100),
  telefone VARCHAR(15),
  endereco VARCHAR(255),
  cidade VARCHAR(100),
  estado VARCHAR(2),
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

#### Tabela: produtos
```sql
CREATE TABLE produtos (
  idProduto INT PRIMARY KEY AUTO_INCREMENT,
  codigoProduto VARCHAR(50) UNIQUE NOT NULL,
  nomeProduto VARCHAR(100) NOT NULL,
  marca VARCHAR(50),
  tipoProduto VARCHAR(50),
  precoCusto DECIMAL(10, 2),
  precoVenda DECIMAL(10, 2) NOT NULL,
  quantidadeEstoque INT DEFAULT 0,
  situacao VARCHAR(20) DEFAULT 'ativo',
  dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);
```

#### Tabela: vendas
```sql
CREATE TABLE vendas (
  idVenda INT PRIMARY KEY AUTO_INCREMENT,
  idCliente INT NOT NULL,
  dataVenda DATETIME DEFAULT CURRENT_TIMESTAMP,
  totalVenda DECIMAL(10, 2) NOT NULL,
  statusVenda VARCHAR(20) DEFAULT 'concluida',
  FOREIGN KEY (idCliente) REFERENCES clientes(idCliente)
);
```

#### Tabela: itemvendas
```sql
CREATE TABLE itemvendas (
  idItemVenda INT PRIMARY KEY AUTO_INCREMENT,
  idVenda INT NOT NULL,
  idProduto INT NOT NULL,
  quantidade INT NOT NULL,
  precoUnitario DECIMAL(10, 2),
  FOREIGN KEY (idVenda) REFERENCES vendas(idVenda),
  FOREIGN KEY (idProduto) REFERENCES produtos(idProduto)
);
```

## 🐛 Tratamento de Erros

O sistema inclui tratamento básico de erros:
- Validação de entrada
- Verificação de sessão
- Tratamento de exceções SQL
- Mensagens de erro amigáveis

Para melhorias futuras, considere implementar:
- Logging centralizado
- Tratamento mais robusta de exceções
- Página de erro customizada (error.jsp)

## 🔒 Segurança

### Implementações Atuais
- ✅ Hash MD5 para senhas
- ✅ Validação de sessão
- ✅ Redirect para login se não autenticado
- ✅ Proteção contra SQL Injection (parcial)


## 📄 Licença

Este projeto é fornecido como está para fins educacionais. Veja o arquivo LICENSE para mais detalhes.

## 🙏 Agradecimentos

- Equipe da Faculdade pelos ensinamentos
- Bootstrap pela excelente framework CSS
- Font Awesome pelos ícones
- Comunidade Java/JSP pelos recursos

## 📚 Referências Úteis

- [Documentação Java](https://docs.oracle.com/javase/)
- [JSP Documentation](https://projects.eclipse.org/projects/ee4j.jsp)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Bootstrap Documentation](https://getbootstrap.com/docs/)
- [NetBeans IDE](https://netbeans.apache.org/)

---

**Desenvolvido com ❤️ por Leticia, João Gonçalves, Kelvin e Tadashi**

*Projeto Acadêmico - WebApp Ótica v1.0*

