USE [DBPromoda]
GO
/****** Object:  StoredProcedure [dbo].[uspRegistroInventarioTecidos]    Script Date: 03/30/2021 07:38:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[uspRegistroInventarioTecidos]
@tipoRetorno char(2),
@numeroRolo varchar(20),
@numeroPeca varchar(3),
@produtoCodigo varchar(20),
@situacao varchar(10),
@cor varchar(10),
@desenho varchar(10),
@variante varchar(10), 
@categoria varchar(5), 
@dataInicial varchar(30),
@dataFinal varchar(30)    
AS   

BEGIN

--ESTOQUE SINTETICO SIMPLES
IF (@tipoRetorno = 'SS')
BEGIN
	SELECT
		CP.Produto AS ProdutoCodigo,
		Produtos.Descricao AS ProdutoDescricao,
		CP.Situacao,
		CP.Cor,
		Car_Cores.Descricao AS CorDescricao,
		CP.Desenho,
		CP.Variante,
		CP.Categoria_Tinto AS Categoria,
		SUM(ISNULL(CP.Metros,0)) AS Metros,
		SUM(ISNULL(CP.Peso,0)) AS Peso
	FROM 
		DBMicrodata.dbo.Cte_Peca CP 
		LEFT JOIN DBMicrodata.dbo.CTE_Baixa CB ON CP.Empresa=CB.Empresa and CP.Situacao=CB.Situacao and CP.Nro_Rolo=CB.Nro_Rolo and CP.Nro_Peca=CB.Nro_Peca
		INNER JOIN DBMicrodata.dbo.Produtos ON Produtos.Codigo = CP.Produto
		INNER JOIN DBMicrodata.dbo.Produtos_Tecidos ON Produtos_Tecidos.Produto = CP.Produto
		INNER JOIN DBMicrodata.dbo.Car_Cores ON Car_Cores.Codigo = CP.Cor
	WHERE 
		CP.Empresa like '01' AND 
		CP.Situacao like '%'+@situacao+'%' AND 
		CP.Nro_Rolo like '%' AND 
		CP.Nro_Peca like '%' AND 
		CP.Produto like '%'+@produtoCodigo+'%' AND 
		Cor like '%'+@cor+'%' AND 
		Desenho like '%'+@desenho+'%' AND 
		Categoria_Tinto Like '%'+@categoria+'%' AND 
		IsNull(Variante, '') Like '%'+@variante+'%' AND
		CB.Data_Saida IS NULL
	GROUP BY
		CP.Produto,
		Produtos.Descricao,
		CP.Situacao,
		CP.Cor,
		Car_Cores.Descricao,
		CP.Desenho,
		CP.Variante,
		CP.Categoria_Tinto
	ORDER BY
		CP.Produto,
		CP.Situacao,
		CP.Cor,
		CP.Desenho,
		CP.Variante,
		CP.Categoria_Tinto
END

--ESTOQUE SINTETICO/CUSTO
IF (@tipoRetorno = 'SC')
BEGIN
	SELECT
		CP.Produto AS ProdutoCodigo,
		Produtos.Descricao AS ProdutoDescricao,
		CP.Situacao,
		CP.Cor,
		Car_Cores.Descricao AS CorDescricao,
		CP.Desenho,
		CP.Variante,
		CP.Categoria_Tinto AS Categoria,
		SUM(ISNULL(CP.Metros,0)) AS Metros,
		SUM(ISNULL(CP.Peso,0)) AS Peso,
		ISNULL((CASE   
			WHEN CP.Situacao = '000' THEN Produtos_Tecidos.Custo_Cru
			WHEN CP.Situacao = '001' THEN Produtos_Tecidos.Custo_Remessa
			WHEN CP.Situacao = '002' THEN Produtos_Tecidos.Custo_Estampado
			WHEN CP.Situacao = '009' THEN Produtos_Tecidos.Custo_Estampado
			ELSE '0'	
		END),0) AS CustoMetro,
		ISNULL(Produtos_Tecidos.Custo_Outros, 0) AS CustoMetroOutros,
		ISNULL((CASE   
			WHEN CP.Situacao = '000' THEN Produtos_Tecidos.Custo_Cru
			WHEN CP.Situacao = '001' THEN Produtos_Tecidos.Custo_Remessa
			WHEN CP.Situacao = '002' THEN Produtos_Tecidos.Custo_Estampado
			WHEN CP.Situacao = '009' THEN Produtos_Tecidos.Custo_Estampado
			ELSE '0'	
		END),0) * SUM(ISNULL(CP.Metros,0)) AS CustoTotal
	FROM 
		DBMicrodata.dbo.Cte_Peca CP 
		LEFT JOIN DBMicrodata.dbo.CTE_Baixa CB ON CP.Empresa=CB.Empresa and CP.Situacao=CB.Situacao and CP.Nro_Rolo=CB.Nro_Rolo and CP.Nro_Peca=CB.Nro_Peca
		INNER JOIN DBMicrodata.dbo.Produtos ON Produtos.Codigo = CP.Produto
		INNER JOIN DBMicrodata.dbo.Produtos_Tecidos ON Produtos_Tecidos.Produto = CP.Produto
		INNER JOIN DBMicrodata.dbo.Car_Cores ON Car_Cores.Codigo = CP.Cor
	WHERE 
		CP.Empresa like '01' AND 
		CP.Situacao like '%'+@situacao+'%' AND 
		CP.Nro_Rolo like '%' AND 
		CP.Nro_Peca like '%' AND 
		CP.Produto like '%'+@produtoCodigo+'%' AND 
		Cor like '%'+@cor+'%' AND 
		Desenho like '%'+@desenho+'%' AND 
		Categoria_Tinto Like '%'+@categoria+'%' AND 
		IsNull(Variante, '') Like '%'+@variante+'%' AND
		CB.Data_Saida IS NULL
	GROUP BY
		CP.Produto,
		Produtos.Descricao,
		CP.Situacao,
		CP.Cor,
		Car_Cores.Descricao,
		CP.Desenho,
		CP.Variante,
		CP.Categoria_Tinto,
		Produtos_Tecidos.Custo_Cru,
		Produtos_Tecidos.Custo_Remessa,
		Produtos_Tecidos.Custo_Estampado,
		Produtos_Tecidos.Custo_Estampado,
		Produtos_Tecidos.Custo_Outros
	ORDER BY
		CP.Produto,
		CP.Situacao,
		CP.Cor,
		CP.Desenho,
		CP.Variante,
		CP.Categoria_Tinto
END

--ESTOQUE ANALITICO/CUSTO
IF (@tipoRetorno = 'AC')
BEGIN
	SELECT
		CP.Produto AS ProdutoCodigo,
		Produtos.Descricao AS ProdutoDescricao,
		CP.Nro_Rolo AS NumeroRolo,
		CP.Nro_Peca AS NumeroPeca,
		CP.Situacao,
		CP.Cor,
		Car_Cores.Descricao AS CorDescricao,
		CP.Desenho,
		CP.Variante,
		CP.Categoria_Tinto AS Categoria,
		ISNULL(CP.Metros,0) AS Metros,
		ISNULL(CP.Peso,0) AS Peso,
		ISNULL((CASE   
			WHEN CP.Situacao = '000' THEN Produtos_Tecidos.Custo_Cru
			WHEN CP.Situacao = '001' THEN Produtos_Tecidos.Custo_Remessa
			WHEN CP.Situacao = '002' THEN Produtos_Tecidos.Custo_Estampado
			WHEN CP.Situacao = '009' THEN Produtos_Tecidos.Custo_Estampado
			ELSE '0'	
		END),0) AS CustoMetro,
		ISNULL(Produtos_Tecidos.Custo_Outros, 0) AS CustoMetroOutros
	FROM 
		DBMicrodata.dbo.Cte_Peca CP 
		LEFT JOIN DBMicrodata.dbo.CTE_Baixa CB ON CP.Empresa=CB.Empresa and CP.Situacao=CB.Situacao and CP.Nro_Rolo=CB.Nro_Rolo and CP.Nro_Peca=CB.Nro_Peca
		INNER JOIN DBMicrodata.dbo.Produtos ON Produtos.Codigo = CP.Produto
		INNER JOIN DBMicrodata.dbo.Produtos_Tecidos ON Produtos_Tecidos.Produto = CP.Produto
		INNER JOIN DBMicrodata.dbo.Car_Cores ON Car_Cores.Codigo = CP.Cor
	WHERE 
		CP.Empresa like '01' AND 
		CP.Situacao like '%'+@situacao+'%' AND 
		CP.Nro_Rolo like '%'+@numeroRolo+'%' AND 
		CP.Nro_Peca like '%'+@numeroPeca+'%' AND 
		CP.Produto like '%'+@produtoCodigo+'%' AND 
		Cor like '%'+@cor+'%' AND 
		Desenho like '%'+@desenho+'%' AND 
		Categoria_Tinto Like '%'+@categoria+'%' AND 
		IsNull(Variante, '') Like '%'+@variante+'%' AND
		CB.Data_Saida IS NULL
	ORDER BY
		CP.Produto,
		CP.Situacao,
		CP.Cor,
		CP.Desenho,
		CP.Variante,
		CP.Categoria_Tinto

END

-- BAIXA POR INVENTARIO SINTETICO
IF (@tipoRetorno = 'IS')
BEGIN
	SELECT
		CP.Produto AS ProdutoCodigo,
		Produtos.Descricao AS ProdutoDescricao,
		CP.Situacao,
		CP.Cor,
		Car_Cores.Descricao AS CorDescricao,
		CP.Desenho,
		CP.Variante,
		CP.Categoria_Tinto AS Categoria,
		SUM(ISNULL(CP.Metros,0)) AS Metros,
		SUM(ISNULL(CP.Peso,0)) AS Peso
	FROM 
		DBMicrodata.dbo.Cte_Peca CP 
		LEFT JOIN DBMicrodata.dbo.CTE_Baixa CB ON CP.Empresa=CB.Empresa and CP.Situacao=CB.Situacao and CP.Nro_Rolo=CB.Nro_Rolo and CP.Nro_Peca=CB.Nro_Peca
		INNER JOIN DBMicrodata.dbo.Produtos ON Produtos.Codigo = CP.Produto
		INNER JOIN DBMicrodata.dbo.Produtos_Tecidos ON Produtos_Tecidos.Produto = CP.Produto
		INNER JOIN DBMicrodata.dbo.Car_Cores ON Car_Cores.Codigo = CP.Cor
	WHERE 
		CP.Empresa like '01' AND 
		CP.Situacao like '%'+@situacao+'%' AND 
		CP.Nro_Rolo like '%' AND 
		CP.Nro_Peca like '%' AND 
		CP.Produto like '%'+@produtoCodigo+'%' AND 
		Cor like '%'+@cor+'%' AND 
		Desenho like '%'+@desenho+'%' AND 
		Categoria_Tinto Like '%'+@categoria+'%' AND 
		IsNull(Variante, '') Like '%'+@variante+'%' AND
		CB.Observacao LIKE 'Baixa por Inventário%' AND
		CB.Corte_Altera = 'I' AND
		CB.Data_Saida BETWEEN @dataInicial AND @dataFinal
	GROUP BY
		CP.Produto,
		Produtos.Descricao,
		CP.Situacao,
		CP.Cor,
		Car_Cores.Descricao,
		CP.Desenho,
		CP.Variante,
		CP.Categoria_Tinto,
		CB.Observacao ,
		CB.Corte_Altera,
		CB.Data_Saida 
	ORDER BY
		CP.Produto,
		CP.Situacao,
		CP.Cor,
		CP.Desenho,
		CP.Variante,
		CP.Categoria_Tinto

END

-- BAIXA POR INVENTARIO ANALITICO
IF (@tipoRetorno = 'IA')
BEGIN
	SELECT
		CP.Produto AS ProdutoCodigo,
		Produtos.Descricao AS ProdutoDescricao,
		CP.Situacao,
		CP.Cor,
		Car_Cores.Descricao AS CorDescricao,
		CP.Desenho,
		CP.Variante,
		CP.Categoria_Tinto AS Categoria,
		ISNULL(CP.Metros,0) AS Metros,
		ISNULL(CP.Peso,0) AS Peso
	FROM 
		DBMicrodata.dbo.Cte_Peca CP 
		LEFT JOIN DBMicrodata.dbo.CTE_Baixa CB ON CP.Empresa=CB.Empresa and CP.Situacao=CB.Situacao and CP.Nro_Rolo=CB.Nro_Rolo and CP.Nro_Peca=CB.Nro_Peca
		INNER JOIN DBMicrodata.dbo.Produtos ON Produtos.Codigo = CP.Produto
		INNER JOIN DBMicrodata.dbo.Produtos_Tecidos ON Produtos_Tecidos.Produto = CP.Produto
		INNER JOIN DBMicrodata.dbo.Car_Cores ON Car_Cores.Codigo = CP.Cor
	WHERE 
		CP.Empresa like '01' AND 
		CP.Situacao like '%'+@situacao+'%' AND 
		CP.Nro_Rolo like '%'+@numeroRolo+'%' AND 
		CP.Nro_Peca like '%'+@numeroPeca+'%' AND  
		CP.Produto like '%'+@produtoCodigo+'%' AND 
		Cor like '%'+@cor+'%' AND 
		Desenho like '%'+@desenho+'%' AND 
		Categoria_Tinto Like '%'+@categoria+'%' AND 
		IsNull(Variante, '') Like '%'+@variante+'%' AND
		CB.Observacao LIKE 'Baixa por Inventário%' AND
		CB.Corte_Altera = 'I' AND
		CB.Data_Saida BETWEEN @dataInicial AND @dataFinal
	ORDER BY
		CP.Produto,
		CP.Situacao,
		CP.Cor,
		CP.Desenho,
		CP.Variante,
		CP.Categoria_Tinto
END
END

