DROP DATABASE FUTEBOL;
CREATE DATABASE FUTEBOL;
USE FUTEBOL;

CREATE TABLE Treinador(
	ID INT NOT NULL AUTO_INCREMENT,
	Nome VARCHAR(50) NOT NULL,
	Salario DECIMAL(7,2),
	PRIMARY KEY (ID)
);

CREATE TABLE Campeonato (
	ID INT NOT NULL AUTO_INCREMENT,
	Nome VARCHAR(50) NOT NULL,
	Tipo CHAR,
	PRIMARY KEY (ID)
);

CREATE TABLE Time (
	ID INT NOT NULL AUTO_INCREMENT,
	Nome varchar(50) NOT NULL,
	ID_Treinador INT,
	ID_Campeonato INT,
	PRIMARY KEY (ID),
	FOREIGN KEY (ID_Treinador) REFERENCES Treinador(ID),
	FOREIGN KEY (ID_Campeonato) REFERENCES Campeonato(ID)
);

CREATE TABLE Jogador (
	ID INT NOT NULL AUTO_INCREMENT,
	Nome varchar(50) NOT NULL,
	Numero INT NOT NULL,
	Salario DECIMAL(7,2),
	Gols INT,
	ID_Time INT,
	PRIMARY KEY (ID),
	FOREIGN KEY (ID_Time) REFERENCES Time(ID)
);

CREATE TABLE Jogo (
	ID INT NOT NULL AUTO_INCREMENT,
	ID_TimeCasa INT NOT NULL,
	ID_TimeVisitante INT NOT NULL,
	PlacarTimeCasa INT NOT NULL,
	PlacarTimeVisitante INT NOT NULL,
	PRIMARY KEY (ID),
	FOREIGN KEY (ID_TimeCasa) REFERENCES Time(ID),
	FOREIGN KEY (ID_TimeVisitante) REFERENCES Time(ID)
);

/* Insere algumas informações. */
INSERT INTO Campeonato (Nome, Tipo) VALUES ('Brasileiro', 'N');
INSERT INTO Treinador (Nome, Salario) VALUES('Mano Menezes', '52525.78');
INSERT INTO Treinador (Nome, Salario) VALUES('Vanderlei Luxemburgo', '70525.78');
INSERT INTO Time (Nome, ID_Treinador, ID_Campeonato) VALUES('Corinthians', 1, 1);
INSERT INTO Time (Nome, ID_Treinador, ID_Campeonato) VALUES('Flamengo', 2, 1);
INSERT INTO Jogador (Nome, Numero, Salario, Gols, ID_Time) Values('Danilo Fernandes', 22, 40000.00, 0, 1);
INSERT INTO Jogador (Nome, Numero, Salario, Gols, ID_Time) Values('Walter', 23, 40000.00, 0, 1);
INSERT INTO Jogador (Nome, Numero, Salario, Gols, ID_Time) Values('Matheus Vidotto', 36, 40000.00, 0, 1);
INSERT INTO Jogador (Nome, Numero, Salario, Gols, ID_Time) Values('Gil', 4, 20000.00, 0, 1);
INSERT INTO Jogador (Nome, Numero, Salario, Gols, ID_Time) Values('Felipe', 1, 45000.00, 0, 2);
INSERT INTO Jogador (Nome, Numero, Salario, Gols, ID_Time) Values('Leonardo Moura', 2, 45000.00, 0, 2);

INSERT INTO Jogo (ID_TimeCasa, ID_TimeVisitante, PlacarTimeCasa, PlacarTimeVisitante) Values(1,2, 3,0);
INSERT INTO Jogo (ID_TimeCasa, ID_TimeVisitante, PlacarTimeCasa, PlacarTimeVisitante) Values(1,2, 2,2);
INSERT INTO Jogo (ID_TimeCasa, ID_TimeVisitante, PlacarTimeCasa, PlacarTimeVisitante) Values(1,2, 1,2);
INSERT INTO Jogo (ID_TimeCasa, ID_TimeVisitante, PlacarTimeCasa, PlacarTimeVisitante) Values(2,1, 1,2);



delimiter //
DROP FUNCTION IF EXISTS FUTEBOL.PtosTime//
CREATE FUNCTION PtosTime (TimeID INT)
RETURNS Integer
BEGIN
	DECLARE v_finished INTEGER DEFAULT 0;
	DECLARE Ptos INTEGER DEFAULT 0;
	DECLARE PlacarCasa Integer DEFAULT 0;
	DECLARE PlacarVisitante Integer DEFAULT 0;
    
    -- Declaração dos Cursores
	DECLARE JogosCasa_Cursor CURSOR FOR SELECT PlacarTimeCasa, PlacarTimeVisitante FROM Jogo WHERE ID_TimeCasa = TimeID;
	DECLARE JogosVisitante_Cursor CURSOR FOR SELECT PlacarTimeCasa, PlacarTimeVisitante FROM Jogo WHERE ID_TimeVisitante = TimeID;

	-- declara NOT FOUND handler
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
        
	-- Analise - Jogos em Casa
	OPEN JogosCasa_Cursor;
		getPlacarCasa: LOOP
			FETCH JogosCasa_Cursor INTO PlacarCasa, PlacarVisitante;
			
			-- Verificação - não retorna mais de 1 elemento
			IF v_finished = 1 THEN 
				LEAVE getPlacarCasa;
			END IF;

			-- Verificação - vitoria em casa
			IF PlacarCasa > PlacarVisitante THEN 
				SET Ptos = Ptos + 3;
			END IF;
            
			-- Verificação - empate em casa
			IF PlacarCasa = PlacarVisitante THEN 
				SET Ptos = Ptos + 1;
			END IF;
	 
		END LOOP getPlacarCasa;
	CLOSE JogosCasa_Cursor;
	
	-- reset do valor do flag
	SET v_finished = 0;
   
	-- Analise - Jogos como Visitante
	OPEN JogosVisitante_Cursor;
		getPlacaVisitante: LOOP
			FETCH JogosVisitante_Cursor INTO PlacarCasa, PlacarVisitante;
			
			-- Verificação - não retorna mais de 1 elemento
			IF v_finished = 1 THEN 
				LEAVE getPlacaVisitante;
			END IF;

			-- Verificação - vitoria como visitante
			IF PlacarVisitante > PlacarCasa THEN 
				SET Ptos = Ptos + 3;
			END IF;
            
			-- Verificação = empate como vivitante
			IF PlacarVisitante = PlacarCasa THEN 
				SET Ptos = Ptos + 1;
			END IF;
	 
		END LOOP getPlacaVisitante;
	   CLOSE JogosVisitante_Cursor;
	
   RETURN Ptos;
END//
delimiter ;

SELECT PtosTime(1);
