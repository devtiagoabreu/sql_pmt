--FILTRADO DA MICRODATA
SELECT
	TC.Razao_Nome_Cliente AS Nome_Cliente,
	TP.Vencimento_Parcelas AS Vencimento,
	Empresa_Parcelas AS Empresa, 
	TNF.Nr_Documento_NF AS Duplicata,
	TNF.Serie,TP.Parcela_Parcelas AS Parcela,
	TNF.Emissao_NF AS Emissao,
	REPLACE(TP.Valor_Parcelas,'.',',') AS Valor,
	TP.Banco_Parcelas AS Banco, 
	TP.Nosso_Nr_Parcelas AS NossoNro,
	TP.Operacao_Parcelas AS Operacao, 
	TNF.Cliente_NF AS Cliente, 
	(SELECT CP.Descricao_Pagto FROM Condicoes_Pagto CP WHERE Cp.Codigo_Pagto = TNF.Codigo_Parcelamento_NF) Descricao_Pagto FROM	Notas_Fiscais_Rec AS TNF,
	Notas_Fiscais_Parcelas AS TP,
	Clientes_Principal AS TC 
WHERE 
	TNF.Nr_Empresa_NF=TP.Empresa_Parcelas AND 
	TNF.Nr_Documento_NF=TP.Documento_Parcelas AND 
	TNF.Serie=TP.Serie and TNF.Cliente_NF=TC.Codigo_Cliente AND
	TNF.Emissao_NF BETWEEN CAST(DATEADD(DAY,1,EOMONTH(GETDATE(),-1)) AS DATETIME) AND CAST(EOMONTH(GETDATE()) AS DATETIME) AND
	TP.Empresa_Parcelas IN ('01', '02')  
ORDER BY
	Vencimento,
	TC.Razao_Nome_Cliente, 
	Emissao;
--DBPROMODA	
SELECT
	MONTH(Vencimento) AS MES,
	SUM(Valor) AS VALOR
FROM
	vwListagemEntradasMesAtual
GROUP BY
	MONTH(Vencimento)
ORDER BY
	MES