USE [DBProDash]
GO

/****** Object:  View [dbo].[vwBaixaCxsFiosDBMicrodata]    Script Date: 05/27/2021 17:04:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[vwBaixaCxsFiosDBMicrodata]
AS


SELECT
	Ret_BaixaCxsFios.Codigo_Caixa + Ret_BaixaCxsFios.Entrada_Caixa AS coleta,
	Ret_BaixaCxsFios.Codigo_Caixa AS codigoCaixa,
	Ret_BaixaCxsFios.Entrada_Caixa AS entradaCaixa,
	Ret_BaixaCxsFios.Romaneio_Caixa AS romaneioFiosBaixaMicrodata, 
	Ret_BaixaCxsFios.Peso AS pesoLiquido,
	Ret_CxsFios.Peso_Bruto AS pesoBruto, 
	Ret_CxsFios.Produto AS codigoFio,
	Produtos.Descricao AS tituloFio, 
	Ret_CxsFios.Cor AS cor,
	Ret_CxsFios.Lote AS lote,
	Ret_CxsFios.Gaveta,
	Ret_BaixaCxsFios.Destino AS destino, 
	CTE_Destino.Descricao AS descricaoDestino, 
	Ret_BaixaCxsFios.Parcial AS parcial,
	Ret_CxsFios.Fornecedor AS codigoFornecedor,
	Clientes_Principal.Razao_Nome_Cliente AS Fornecedor,
	Ret_CxsFios.Documento AS documento,
	Ret_CxsFios.Serie AS serie, 
	Ret_CxsFios.Nr_palete AS nrPalete, 
	Ret_CxsFios.vr_unitario AS vrUnitario
FROM
	DBMicrodata.dbo.Ret_BaixaCxsFios 
	INNER JOIN DBMicrodata.dbo.Ret_CxsFios ON (Ret_BaixaCxsFios.Empresa = Ret_CxsFios.Empresa 
	AND Ret_BaixaCxsFios.Codigo_Caixa = Ret_CxsFios.Codigo_Caixa 
	AND Ret_BaixaCxsFios.Entrada_Caixa = Ret_CxsFios.Entrada_Caixa)
	LEFT JOIN DBMicrodata.dbo.CTE_Destino ON (Ret_BaixaCxsFios.Destino = CTE_Destino.Codigo)
	INNER JOIN DBMicrodata.dbo.Clientes_Principal ON Clientes_Principal.Codigo = Ret_CxsFios.Fornecedor 
	INNER JOIN DBMicrodata.dbo.Produtos ON Produtos.Codigo = Ret_CxsFios.Produto
WHERE 
	Ret_BaixaCxsFios.Empresa = '01' AND 
	Clientes_Principal.Tipo = '0';


GO


