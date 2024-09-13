DROP DATABASE COMERCIO;
CREATE DATABASE COMERCIO;

USE COMERCIO;

CREATE TABLE Produto(
    Cod_Prod INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(50) UNIQUE,
	Valor DECIMAL(5,2),
    Estoque INT NOT NULL DEFAULT 0
);
 
INSERT INTO Produto VALUES (NULL, 'Feijão', 5.00, 10);
INSERT INTO Produto VALUES (NULL, 'Arroz', 10.50, 5);
INSERT INTO Produto VALUES (NULL, 'Farinha', 20.49, 15);

CREATE TABLE Cliente(
    Cod_Cli INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50),
    CPF BIGINT NOT NULL UNIQUE
);
 
CREATE TABLE Pedido(   
    Venda INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Cod_Prod INT,
    Cod_Cli INT,
	Quantidade INT,
	ValorTotal DECIMAL(5,2),
	FOREIGN KEY (Cod_Prod) REFERENCES Produto(Cod_Prod),
	FOREIGN KEY (Cod_Cli) REFERENCES Cliente(Cod_Cli)
);

INSERT INTO Cliente VALUES (NULL, 'João', 11111111111);
INSERT INTO Cliente VALUES (NULL, 'Maria', 22222222222);

INSERT INTO Pedido VALUES (NULL, 1, 1, 5, NULL);
INSERT INTO Pedido VALUES (NULL, 1, 1, 2, NULL);

#Retorna os produtos sem seu valor
CREATE VIEW visualiza_produtos AS
SELECT cod_prod, descricao AS Produto, estoque
FROM Produto;

#Retorna todos os pedidos dos clientes
CREATE VIEW pedidos_clientes AS
SELECT cli.nome, cli.cpf, prod.descricao as Produto, prod.valor as "Valor Unitario", ped.quantidade
FROM cliente AS cli
INNER JOIN pedido AS ped ON (cli.cod_cli = ped.cod_cli)
INNER JOIN produto AS prod ON (ped.cod_prod = prod.cod_prod);

SELECT * FROM visualiza_produtos;
SELECT * FROM pedidos_clientes;