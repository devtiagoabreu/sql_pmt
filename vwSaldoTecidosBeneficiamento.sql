USE [DBPromoda]
GO

/****** Object:  View [dbo].[vwSaldoTecidosBeneficiamento]    Script Date: 03/31/2021 07:13:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwSaldoTecidosBeneficiamento]
    
AS   
	
SELECT 
	Produto AS ProdutoCodigo,
    Desc_Produto AS ProdutoDescricao,
    Situacao,
    Cor,
    Desc_Cor AS CorDescricao,
    Desenho,
    Variante,
    SUM(ISNULL(Metros,0)) AS Metros
FROM
	DBMicrodata.dbo.VW_Tnt_Controle_Programacao
WHERE
	OP IN ( SELECT OP FROM DBMicrodata.dbo.VW_Tnt_Controle_Programacao WHERE OP NOT IN ( SELECT OP FROM DBMicrodata.dbo.VW_Tnt_Controle_Programacao	WHERE Processo = '0014' AND Tipo_Prog = 'F' )) 
	AND	Processo = '0014'
GROUP BY
	Produto,
    Desc_Produto,
    Situacao,
    Cor,
    Desc_Cor,
    Desenho,
    Variante
GO


