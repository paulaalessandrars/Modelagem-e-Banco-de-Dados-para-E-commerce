# 🛒 Projeto de Modelagem e Banco de Dados para E-commerce

## 📌 Descrição

Este projeto tem como objetivo a modelagem e implementação de um banco de dados relacional para um sistema de e-commerce. A proposta envolve a aplicação de conceitos de modelagem de dados, normalização, integridade referencial e consultas SQL para representar com precisão o funcionamento de uma loja virtual.

---

## 🎯 Objetivos

- Modelar entidades e relacionamentos típicos de um e-commerce.
- Aplicar chaves primárias, estrangeiras e constraints para garantir a integridade dos dados.
- Criar um script SQL completo para construção do banco de dados.
- Inserir dados de exemplo para simulações e testes.
- Desenvolver consultas SQL que representem situações reais do sistema.

---

## 📦 Entidades Modeladas

- **Cliente** (Pessoa Física e Jurídica)  
- **Produto**  
- **Fornecedor**  
- **Pedido**  
- **Pagamento**  
- **Entrega**

---

## 🔁 Relacionamentos e Regras de Negócio

- **Cliente x Pedido (1:N)** — Um cliente pode fazer vários pedidos.  
- **Pedido x Produto (N:M)** — Um pedido pode incluir diversos produtos e um produto pode estar presente em vários pedidos.  
- **Pedido x Pagamento (1:N)** — Um pedido pode ter mais de uma forma de pagamento.  
- **Pedido x Entrega (1:1)** — Cada pedido possui uma entrega correspondente.  
- **Produto x Fornecedor (N:1)** — Um fornecedor pode fornecer diversos produtos.

---

## 🧩 Modelagem Visual

📷 **Diagrama Entidade-Relacionamento (ERD):**  
![Diagrama ERD](https://i.imgur.com/3AfeQcf.png)

📷 **Modelo Relacional:**  
👉 [Visualizar modelo relacional](COLE_AQUI_O_LINK_DO_MODELO_RELACIONAL)  
<sub>*Substitua o link acima por um URL público (Imgur, Google Drive, etc.)*</sub>

📷 **Exemplo de Relacionamento entre Tabelas:**  
![Relacionamento entre tabelas](https://i.imgur.com/DRZGdVU.png)

---

## 📁 Estrutura do Projeto

- `modelagem/`: diagramas ER e modelo relacional  
- `scripts/`: criação de tabelas e inserção de dados  
- `consultas/`: conjunto de queries SQL desenvolvidas

---

## 🔎 Consultas SQL Desenvolvidas

- Total de pedidos por cliente  
- Relação de produtos e seus fornecedores  
- Status de entregas por pedido  
- Métodos de pagamento utilizados por cada cliente

📷 **Exemplo de consulta SQL:**  
![Consulta SQL](https://i.imgur.com/pkZHKSK.png)

---

## ✅ Resultados

- Modelo relacional completo, representando as principais operações de um e-commerce.  
- Aplicação prática de normalização, integridade referencial e modelagem de relacionamentos complexos.  
- Estrutura pronta para implementação em sistemas baseados em MySQL.

---

## 📚 Recursos Recomendados

- [MySQL Workbench](https://www.mysql.com/products/workbench/)  
- [Documentação MySQL](https://dev.mysql.com/doc/)  
- [Guia de Modelagem de Dados – Lucidchart](https://www.lucidchart.com/pages/pt/modelagem-de-dados)

---

## 🚀 Próximos Passos

Este modelo pode ser facilmente adaptado a sistemas reais de e-commerce. Utilize-o como base para novos projetos ou como estrutura inicial para implementação em ambientes de produção.

