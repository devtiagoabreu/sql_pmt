USE [DBPromoda]
GO

/****** Object:  View [dbo].[vwPedidoFaturadoDetalhadoE2]    Script Date: 05/10/2021 15:27:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[vwPedidoFaturadoDetalhadoE2]
AS

SELECT 
	VW_FaturamentoPorProdutoEmp02.Cod_Produto,
	Produtos.Secao,
	Produtos.Grupo,
	Produtos.Subgrupo,
	VW_FaturamentoPorProdutoEmp02.Nr_Nota AS NFe,
	VW_FaturamentoPorProdutoEmp02.Nosso_Pedido AS Pedido,
	VW_FaturamentoPorProdutoEmp02.Cod_Cliente,
	Vw_Cliente_Endereco_SPED.Cob_Estado,
	ISNULL(SUM(VW_FaturamentoPorProdutoEmp02.Metros),0) AS Metros,
	VW_FaturamentoPorProdutoEmp02.Vr_Nota AS ValorTotal,
	ISNULL(SUM(VW_FaturamentoPorProdutoEmp02.Vr_Total_Item),0) AS ValorTotalItens,
	VW_FaturamentoPorProdutoEmp02.Data_Nota AS DataNFe,
	VW_FaturamentoPorProdutoEmp02.Fat_Itens_GrupoNatOP AS GrupoOperacao,
	VW_FaturamentoPorProdutoEmp02.Data_Nota
FROM 
	DBMicrodata.dbo.VW_FaturamentoPorProdutoEmp02
	INNER JOIN DBMicrodata.dbo.Produtos ON DBMicrodata.dbo.Produtos.Codigo = VW_FaturamentoPorProdutoEmp02.Cod_Produto
	INNER JOIN DBMicrodata.dbo.Vw_Cliente_Endereco_SPED ON DBMicrodata.dbo.Vw_Cliente_Endereco_SPED.Cliente = VW_FaturamentoPorProdutoEmp02.Cod_Cliente
WHERE
	VW_FaturamentoPorProdutoEmp02.Fat_Itens_GrupoNatOP = 'GERAL'
GROUP BY 
	VW_FaturamentoPorProdutoEmp02.Nr_Nota,
	VW_FaturamentoPorProdutoEmp02.Nosso_Pedido,
	VW_FaturamentoPorProdutoEmp02.Cod_Cliente,
	Vw_Cliente_Endereco_SPED.Cob_Estado,
	VW_FaturamentoPorProdutoEmp02.Cod_Produto,
	Produtos.Secao,
	Produtos.Grupo,
	Produtos.Subgrupo,
	VW_FaturamentoPorProdutoEmp02.Vr_Nota,
	VW_FaturamentoPorProdutoEmp02.Data_Nota,
	VW_FaturamentoPorProdutoEmp02.Fat_Itens_GrupoNatOP,
	VW_FaturamentoPorProdutoEmp02.Cod_Produto,
	VW_FaturamentoPorProdutoEmp02.Data_Nota

GO


