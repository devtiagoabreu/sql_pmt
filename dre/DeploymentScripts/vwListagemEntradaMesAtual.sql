USE [DBPromoda]
GO

/****** Object:  View [dbo].[vwListagemEntradasMesAtual]    Script Date: 05/05/2021 16:10:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER VIEW [dbo].[vwListagemEntradasMesAtual] AS

SELECT
	TC.Razao_Nome_Cliente AS Nome_Cliente,
	TP.Vencimento_Parcelas AS Vencimento,
	Empresa_Parcelas AS Empresa, 
	TNF.Nr_Documento_NF AS Duplicata,
	TNF.Serie,
	TP.Parcela_Parcelas AS Parcela,
	TNF.Emissao_NF AS Emissao,
	TP.Valor_Parcelas AS Valor,
	TP.Banco_Parcelas AS Banco, 
	TP.Nosso_Nr_Parcelas AS NossoNro,
	TP.Operacao_Parcelas AS Operacao, 
	TNF.Cliente_NF AS Cliente, 
	(SELECT CP.Descricao_Pagto FROM DBMicrodata.dbo.Condicoes_Pagto CP WHERE Cp.Codigo_Pagto = TNF.Codigo_Parcelamento_NF) Descricao_Pagto 
FROM
	DBMicrodata.dbo.Notas_Fiscais_Rec AS TNF,
	DBMicrodata.dbo.Notas_Fiscais_Parcelas AS TP,
	DBMicrodata.dbo.Clientes_Principal AS TC 
WHERE 
	TNF.Nr_Empresa_NF=TP.Empresa_Parcelas AND 
	TNF.Nr_Documento_NF=TP.Documento_Parcelas AND 
	TNF.Serie=TP.Serie AND TNF.Cliente_NF=TC.Codigo_Cliente AND
	TNF.Emissao_NF BETWEEN CAST(DATEADD(DAY,1,EOMONTH(GETDATE(),-1)) AS DATETIME) AND CAST(EOMONTH(GETDATE()) AS DATETIME) AND
	TP.Empresa_Parcelas IN ('01', '02');  



GO


