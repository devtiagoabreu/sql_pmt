CREATE DATABASE IF NOT EXISTS prodash;
USE prodash;

DELIMITER //
CREATE DEFINER=root@localhost PROCEDURE uspNomeProcedureInserir(
	IN NomeCampo VARCHAR(20), 
	IN NomeCampo NUMERIC(18,5) 
	
)
BEGIN
   INSERT INTO nomeTabela
	(
		NomeCampo, 
		NomeCampo
	)
	VALUES 
	(
		NomeCampo, 
		NomeCampo
	);
END//
DELIMITER ;

