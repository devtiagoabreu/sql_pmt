DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `uspRegistroInventarioTecidosDeletar`()
BEGIN
	TRUNCATE TABLE tblRegistroInventarioTecidos;
END//
DELIMITER ;