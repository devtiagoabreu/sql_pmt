USE [DBPromoda]
GO

/****** Object:  View [dbo].[vwSaldoTecidosEstoquePrimeria]    Script Date: 03/31/2021 07:13:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [dbo].[vwSaldoTecidosEstoquePrimeria]
    
AS   

SELECT
	CP.Produto AS ProdutoCodigo,
	Produtos.Descricao AS ProdutoDescricao,
	CP.Situacao,
	CP.Cor,
	Car_Cores.Descricao AS CorDescricao,
	CP.Desenho,
	CP.Variante,
	SUM(ISNULL(CP.Metros,0)) AS Metros
FROM 
	DBMicrodata.dbo.Cte_Peca CP 
	LEFT JOIN DBMicrodata.dbo.CTE_Baixa CB ON CP.Empresa=CB.Empresa and CP.Situacao=CB.Situacao and CP.Nro_Rolo=CB.Nro_Rolo and CP.Nro_Peca=CB.Nro_Peca
	INNER JOIN DBMicrodata.dbo.Produtos ON Produtos.Codigo = CP.Produto
	INNER JOIN DBMicrodata.dbo.Produtos_Tecidos ON Produtos_Tecidos.Produto = CP.Produto
	INNER JOIN DBMicrodata.dbo.Car_Cores ON Car_Cores.Codigo = CP.Cor
WHERE 
	CP.Empresa like '01' AND 
	CP.Situacao like '%' AND 
	CP.Nro_Rolo like '%' AND 
	CP.Nro_Peca like '%' AND 
	CP.Produto like '%' AND 
	Cor like '%' AND 
	Desenho like '%' AND 
	Categoria_Tinto Like '01' AND 
	IsNull(Variante, '') Like '%' AND
	CB.Data_Saida IS NULL
GROUP BY
	CP.Produto,
	Produtos.Descricao,
	CP.Situacao,
	CP.Cor,
	Car_Cores.Descricao,
	CP.Desenho,
	CP.Variante

GO


