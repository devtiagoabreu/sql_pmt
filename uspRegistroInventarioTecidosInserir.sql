DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `uspRegistroInventarioTecidosInserir`
(
	IN `ProdutoCodigo` VARCHAR(20), 
	IN `ProdutoDescricao` VARCHAR(255),
	IN `NumeroRolo` VARCHAR(20),
	IN `NumeroPeca` VARCHAR(3),
	IN `Situacao` VARCHAR(10),
	IN `Cor` VARCHAR(10),
	IN `CorDescricao` VARCHAR(60),
	IN `Desenho` VARCHAR(10),
	IN `Variante` VARCHAR(10),
	IN `Categoria` VARCHAR(5),
	IN `Metros` NUMERIC(18,5), 
	IN `Peso` NUMERIC(18,5), 
	IN `CustoMetro` NUMERIC(18,5), 
	IN `CustoMetroOutros` NUMERIC(18,5), 
	IN `CustoTotal` NUMERIC(18,5)
)
BEGIN
   INSERT INTO tblRegistroInventarioTecidos 
	(
		ProdutoCodigo, 
		ProdutoDescricao, 
		NumeroRolo, 
		NumeroPeca, 
		Situacao, 
		Cor, 
		CorDescricao, 
		Desenho, 
		Variante, 
		Categoria, 
		Metros, 
		Peso, 
		CustoMetro, 
		CustoMetroOutros, 
		CustoTotal
	)
	VALUES 
	(
		ProdutoCodigo, 
		ProdutoDescricao, 
		NumeroRolo, 
		NumeroPeca, 
		Situacao, 
		Cor, 
		CorDescricao, 
		Desenho, 
		Variante, 
		Categoria, 
		Metros, 
		Peso, 
		CustoMetro, 
		CustoMetroOutros, 
		CustoTotal
	);
END//
DELIMITER ;