-- ===========================================
-- CRIAÇÃO DO BANCO DE DADOS E SELEÇÃO
-- ===========================================

-- Cria o banco de dados chamado Ecommerce
CREATE DATABASE Ecommercev2;

-- DROP DATABASE ecommercev2;

show tables;

-- Seleciona o banco Ecommerce para uso
USE Ecommercev2;

-- ===========================================
-- TABELA DE CLIENTES
-- ===========================================

-- Armazena informações dos clientes do e-commerce
CREATE TABLE Clients (
    idClient INT AUTO_INCREMENT PRIMARY KEY,   -- Identificador único do cliente
    Fname VARCHAR(10) NOT NULL,                -- Primeiro nome
    Minit VARCHAR(3),                          -- Inicial do nome do meio (opcional)
    Lname VARCHAR(20) NOT NULL,                -- Sobrenome
    CPF CHAR(11),                              -- CPF (formato fixo de 11 caracteres) (para PF)
    CNPJ CHAR(14),                             -- CNPJ (formato fixo de 14 caracteres) (para PJ)
    Address VARCHAR(255),                      -- Endereço (opcional)
    ClientType ENUM('PF', 'PJ') NOT NULL,      -- Tipo de cliente (Pessoa Física ou Jurídica)
    CONSTRAINT Unique_cpf_client UNIQUE (CPF), -- Garante CPF único por cliente (só para PF)
    CONSTRAINT Unique_cnpj_client UNIQUE (CNPJ) -- Garante CNPJ único por cliente (só para PJ)
);

alter table Clients auto_increment=1;





-- O ORDER BY é usado quando você deseja ordenar os resultados de uma consulta com base em uma ou mais colunas (por exemplo, ordenar por idOrder, name, etc.).
SELECT * FROM Clients ORDER BY Fname;

-- ===========================================
-- TABELA DE PRODUTOS
-- ===========================================

-- Armazena informações dos produtos disponíveis
CREATE TABLE Product (
    idProduct INT AUTO_INCREMENT PRIMARY KEY,   -- Identificador único do produto
    Pname VARCHAR(50) NOT NULL,                 -- Nome do produto
    classification_kids BOOL DEFAULT FALSE,     -- Indica se o produto é para crianças
    category ENUM('Eletrônicos', 'Roupas', 'Brinquedos', 'Alimentos', 'Livros', 'Móveis') NOT NULL, -- Categoria do produto
    evaluation FLOAT DEFAULT 0,                 -- Avaliação do produto
    size VARCHAR(10)                            -- Tamanho (quando aplicável)
);

alter table Product auto_increment=1;






-- ===========================================
-- TABELA DE PEDIDOS
-- ===========================================

-- Armazena informações dos pedidos feitos pelos clientes
CREATE TABLE Orders (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,       -- Identificador único do pedido
    idOrderClient INT NOT NULL,                    -- Referência ao cliente que fez o pedido
    orderStatus ENUM('Cancelado', 'Em processamento', 'Enviado', 'Entregue') NOT NULL DEFAULT 'Em processamento', -- Status do pedido
    orderDescription VARCHAR(255),                 -- Descrição do pedido
    shipping FLOAT DEFAULT 10,                     -- Valor do frete
    paymentCash BOOL DEFAULT FALSE,                -- Indica se o pagamento foi à vista
    typePayment ENUM('Boleto', 'Cartão', 'Dois cartões', 'Pix') DEFAULT 'Boleto', -- Tipo de pagamento utilizado
    trackingCode VARCHAR(50),                      -- Código de rastreio (para status 'Enviado' ou 'Entregue')
    deliveryStatus ENUM('Pendente', 'Em trânsito', 'Entregue', 'Falhado') DEFAULT 'Pendente', -- Status da entrega
    -- Relação com a tabela de clientes
    CONSTRAINT FK_orders_client FOREIGN KEY (idOrderClient) REFERENCES Clients(idClient) ON UPDATE CASCADE
);

alter table Orders auto_increment=1;






-- ===========================================
-- TABELA DE PAGAMENTOS
-- ===========================================

-- Armazena os pagamentos realizados pelos clientes
CREATE TABLE Payments (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,    -- Identificador único do pagamento
    idClient INT NOT NULL,                        -- Referência ao cliente que pagou
    idOrder INT NOT NULL,                         -- Referência ao pedido pago
    typePayment ENUM('Boleto', 'Cartão', 'Dois cartões', 'Pix') NOT NULL DEFAULT 'Boleto', -- Tipo de pagamento
    limitAvailable FLOAT,                         -- Limite disponível do cliente (cartão, por exemplo)
    paymentAmount FLOAT NOT NULL,                 -- Valor pago
    paymentDate DATETIME DEFAULT CURRENT_TIMESTAMP, -- Data e hora do pagamento
    status ENUM('Pendente', 'Pago', 'Falhou', 'Reembolsado') DEFAULT 'Pendente', -- Status do pagamento
    
    -- Relações com as tabelas Clients e Orders
    CONSTRAINT FK_payment_client FOREIGN KEY (idClient) REFERENCES Clients(idClient),
    CONSTRAINT FK_payment_order FOREIGN KEY (idOrder) REFERENCES Orders(idOrder)
);







-- ===========================================
-- TABELA DE ESTOQUE
-- ===========================================

-- Armazena o local e a quantidade de produtos em estoque
CREATE TABLE productStorage (
    idProdStorage INT AUTO_INCREMENT PRIMARY KEY NOT NULL, -- ID do registro no estoque
    storageLocation VARCHAR(255) NOT NULL,                 -- Localização do estoque
    quantity INT DEFAULT 0                                 -- Quantidade disponível
);

alter table ProductStorage auto_increment=1;






-- ===========================================
-- TABELA DE FORNECEDORES
-- ===========================================

-- Armazena informações dos fornecedores
CREATE TABLE Supplier (
    idSupplier INT AUTO_INCREMENT PRIMARY KEY,    -- Identificador único do fornecedor
    socialName VARCHAR(255) NOT NULL,              -- Razão social
    CNPJ VARCHAR(15) NOT NULL,                     -- CNPJ
    contact VARCHAR(11) NOT NULL,                  -- Telefone de contato
    CONSTRAINT Unique_supplier UNIQUE (CNPJ)       -- Garante CNPJ único
);

alter table Supplier auto_increment=1;







-- ===========================================
-- TABELA DE VENDEDORES
-- ===========================================

-- Armazena informações dos vendedores da plataforma
CREATE TABLE Seller (
    idSeller INT AUTO_INCREMENT PRIMARY KEY,      -- Identificador único do vendedor
    socialName VARCHAR(255) NOT NULL,              -- Razão social
    AbstName VARCHAR(255),                         -- Nome Fantasia
    CNPJ VARCHAR(15),                              -- CNPJ
    CPF CHAR(11),                                  -- CPF (formato fixo de 11 caracteres)
    contact VARCHAR(11) NOT NULL,                  -- Telefone de contato
    location VARCHAR(255),                         -- Localização
    CONSTRAINT Unique_cnpj_Seller UNIQUE (CNPJ),   -- Garante CNPJ único
    CONSTRAINT Unique_cpf_Seller UNIQUE (CPF),     -- Garante CPF único
    CONSTRAINT Unique_socialName_Seller UNIQUE (socialName) -- Garante Razão social única
);

alter table Seller auto_increment=1;









-- =============================================================================================================================================================================================================================================================
-- ======================================================================================================================TABELAS DE RELAÇÃO ====================================================================================================================
-- =============================================================================================================================================================================================================================================================





-- ===========================================
-- TABELA DE RELAÇÃO ENTRE PRODUTO E FORNECEDOR
-- ===========================================

-- Essa tabela serve para representar uma relação muitos-para-muitos:
-- - Um produto pode ter vários fornecedores
-- - Um fornecedor pode fornecer vários produtos

CREATE TABLE productSupplier (
    idPSProduct INT NOT NULL,                      -- FK para Product
    idPSSupplier INT NOT NULL,                     -- FK para Supplier
    prodQuantity INT DEFAULT 1,                     -- Quantidade do produto no pedido
    PRIMARY KEY (idPSProduct, idPSSupplier),       -- Chave composta
    CONSTRAINT fk_productSupplier_product FOREIGN KEY (idPSProduct) REFERENCES Product(idProduct),
    CONSTRAINT fk_productSupplier_supplier FOREIGN KEY (idPSSupplier) REFERENCES Supplier(idSupplier)
);





-- ===========================================
-- TABELA DE RELAÇÃO ENTRE PRODUTO E VENDEDOR
-- ===========================================

-- Essa tabela representa uma relação muitos-para-muitos:
-- - Um produto pode ser vendido por vários vendedores
-- - Um vendedor pode vender vários produtos

CREATE TABLE productSeller  (
    idPSELProduct INT NOT NULL,                    -- FK para Product
    idPELSeller INT NOT NULL,                      -- FK para Seller
    prodQuantity INT DEFAULT 1,                     -- Quantidade do produto no pedido
    PRIMARY KEY (idPSELProduct, idPELSeller),      -- Chave composta
    CONSTRAINT fk_productSeller_product FOREIGN KEY (idPSELProduct) REFERENCES Product(idProduct),
    CONSTRAINT fk_productSeller_seller FOREIGN KEY (idPELSeller) REFERENCES Seller(idSeller)
);

-- DROP TABLE Product_Seller;








-- ===========================================
-- TABELA DE RELAÇÃO ENTRE PRODUTO E PEDIDO
-- ===========================================

-- Essa tabela representa uma relação muitos-para-muitos:
-- - Um produto pode estar em vários pedidos
-- - Um pedido pode conter vários produtos

CREATE TABLE productOrder (
    idPOproduct INT NOT NULL,                     -- FK para Product
    idPOorder INT NOT NULL,                       -- FK para Orders
    poQuantity INT DEFAULT 1,                     -- Quantidade do produto no pedido
    poStatus ENUM ('Disponível', 'Sem estoque') DEFAULT 'Disponível', -- Preço do produto no momento da compra
    PRIMARY KEY (idPOproduct, idPOorder),         -- Chave composta
    CONSTRAINT fk_productOrder_product FOREIGN KEY (idPOproduct) REFERENCES Product(idProduct),
    CONSTRAINT fk_productOrder_order FOREIGN KEY (idPOorder) REFERENCES Orders(idOrder)
);

-- DROP TABLE Product_Order;





-- ===========================================
-- TABELA DE RELAÇÃO ENTRE PRODUTO E LOCAL DE ESTOQUE
-- ===========================================

-- Essa tabela representa uma relação muitos-para-muitos entre produtos e locais de estoque

CREATE TABLE storageLocation (
    idLProduct INT NOT NULL,                      -- Referência ao produto
    idLStorage INT NOT NULL,                      -- Referência ao local de armazenamento (ProductStorage)
    location VARCHAR(255) NOT NULL,               -- Quantidade do produto nesse local
    PRIMARY KEY (idLProduct, idLStorage),         -- Chave composta para garantir unicidade do par
    CONSTRAINT fk_storageLocation_product FOREIGN KEY (idLProduct) REFERENCES Product(idProduct),
    CONSTRAINT fk_storageLocation_storage FOREIGN KEY (idLStorage) REFERENCES ProductStorage(idProdStorage)
);

-- DROP TABLE Storage_Location;
