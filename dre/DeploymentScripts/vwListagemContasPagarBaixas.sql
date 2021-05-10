USE [DBPromoda]
GO

/****** Object:  View [dbo].[vwListagemContasPagarBaixas]    Script Date: 05/10/2021 14:39:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[vwListagemContasPagarBaixas]
AS

SELECT
	NF_Entradas.Documento,
	NF_Entradas.Serie,
	NF_Entradas.Fornecedor,
	Pag_Operacoes.Descricao AS Operacao,
	NF_Entradas.Referente AS Referencia,
	SUBSTRING(NF_Entradas.Referente,1,2) ReferenciaCodigo, 
	ISNULL(Pag_Baixas.Valor_Liquido, 0) ValorLiquido,
	Pag_Baixas.Data_Baixa
FROM 
  DBMicrodata.dbo.NF_Entradas  
  INNER JOIN DBMicrodata.dbo.NFE_Parcelas ON (DBMicrodata.dbo.NF_Entradas.Empresa=DBMicrodata.dbo.NFE_Parcelas.Empresa and DBMicrodata.dbo.NF_Entradas.Documento=DBMicrodata.dbo.NFE_Parcelas.Documento and NF_Entradas.Serie=NFE_Parcelas.Serie and NF_Entradas.Tipo_Fornec=DBMicrodata.dbo.NFE_Parcelas.Tipo_Fornec and DBMicrodata.dbo.NF_Entradas.Fornecedor=DBMicrodata.dbo.NFE_Parcelas.Fornecedor)      
  INNER JOIN DBMicrodata.dbo.Clientes_Principal ON (DBMicrodata.dbo.Clientes_Principal.Codigo=DBMicrodata.dbo.NF_Entradas.Fornecedor and DBMicrodata.dbo.Clientes_Principal.Tipo=NF_Entradas.Tipo_Fornec)
  INNER JOIN DBMicrodata.dbo.Pag_Baixas ON (DBMicrodata.dbo.Pag_Baixas.Empresa=DBMicrodata.dbo.NFE_Parcelas.Empresa and DBMicrodata.dbo.Pag_Baixas.Documento=DBMicrodata.dbo.NFE_Parcelas.Documento and DBMicrodata.dbo.Pag_Baixas.Serie=DBMicrodata.dbo.NFE_Parcelas.Serie and DBMicrodata.dbo.Pag_Baixas.Parcela=DBMicrodata.dbo.NFE_Parcelas.Parcela and DBMicrodata.dbo.Pag_Baixas.Tipo_Fornec=DBMicrodata.dbo.NFE_Parcelas.Tipo_Fornec and DBMicrodata.dbo.Pag_Baixas.Fornecedor=DBMicrodata.dbo.NFE_Parcelas.Fornecedor)
  LEFT JOIN DBMicrodata.dbo.Bancos ON (DBMicrodata.dbo.Pag_Baixas.Nr_Banco=DBMicrodata.dbo.Bancos.Nr_Bco_Bancos)
  LEFT JOIN DBMicrodata.dbo.Pag_Historicos ON (DBMicrodata.dbo.Pag_Baixas.Cod_Historico=DBMicrodata.dbo.Pag_Historicos.Cod_Historico_Historicos)
  LEFT JOIN DBMicrodata.dbo.Pag_Operacoes ON (DBMicrodata.dbo.Pag_Operacoes.Codigo = DBMicrodata.dbo.NFE_Parcelas.Operacao)
 WHERE 
  Tipo_Entidade IN ('A','F') 
 


GO


