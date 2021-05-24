USE [DBProDash]
GO

/****** Object:  View [dbo].[vwSaldoRemessaFiosFacionista]    Script Date: 05/24/2021 10:13:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO






CREATE VIEW [dbo].[vwSaldoRemessaFiosFacionista]
AS

SELECT
	Fat_Facionista.Nota_Fiscal,
	Fat_Facionista.Produto,
	Produtos.Descricao,
	Fat_Facionista.Facionista,
	clientes_principal.Razao_Nome_Cliente AS Nome,
	SUM(ISNULL(DBMicrodata.dbo.Fat_Facionista.PESO,0)) AS Peso,
	'REMESSA' AS TIPO
FROM
	DBMicrodata.dbo.Fat_Facionista
	INNER JOIN DBMicrodata.dbo.Produtos ON  DBMicrodata.dbo.Produtos.Codigo = DBMicrodata.dbo.Fat_Facionista.Produto
	INNER JOIN DBMicrodata.dbo.clientes_principal ON clientes_principal.Codigo_Cliente = Fat_Facionista.Facionista
WHERE
	Fat_Facionista.Tipo = '1' 
	--AND
	--Fat_Facionista.DataEmissao IS NOT NULL AND
	--Fat_Facionista.Nota_Retorno IS NULL OR 
	--Fat_Facionista.Nota_Retorno = ''             
GROUP BY
	Fat_Facionista.Nota_Fiscal,
	Fat_Facionista.Facionista,
	clientes_principal.Razao_Nome_Cliente,
	Fat_Facionista.Produto,
	Produtos.Descricao;



GO


