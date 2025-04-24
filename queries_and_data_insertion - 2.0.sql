-- Seleciona o banco de dados "ecommerce" para ser utilizado nas próximas queries
USE Ecommercev2;

-- Exibe todas as tabelas existentes no banco de dados selecionado
SHOW TABLES;

-- Inserção de dados na tabela Clients (clientes)
-- Campos: Fname (nome), Minit (inicial do meio), Lname (sobrenome), CPF, Address (endereço)
INSERT INTO Clients (Fname, Minit, Lname, CPF, Address) 
VALUES
  ('Maria', 'M', 'Silva', '12346789', 'Rua Silva de Prata 29, Carangola - Cidade das Flores'),
  ('Matheus', 'O', 'Pimentel', '987654321', 'Rua Alameda 289, Centro - Cidade das Flores'),
  ('Ricardo', 'F', 'Silva', '45678913', 'Avenida Alameda Vinha 1009, Centro - Cidade das Flores'),
  ('Julia', 'S', 'França', '789123456', 'Rua Lareijras 861, Centro - Cidade das Flores'),
  ('Roberta', 'G', 'Assis', '98745631', 'Avenida Koller 19, Centro - Cidade das Flores'),
  ('Isabela', 'M', 'Cruz', '654789123', 'Rua Alameda das Flores 28, Centro - Cidade das Flores');

-- Verifica os dados inseridos para o cliente com CPF '12346789'
SELECT * FROM Clients WHERE CPF = '12346789';

SELECT * FROM clients c ORDER BY c.Fname ASC;




-- Inserção de dados na tabela de produtos
-- Campos: Pname (nome do produto), classification_kids (infantil?), category, evaluation (nota), size (tamanho)
INSERT INTO product (Pname, classification_kids, category, evaluation, size) 
VALUES
  ('Fone de ouvido', false, 'Eletrônicos', 4, NULL),
  ('Barbie Elsa', true, 'Brinquedos', 3, NULL),
  ('Body Carters', true, 'Roupas', 5, NULL),
  ('Microfone Vedo - Youtuber', false, 'Eletrônicos', 4, NULL),
  ('Sofá retrátil', false, 'Móveis', 3, '3x57x80'),
  ('Farinha de arroz', false, 'Alimentos', 2, NULL),
  ('Fire Stick Amazon', false, 'Eletrônicos', 3, NULL);

-- Exibe todos os produtos cadastrados
SELECT * FROM product;

select * from product p order by p.Pname asc;




-- Remover pedidos de clientes com id de 1 a 4
-- DELETE FROM orders WHERE idOrderClient IN (1, 2, 3, 4);

-- Inserir novos pedidos na tabela Orders
-- Campos: idOrderClient (cliente), orderStatus (status), orderDescription, shipping (frete), paymentCash (1 = à vista)
INSERT INTO orders (idOrderClient, orderStatus, orderDescription, shipping, paymentCash) 
VALUES 
  (1, DEFAULT, 'compra via aplicativo', NULL, 1),
  (2, DEFAULT, 'compra via aplicativo', 50, 0),
  (3, 'Enviado', NULL, NULL, 1),
  (4, DEFAULT, 'compra via website', 150, 0);

-- Mostra todos os pedidos existentes
SELECT * FROM orders;




-- Inserção de itens nos pedidos
-- Campos: idPOproduct (produto), idPOorder (pedido), poQuantity (quantidade), poStatus (status do item)
INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poStatus) 
VALUES
  (1, 2, 2, 'Disponível'),
  (2, 3, 1, 'Disponível'),
  (3, 4, 1, 'Disponível');

select * from productOrder;




-- Insere quantidades de produtos nos estoques por localidade
INSERT INTO productStorage (storageLocation, quantity) 
VALUES 
  ('Rio de Janeiro', 1000),
  ('Rio de Janeiro', 500),
  ('São Paulo', 10),
  ('São Paulo', 100),
  ('São Paulo', 10),
  ('Brasília', 60);

select * from productStorage order by storageLocation ASC; 




-- Relaciona produtos com locais de armazenamento
-- Campos: idLproduct (produto), idLstorage (local), location (resumo do local)
INSERT INTO storageLocation (idLproduct, idLstorage, location) 
VALUES
  (1, 2, 'RJ'),
  (2, 6, 'GO');

select * from storagelocation s order by s.location ASC;




-- Insere fornecedores
-- Campos: SocialName (nome), CNPJ, contact (contato)
INSERT INTO supplier (SocialName, CNPJ, contact) 
VALUES 
  ('Almeida e Filhos', '123456789123456', '21985474'),
  ('Eletrônicos Silva', '854519649143457', '21985484'),
  ('Eletrônicos Valma', '934567893934695', '21975474');

-- Exibe todos os fornecedores cadastrados
SELECT * FROM supplier;




-- Relaciona fornecedores com produtos
-- Campos: idPsSupplier (fornecedor), idPsProduct (produto), prodQuantity (quantidade)
INSERT INTO productSupplier (idPsSupplier, idPsProduct, prodQuantity) 
VALUES
  (1, 1, 500),
  (1, 2, 400),
  (2, 4, 633),
  (3, 3, 5),
  (2, 5, 10);

SELECT * FROM productSupplier;




-- Insere vendedores
-- Campos: SocialName, AbstName (nome abreviado), CNPJ, CPF, location, contact
INSERT INTO seller (SocialName, AbstName, CNPJ, CPF, location, contact) 
VALUES 
  ('Tech Electronics', NULL, '123456789456321', NULL, 'Rio de Janeiro', '219946287'),
  ('Botique Durgas', NULL, NULL, '123456783', 'Rio de Janeiro', '219567895'),
  ('Kids World', NULL, '456789123654485', NULL, 'São Paulo', '1198657484');

-- Exibe todos os vendedores cadastrados
SELECT * FROM seller order by socialName ASC;




-- Remove relacionamentos de produtos com vendedores com base em condição específica
-- DELETE FROM productSeller
-- WHERE 
--  (idPSELProduct = 1 AND idPELSeller = 3 AND prodQuantity = 80) OR
--  (idPSELProduct = 2 AND idPELSeller = 2 AND prodQuantity = 10) OR
--  (idPSELProduct = 3 AND idPELSeller = 1 AND prodQuantity = 70) OR
--  (idPSELProduct = 1 AND idPELSeller = 1 AND prodQuantity = 80);

-- Relaciona produtos com vendedores
INSERT INTO productSeller (idPSELProduct, idPELSeller, prodQuantity) 
VALUES 
  (1, 3, 80),
  (2, 2, 10),
  (3, 1, 70);

-- Mostra os relacionamentos entre vendedores e produtos
SELECT * FROM productSeller;




-- Conta o número total de clientes cadastrados
SELECT COUNT(*) FROM Clients;


-- Relaciona clientes com seus pedidos
SELECT * FROM Clients c, Orders o WHERE c.idClient = o.idOrderClient;


-- Mostra nome e sobrenome dos clientes com status dos pedidos
SELECT Fname, Lname, idOrder, orderStatus 
FROM Clients c, Orders o 
WHERE c.idClient = o.idOrderClient;


-- Exibe nome completo, ID do pedido e status
SELECT CONCAT(Fname, ' ', Lname) AS Client, idOrder AS Request, orderStatus AS Status 
FROM Clients c, Orders o 
WHERE c.idClient = o.idOrderClient;


-- Insere mais um pedido para o cliente de ID 2
INSERT INTO Orders (idOrderClient, orderStatus, orderDescription, shipping, paymentCash) 
VALUES (2, DEFAULT, 'compra via aplicativo', NULL, 1);


-- Conta total de pedidos realizados por todos os clientes
SELECT COUNT(*) 
FROM Clients c, Orders o 
WHERE c.idClient = o.idOrderClient;


-- Exibe todos os pedidos
SELECT * FROM Orders;


-- Mostra clientes com seus pedidos e produtos associados
SELECT 
  c.idClient,
  c.Fname,
  GROUP_CONCAT(DISTINCT o.idOrder ORDER BY o.idOrder) AS pedidos,
  GROUP_CONCAT(DISTINCT p.idPOproduct ORDER BY p.idPOproduct) AS produtos
FROM Clients c
INNER JOIN Orders o ON c.idClient = o.idOrderClient
INNER JOIN productOrder p ON p.idPOorder = o.idOrder
GROUP BY c.idClient, c.Fname;


-- Clientes que fizeram mais de um pedido
SELECT c.idClient, Fname, COUNT(*) AS Number_of_orders 
FROM Clients c 
INNER JOIN Orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient
HAVING COUNT(*) > 1;




-- --------

-- Quantos pedidos foram feitos por cada cliente?
SELECT c.idClient, Fname, COUNT(*) AS Number_of_orders 
FROM Clients c 
INNER JOIN Orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient;


-- Algum vendedor também é fornecedor?
SELECT s.SocialName AS Seller_Name, f.SocialName AS Supplier_Name
FROM seller s
JOIN supplier f ON s.CNPJ = f.CNPJ;


-- Relação de produtos fornecedores e estoques
SELECT 
  p.Pname AS Product_Name, 
  s.SocialName AS Supplier_Name, 
  ps.prodQuantity AS Supplier_Quantity,
  sl.location AS Storage_Location, 
  ps2.quantity AS Storage_Quantity
FROM product p
JOIN productSupplier ps ON p.idProduct = ps.idPSProduct
JOIN supplier s ON ps.idPSSupplier = s.idSupplier
JOIN storageLocation sl ON p.idProduct = sl.idLProduct
JOIN productStorage ps2 ON sl.idLStorage = ps2.idProdStorage;




-- Relação de nomes dos fornecedores e nomes dos produtos
SELECT 
  f.SocialName AS Supplier_Name, 
  p.Pname AS Product_Name
FROM product p
JOIN productSupplier ps ON p.idProduct = ps.idPSProduct
JOIN supplier f ON ps.idPSSupplier = f.idSupplier;




