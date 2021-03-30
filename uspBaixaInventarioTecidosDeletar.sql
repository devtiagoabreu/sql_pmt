DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `uspBaixaInventarioTecidosDeletar`()
BEGIN
	TRUNCATE TABLE tblBaixaInventarioTecidos;
END//
DELIMITER ;