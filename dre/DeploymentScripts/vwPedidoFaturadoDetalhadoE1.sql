USE [DBPromoda]
GO

/****** Object:  View [dbo].[vwPedidoFaturadoDetalhadoE1]    Script Date: 05/10/2021 15:18:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[vwPedidoFaturadoDetalhadoE1]
AS

SELECT 
	VW_FaturamentoPorProdutoEmp01.Cod_Produto,
	Produtos.Secao,
	Produtos.Grupo,
	Produtos.Subgrupo,
	VW_FaturamentoPorProdutoEmp01.Nr_Nota AS NFe,
	VW_FaturamentoPorProdutoEmp01.Nosso_Pedido AS Pedido,
	VW_FaturamentoPorProdutoEmp01.Cod_Cliente,
	Vw_Cliente_Endereco_SPED.Cob_Estado,
	ISNULL(SUM(VW_FaturamentoPorProdutoEmp01.Metros),0) AS Metros,
	VW_FaturamentoPorProdutoEmp01.Vr_Nota AS ValorTotal,
	ISNULL(SUM(VW_FaturamentoPorProdutoEmp01.Vr_Total_Item),0) AS ValorTotalItens,
	VW_FaturamentoPorProdutoEmp01.Data_Nota AS DataNFe,
	VW_FaturamentoPorProdutoEmp01.Fat_Itens_GrupoNatOP AS GrupoOperacao,
	VW_FaturamentoPorProdutoEmp01.Data_Nota
FROM 
	DBMicrodata.dbo.VW_FaturamentoPorProdutoEmp01
	INNER JOIN DBMicrodata.dbo.Produtos ON DBMicrodata.dbo.Produtos.Codigo = VW_FaturamentoPorProdutoEmp01.Cod_Produto
	INNER JOIN DBMicrodata.dbo.Vw_Cliente_Endereco_SPED ON DBMicrodata.dbo.Vw_Cliente_Endereco_SPED.Cliente = VW_FaturamentoPorProdutoEmp01.Cod_Cliente
WHERE
	VW_FaturamentoPorProdutoEmp01.Fat_Itens_GrupoNatOP = 'GERAL'
GROUP BY 
	VW_FaturamentoPorProdutoEmp01.Nr_Nota,
	VW_FaturamentoPorProdutoEmp01.Nosso_Pedido,
	VW_FaturamentoPorProdutoEmp01.Cod_Cliente,
	Vw_Cliente_Endereco_SPED.Cob_Estado,
	VW_FaturamentoPorProdutoEmp01.Cod_Produto,
	Produtos.Secao,
	Produtos.Grupo,
	Produtos.Subgrupo,
	VW_FaturamentoPorProdutoEmp01.Vr_Nota,
	VW_FaturamentoPorProdutoEmp01.Data_Nota,
	VW_FaturamentoPorProdutoEmp01.Fat_Itens_GrupoNatOP,
	VW_FaturamentoPorProdutoEmp01.Cod_Produto,
	VW_FaturamentoPorProdutoEmp01.Data_Nota;
	
GO


