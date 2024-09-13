DROP DATABASE hospital;
CREATE DATABASE hospital;
USE hospital;

CREATE TABLE paciente(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    data_nascimento DATE NOT NULL,
    telefone VARCHAR(13) NOT NULL
);

CREATE TABLE consulta(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    sintomas VARCHAR(100) NOT NULL,
    remedio VARCHAR(100) NOT NULL,
    data_consulta DATE NOT NULL,
    observacoes VARCHAR(50),
    status_consulta ENUM('Finalizada', 'Pendente') NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente(id)
);

INSERT INTO paciente(nome, cpf, data_nascimento, telefone) VALUES
('João Vitor', '145.673.852-17', '2004-04-22', '64 96357-1458'),
('Maria Clara', '254.687.945-30', '1990-11-15', '64 98765-4321'),
('Pedro Henrique', '365.894.176-98', '1985-06-01', '64 91234-5678'),
('Ana Paula', '478.901.237-46', '1975-09-12', '64 92345-6789'),
('Lucas Gabriel', '589.012.348-57', '1999-02-28', '64 93456-7890'),
('Mariana Silva', '690.123.459-68', '2003-07-14', '64 94567-8901'),
('Felipe Alves', '701.234.560-79', '1980-01-05', '64 95678-9012'),
('Camila Santos', '812.345.671-80', '1995-03-22', '64 96789-0123'),
('Guilherme Costa', '923.456.782-91', '2002-08-19', '64 97890-1234'),
('Isabela Oliveira', '034.567.893-02', '1997-12-05', '64 98901-2345');

INSERT INTO consulta(id_paciente, sintomas, remedio, data_consulta, status_consulta, observacoes) VALUES
(1, 'Febre, Dor de Cabeça e Vômito', 'Dipirona', '2024-08-10', 'Finalizada', NULL),
(2, 'Dor de Garganta e Tosse', 'Amoxicilina', '2024-08-12', 'Pendente', 'Beber bastante água'),
(3, 'Dores Abdominais', 'Buscopan', '2024-08-14', 'Pendente', NULL),
(4, 'Cansaço e Falta de Ar', 'Inalação', '2024-08-15', 'Pendente', 'Verificar histórico de asma'),
(5, 'Erupção Cutânea e Coceira', 'Antialérgico', '2024-08-16', 'Finalizada', NULL),
(6, 'Dor no Peito', 'AAS', '2024-08-18', 'Pendente', 'Recomendar ECG'),
(7, 'Náusea e Tontura', 'Plasil', '2024-08-19', 'Pendente', NULL),
(8, 'Inchaço nos Pés', 'Diurético', '2024-08-21', 'Finalizada', 'Investigar insuficiência cardíaca'),
(9, 'Infecção Urinária', 'Ciprofloxacina', '2024-08-23', 'Finalizada', 'Recomendar ingestão de líquidos'),
(10, 'Dores nas Articulações', 'Ibuprofeno', '2024-08-24', 'Pendente', NULL);

#Retorna todos os pacientes que estão com a consulta Pendente
CREATE VIEW paciente_observacao AS
SELECT pac.id, pac.nome, pac.cpf, con.observacoes, con.data_consulta, con.status_consulta
FROM consulta AS con
INNER JOIN paciente AS pac ON (con.id_paciente = pac.id)
WHERE con.status_consulta = 'Pendente';

#Vai selecionar os dados pedidos antes de inserir novos dados.
SELECT * FROM consulta;
SELECT * FROM paciente_observacao;