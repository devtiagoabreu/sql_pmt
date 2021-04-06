USE [DBPromoda]
GO

/****** Object:  View [dbo].[vwRegistroInventarioTecidosSaldoPedidos]    Script Date: 03/31/2021 15:09:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwRegistroInventarioTecidosSaldoPedidos] AS

SELECT
	Vw_Car_SaldoPedido.Produto AS ProdutoCodigo,
	Produtos.Descricao AS ProdutoDescricao,
	Vw_Car_SaldoPedido.Situacao,
	Vw_Car_SaldoPedido.Cor,
	Vw_Car_SaldoPedido.Desc_Cor AS CorDescricao,
	Vw_Car_SaldoPedido.Desenho,
	Vw_Car_SaldoPedido.Variante,
	REPLACE(SUM(ISNULL(Vw_Car_SaldoPedido.Saldo,0)),'.',',') AS Metros,
	SUM(ISNULL(0,0)) AS Peso
FROM
	DBMicrodata.dbo.Vw_Car_SaldoPedido
	INNER JOIN DBMicrodata.dbo.Produtos ON Produtos.Codigo = Vw_Car_SaldoPedido.Produto
WHERE
	Data_Pedido > = '2021-01-01 00:00:00'
GROUP BY 
	Produto,
	Produtos.Descricao,
	Situacao,
	Cor,
	Desc_Cor,
	Desenho,
	Variante;
	
GO