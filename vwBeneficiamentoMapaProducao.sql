USE [DBPromoda]
GO

/****** Object:  View [dbo].[vwBeneficiamentoMapaProducao]    Script Date: 04/15/2021 11:44:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[vwBeneficiamentoMapaProducao] AS

SELECT
	VW_Tnt_Controle_Programacao.OP,
	VW_Tnt_Controle_Programacao.Produto AS ProdutoCodigo,
    VW_Tnt_Controle_Programacao.Desc_Produto AS ProdutoDescricao,
    VW_Tnt_Controle_Programacao.Situacao,
    VW_Tnt_Controle_Programacao.Cor,
    Desc_Cor AS CorDescricao,
    VW_Tnt_Controle_Programacao.Desenho,
    VW_Tnt_Controle_Programacao.Variante,
    SUM(ISNULL(VW_Tnt_Controle_Programacao.Metros,0)) AS Metros,
    CONVERT(VARCHAR, TNT_OP.Data, 103) AS Data,
    TNT_OP.Data AS DataOP
FROM
	DBMicrodata.dbo.VW_Tnt_Controle_Programacao
	INNER JOIN DBMicrodata.dbo.TNT_OP ON TNT_OP.OP = VW_Tnt_Controle_Programacao.OP
WHERE
	VW_Tnt_Controle_Programacao.OP IN 
	(
		SELECT 
			VW_Tnt_Controle_Programacao.OP 
		FROM 
			DBMicrodata.dbo.VW_Tnt_Controle_Programacao 
		WHERE 
			VW_Tnt_Controle_Programacao.OP NOT IN 
			(
				SELECT 
					VW_Tnt_Controle_Programacao.OP 
				FROM 
					DBMicrodata.dbo.VW_Tnt_Controle_Programacao 
				WHERE	
					Processo = '0014' AND 
					Tipo_Prog = 'F'
			)
	)AND 
	Processo = '0014' 
GROUP BY 
	VW_Tnt_Controle_Programacao.OP,
	VW_Tnt_Controle_Programacao.Produto,
	VW_Tnt_Controle_Programacao.Desc_Produto,
	VW_Tnt_Controle_Programacao.Situacao,
	VW_Tnt_Controle_Programacao.Cor,
	VW_Tnt_Controle_Programacao.Desc_Cor,
	VW_Tnt_Controle_Programacao.Desenho,
	VW_Tnt_Controle_Programacao.Variante,
	TNT_OP.Data

GO


