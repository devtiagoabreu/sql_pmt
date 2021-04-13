USE [DBPromoda]
GO

/****** Object:  View [dbo].[vwSaldoTecidosCarteira]    Script Date: 03/31/2021 15:09:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwSaldoTecidosCarteira] AS

SELECT 
	VW_Car_Pedido_Aprov.Produto AS ProdutoCodigo,
	Produtos.Descricao AS ProdutoDescricao,
	VW_Car_Pedido_Aprov.Situacao,
	VW_Car_Pedido_Aprov.Cor,
	Car_Cores.Descricao AS CorDescricao,
	VW_Car_Pedido_Aprov.Desenho,
	VW_Car_Pedido_Aprov.Variante,
	SUM(ISNULL(VW_Car_Pedido_Aprov.Qtde_Saldo,0)) AS Metros
FROM 
	DBMicrodata.dbo.VW_Car_Pedido_Aprov
	INNER JOIN DBMicrodata.dbo.Produtos ON Produtos.Codigo =  VW_Car_Pedido_Aprov.Produto
	INNER JOIN DBMicrodata.dbo.Car_Cores ON Car_Cores.Codigo = VW_Car_Pedido_Aprov.Cor
WHERE
	VW_Car_Pedido_Aprov.Qtde_Saldo > 0
GROUP BY
	VW_Car_Pedido_Aprov.Produto,
	Produtos.Descricao,
	VW_Car_Pedido_Aprov.Situacao,
	VW_Car_Pedido_Aprov.Cor,
	Car_Cores.Descricao,
	VW_Car_Pedido_Aprov.Desenho,
	VW_Car_Pedido_Aprov.Variante;
GO


