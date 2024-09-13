#1. Crie uma transação que executa uma leitura de dados e uma atualização de dados
START TRANSACTION;
	SELECT nome FROM materia WHERE id = 1 FOR UPDATE; 
	UPDATE materia SET nome = "Programação Orientada a Objetos" WHERE id = 1;
COMMIT;


#2. Crie uma transação que executa uma inserção de dados, porém executa um roolback ao final
START TRANSACTION;
	SELECT nome FROM materia WHERE id = 1 FOR UPDATE; 
	INSERT INTO materia(nome, carga_horaria, total_aulas) VALUES ("Banco de dados", 66, 66);
ROLLBACK;


#3. Crie uma transação que utilize um savepoint e um roolback para o mesmo.
START TRANSACTION;
	UPDATE materia SET nome = "Projeto de Banco de Dados" WHERE id = 2;
	SAVEPOINT update_materia;
    
	INSERT INTO materia(nome, carga_horaria, total_aulas) VALUES ("Lógica de Programação", 62, 62);
	ROLLBACK TO update_materia;
COMMIT;


#4. Crie uma transação que utilize LOCK em uma tabela
START TRANSACTION;
LOCK TABLES materia WRITE;

	UPDATE materia SET carga_horaria = 63 WHERE id = 6;

COMMIT;
UNLOCK TABLES;


