--VERIFICAR PECAS EM ESTOQUE QUE NÃO ESTÃO NA COLETA E QUE FAZEM PARTE DE UMA LISTA DE PRODUTOS
--SINTETICO
SELECT
	CP.Produto,
	CP.Situacao,
	CP.Cor,
	CP.Desenho,
	CP.Variante,
	CP.Categoria,
	CP.Categoria_Tinto,
	REPLACE(SUM(ISNULL(CP.Metros,0)),'.',',') AS Metros
FROM 
	DBMicrodata.dbo.Cte_Peca CP
	LEFT JOIN DBMicrodata.dbo.CTE_Baixa CB ON CP.Empresa=CB.Empresa AND CP.Situacao=CB.Situacao AND CP.Nro_Rolo=CB.Nro_Rolo AND CP.Nro_Peca=CB.Nro_Peca
WHERE 
	CP.Empresa LIKE '01' AND 
	CP.Nro_Rolo+CP.Nro_Peca NOT IN (SELECT coleta.peca FROM DBPromoda.dbo.coleta)  AND 
	Produto IN (SELECT lista.item FROM DBPromoda.dbo.lista) AND  
	CB.Data_Saida IS NULL
GROUP BY
	CP.Produto,
	CP.Situacao,
	CP.Cor,
	CP.Desenho,
	CP.Variante,
	CP.Categoria,
	CP.Categoria_Tinto
ORDER BY 
	CP.Produto,
	CP.Situacao,
	CP.Cor,
	CP.Desenho,
	CP.Variante,
	CP.Categoria,
	CP.Categoria_Tinto
	
--VERIFICAR PECAS EM ESTOQUE QUE NÃO ESTÃO NA COLETA E QUE FAZEM PARTE DE UMA LISTA DE PRODUTOS
--ANALITICO	
SELECT
	CP.Nro_Rolo,
	CP.Nro_Peca,
	CP.Produto,
	CP.Situacao,
	CP.Cor,
	CP.Desenho,
	CP.Variante,
	CP.Categoria,
	CP.Categoria_Tinto,
	REPLACE(ISNULL(CP.Metros,0),'.',',') AS Metros
FROM 
	DBMicrodata.dbo.Cte_Peca CP
	LEFT JOIN DBMicrodata.dbo.CTE_Baixa CB ON CP.Empresa=CB.Empresa AND CP.Situacao=CB.Situacao AND CP.Nro_Rolo=CB.Nro_Rolo AND CP.Nro_Peca=CB.Nro_Peca
WHERE 
	CP.Empresa LIKE '01' AND 
	CP.Nro_Rolo+CP.Nro_Peca NOT IN (SELECT coleta.peca FROM DBPromoda.dbo.coleta)  AND 
	Produto IN (SELECT lista.item FROM DBPromoda.dbo.lista) AND 
	CB.Data_Saida IS NULL
ORDER BY 
	CP.Produto,
	CP.Situacao,
	CP.Cor,
	CP.Desenho,
	CP.Variante,
	CP.Categoria,
	CP.Categoria_Tinto
	
--COLETA DE PECAS EM ESTOQUE
--SINTETICO	
SELECT
	CP.Produto,
	CP.Situacao,
	CP.Cor,
	CP.Desenho,
	CP.Variante,
	CP.Categoria,
	CP.Categoria_Tinto,
	REPLACE(SUM(ISNULL(CP.Metros,0)),'.',',') AS Metros 
FROM 
	DBMicrodata.dbo.Cte_Peca CP
	LEFT JOIN DBMicrodata.dbo.CTE_Baixa CB ON CP.Empresa=CB.Empresa AND CP.Situacao=CB.Situacao AND CP.Nro_Rolo=CB.Nro_Rolo AND CP.Nro_Peca=CB.Nro_Peca
WHERE 
	CP.Empresa LIKE '01' AND 
	CP.Nro_Rolo+CP.Nro_Peca IN (SELECT coleta.peca FROM DBPromoda.dbo.coleta)  AND 
	CB.Data_Saida IS NULL
GROUP BY
	CP.Produto,
	CP.Situacao,
	CP.Cor,
	CP.Desenho,
	CP.Variante,
	CP.Categoria,
	CP.Categoria_Tinto
ORDER BY 
	CP.Produto,
	CP.Situacao,
	CP.Cor,
	CP.Desenho,
	CP.Variante,
	CP.Categoria,
	CP.Categoria_Tinto
	
--COLETA DE PECAS EM ESTOQUE
--ANALITICO	
SELECT
	CP.Nro_Rolo,
	CP.Nro_Peca,
	CP.Produto,
	CP.Situacao,
	CP.Cor,
	CP.Desenho,
	CP.Variante,
	CP.Categoria,
	CP.Categoria_Tinto,
	REPLACE(ISNULL(CP.Metros,0),'.',',') AS Metros 
FROM 
	DBMicrodata.dbo.Cte_Peca CP
	LEFT JOIN DBMicrodata.dbo.CTE_Baixa CB ON CP.Empresa=CB.Empresa AND CP.Situacao=CB.Situacao AND CP.Nro_Rolo=CB.Nro_Rolo AND CP.Nro_Peca=CB.Nro_Peca
WHERE 
	CP.Empresa LIKE '01' AND 
	CP.Nro_Rolo+CP.Nro_Peca IN (SELECT coleta.peca FROM DBPromoda.dbo.coleta)  AND 
	CB.Data_Saida IS NULL
ORDER BY 
	CP.Produto,
	CP.Situacao,
	CP.Cor,
	CP.Desenho,
	CP.Variante,
	CP.Categoria,
	CP.Categoria_Tinto
	

