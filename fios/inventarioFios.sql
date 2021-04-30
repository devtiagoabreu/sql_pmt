SELECT
	FNC_Inv_Fios_Deposito.
	produto AS Fio, 
	descricao AS Descricao,
	FNC_Inv_Fios_Deposito.Cor,
	FNC_Inv_Fios_Deposito.Lote,
	FNC_Inv_Fios_Deposito.Gaveta,
	FNC_Inv_Fios_Deposito.Documento,
	Codigo_Caixa,
	Entrada_Caixa,
	Codigo_Caixa+Entrada_Caixa AS coletaCaixas,
	REPLACE(saldo, '.',',') AS SaldoPeso
FROM
	DBMicrodata.dbo.FNC_Inv_Fios_Deposito ('01', '2021-04-30')
WHERE
	produto IN ('FS1501','FS1503','FS1505','FS1507','FS1509','FS1511','FS1513','FS1515','FS1516','FS1517','FS1518','FS1519','F00207','FN1508','F00142')
	AND Gaveta  IN ('0003')
ORDER BY
	descricao,
	produto;
	
--CONSUMO DE URDUME
SELECT 
	--DBMicrodata.dbo.CTE_PECA.Produto,
	--DBMicrodata.dbo.CTE_PECA.Ficha_Tecnica,
	DBPromoda.dbo.vwTecidoGramaturaFioUrdume.Fio,
	DBPromoda.dbo.vwTecidoGramaturaFioUrdume.Fio_Descricao,
	replace(SUM(DBMicrodata.dbo.CTE_PECA.Metros),'.',',') AS Metros,
	replace(SUM(DBMicrodata.dbo.CTE_PECA.Peso),'.',',') AS Peso,
	replace(CAST((SUM(DBMicrodata.dbo.Cte_Peca.METROS)* DBPromoda.dbo.vwTecidoGramaturaFioUrdume.Gramatura) AS NUMERIC(15,2)),'.',',') AS Peso_Urdume	--DBMicrodata.dbo.CTE_PECA.Data_EntradaFROM
 DBMicrodata.dbo.CTE_PECA
 INNER JOIN DBPromoda.dbo.vwTecidoGramaturaFioUrdume ON DBPromoda.dbo.vwTecidoGramaturaFioUrdume.Ficha_Tecnica = DBMicrodata.dbo.CTE_PECA.FICHA_TECNICA
WHERE
	--DBMicrodata.dbo.CTE_PECA.Produto = @codProduto AND
	DBMicrodata.dbo.Cte_Peca.Nro_Rolo_Origem IS NULL AND   
	--DBPromoda.dbo.vwTecidoGramaturaFioUrdume.Fio = @codFio AND 
	DBMicrodata.dbo.CTE_PECA.Data_Entrada BETWEEN '20210301 00:00:00:00' AND '20210331 00:00:00:00' AND --'20181001 00:00:00:00' '20181031 00:00:00:000'
	DBMicrodata.dbo.Cte_Peca.Categoria_Tinto IN ('01', '02') AND
	DBMicrodata.dbo.CTE_PECA.Situacao = '000' AND
	DBMicrodata.dbo.CTE_PECA.Empresa = '01'
GROUP BY
	--DBMicrodata.dbo.CTE_PECA.Produto,
	--DBMicrodata.dbo.CTE_PECA.Ficha_Tecnica,
	--DBMicrodata.dbo.CTE_PECA.Data_Entrada,
	DBPromoda.dbo.vwTecidoGramaturaFioUrdume.Gramatura,
	DBPromoda.dbo.vwTecidoGramaturaFioUrdume.Fio,
	DBPromoda.dbo.vwTecidoGramaturaFioUrdume.Fio_Descricao
ORDER BY 
	--DBMicrodata.dbo.CTE_PECA.Ficha_Tecnica,
	DBPromoda.dbo.vwTecidoGramaturaFioUrdume.Fio;
	
--CONSUMO DE TRAMA
SELECT 
		--DBMicrodata.dbo.CTE_PECA.Produto,
		--DBMicrodata.dbo.CTE_PECA.Ficha_Tecnica,
		DBPromoda.dbo.vwTecidoGramaturaFioTrama.Fio,
		DBPromoda.dbo.vwTecidoGramaturaFioTrama.Fio_Descricao,
		replace(SUM(DBMicrodata.dbo.CTE_PECA.Metros),'.',',') AS Metros,
		replace(SUM(DBMicrodata.dbo.CTE_PECA.Peso),'.',',') AS Peso,
		replace(CAST((SUM(DBMicrodata.dbo.Cte_Peca.METROS)* DBPromoda.dbo.vwTecidoGramaturaFioTrama.Gramatura) AS NUMERIC(15,2)),'.',',') AS Peso_Trama
		--DBMicrodata.dbo.CTE_PECA.Data_Entrada
	FROM
	 DBMicrodata.dbo.CTE_PECA
	 INNER JOIN DBPromoda.dbo.vwTecidoGramaturaFioTrama ON DBPromoda.dbo.vwTecidoGramaturaFioTrama.Ficha_Tecnica = DBMicrodata.dbo.CTE_PECA.FICHA_TECNICA
	WHERE
		--DBMicrodata.dbo.CTE_PECA.Produto = @codProduto AND
		DBMicrodata.dbo.Cte_Peca.Nro_Rolo_Origem IS NULL AND   
		--DBPromoda.dbo.vwTecidoGramaturaFioTrama.Fio = @codFio AND 
		DBMicrodata.dbo.CTE_PECA.Data_Entrada  BETWEEN '20210401 00:00:00:00' AND '20210430 00:00:00:00' AND --'20181001 00:00:00:00' '20181031 00:00:00:000'
		DBMicrodata.dbo.Cte_Peca.Categoria_Tinto IN ('01', '02') AND
		DBMicrodata.dbo.CTE_PECA.Situacao = '000' AND
		DBMicrodata.dbo.CTE_PECA.Empresa = '01'
	GROUP BY
		--DBMicrodata.dbo.CTE_PECA.Produto,
		--DBMicrodata.dbo.CTE_PECA.Ficha_Tecnica,
		DBMicrodata.dbo.CTE_PECA.Data_Entrada,
		DBPromoda.dbo.vwTecidoGramaturaFioTrama.Gramatura,
		DBPromoda.dbo.vwTecidoGramaturaFioTrama.Fio,
		DBPromoda.dbo.vwTecidoGramaturaFioTrama.Fio_Descricao
	ORDER BY 
		--DBMicrodata.dbo.CTE_PECA.Ficha_Tecnica,
		DBPromoda.dbo.vwTecidoGramaturaFioTrama.Fio;