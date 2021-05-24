CREATE DATABASE IF NOT EXISTS prodash;
USE prodash;

CREATE TABLE SaldoFacionista (
	Empresa varchar(2) NULL,
	Facionista varchar(20) NULL,
	Razao_Nome_Cliente varchar(255) NULL,
	Produto varchar(10) NULL,
	Descricao varchar(255) NULL,
	Cor varchar(5) NULL,
	Desc_Cor varchar(255) NULL,
	Saldo_Peso DECIMAL(10,4) NULL,
	Saldo_Valor DECIMAL(10,4) NULL
);

DELIMITER //
CREATE DEFINER=root@localhost PROCEDURE uspSaldoFacionistaInserir(
	
    IN Empresa varchar(2),
	IN Facionista varchar(20),
	IN Razao_Nome_Cliente varchar(255),
	IN Produto varchar(10),
	IN Descricao varchar(255),
	IN Cor varchar(5),
	IN Desc_Cor varchar(255),
	IN Saldo_Peso DECIMAL(10,4),
	IN Saldo_Valor DECIMAL(10,4) 
	
)
BEGIN
   INSERT INTO nomeTabela
	(
		Empresa,
        Facionista,
        Razao_Nome_Cliente,
        Produto,
        Descricao,
        Cor,
        Desc_Cor,
        Saldo_Peso,
        Saldo_Valor 
	)
	VALUES 
	(
		Empresa,
        Facionista,
        Razao_Nome_Cliente,
        Produto,
        Descricao,
        Cor,
        Desc_Cor,
        Saldo_Peso,
        Saldo_Valor 
	);
END//
DELIMITER;

DELIMITER //
CREATE DEFINER=root@localhost PROCEDURE uspSaldoFacionistaDeletar()
BEGIN
	TRUNCATE TABLE SaldoFacionista;
END//
DELIMITER;