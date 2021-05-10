USE [DBPromoda]
GO

/****** Object:  View [dbo].[vwFaturamentoPorGrupoSintetico]    Script Date: 05/10/2021 14:52:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[vwFaturamentoPorGrupoSintetico]
AS

SELECT
	'01' AS Empresa,
	CASE Grupo
		WHEN '011' THEN 'MODA'
        WHEN '012' THEN 'DECORAÇÃO'
        WHEN '013' THEN 'BENEFICIAMENTO'
        WHEN '002' THEN 'BENEFICIAMENTO'
        WHEN '003' THEN 'BENEFICIAMENTO' 
    END AS Grupo,
    NFe, 
	CASE Grupo
		WHEN '002' THEN 0
		WHEN '003' THEN 0
		ELSE SUM(Metros)
	END AS Metros,	
	(SUM(ValorTotalItens) - SUM(vwFaturamentoDecontoGeral.VALOR_DECONTO_GERAL)) AS ValorTotalItens,
	vwPedidoFaturadoDetalhadoE1.DataNFe
FROM 
	vwPedidoFaturadoDetalhadoE1
	INNER JOIN vwFaturamentoDecontoGeral ON vwFaturamentoDecontoGeral.Nr_Nota = vwPedidoFaturadoDetalhadoE1.NFe
WHERE
	Secao IN ('001','008') AND
	Grupo IN ('002','003','013','012','011')
GROUP BY
	Grupo, 
	NFe,
	DataNFe
	
UNION	

SELECT
	'02' AS Empresa,
	CASE Grupo
		WHEN '011' THEN 'MODA'
        WHEN '012' THEN 'DECORAÇÃO'
        WHEN '013' THEN 'BENEFICIAMENTO' 
        WHEN '002' THEN 'BENEFICIAMENTO'
        WHEN '003' THEN 'BENEFICIAMENTO' 
    END AS Grupo,
    NFe,
    CASE Grupo
		WHEN '002' THEN 0
		WHEN '003' THEN 0
		ELSE SUM(Metros)
	END AS Metros,
	(SUM(ValorTotalItens) - SUM(vwFaturamentoDecontoGeral.VALOR_DECONTO_GERAL)) AS ValorTotalItens,
	vwPedidoFaturadoDetalhadoE2.DataNFe	
FROM 
	vwPedidoFaturadoDetalhadoE2
	INNER JOIN vwFaturamentoDecontoGeral ON vwFaturamentoDecontoGeral.Nr_Nota = vwPedidoFaturadoDetalhadoE2.NFe
WHERE
	Secao IN ('001','008') AND
	Grupo IN ('002','003','013','012','011') 
GROUP BY
	Grupo, 
	NFe,
	DataNFe




GO


