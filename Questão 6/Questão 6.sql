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


#Função que calcula o valor de todos os produtos
delimiter //
DROP FUNCTION IF EXISTS COMERCIO.CalculaPedidos//
CREATE FUNCTION CalculaPedidos()
RETURNS DECIMAL(10,2)
BEGIN
	DECLARE v_finished INTEGER DEFAULT 0;
	DECLARE ValorTotal DECIMAL(10,2) DEFAULT 0;
	DECLARE QuantidadeProduto INTEGER DEFAULT 0;
	DECLARE valorUnitario DECIMAL(10,2) DEFAULT 0;
    
    -- Declaração dos Cursores
	DECLARE calculoTotal CURSOR FOR
		SELECT ped.quantidade AS quantidade, prod.valor AS valor
        FROM Pedido AS ped
        INNER JOIN produto AS prod ON (ped.cod_prod = prod.cod_prod);
        
        -- declara NOT FOUND handler
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
        
	-- Calcula o valor
	OPEN calculoTotal;
		getValorPedidos: LOOP
			FETCH calculoTotal INTO QuantidadeProduto, valorUnitario;
		
			IF v_finished = 1 THEN 
				LEAVE getValorPedidos;
			END IF;
			
			SET ValorTotal = ValorTotal + (QuantidadeProduto * valorUnitario);
        END LOOP getValorPedidos;
	CLOSE calculoTotal;
   RETURN ValorTotal;
END//
delimiter ;

INSERT INTO Pedido VALUES (NULL, 1, 1, 3, NULL);