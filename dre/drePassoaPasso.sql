--1)LISTAR ENTRADAS EMITIDAS NO MES ATUAL E AGRUPA-LAS POR VENCIMENTO (CONTAS A RECEBER)
--VENCIMENTO TOTLA MES
SELECT
	MONTH(Vencimento) AS MES,
	REPLACE(SUM(Valor),'.',',') AS VALOR
FROM
	vwListagemEntradasMesAtual
GROUP BY
	MONTH(Vencimento)
ORDER BY
	MES
--VENCIMENTO TOTAL	
SELECT
	REPLACE(SUM(Valor),'.',',') AS VALOR
FROM
	vwListagemEntradasMesAtual


--2)LISTAR CONTAS A PAGAR DO MÊS (LISTAGEM DE BAIXAS POR OPERAÇÃO)
SELECT
	  ISNULL(SUM(DBMicrodata.dbo.Pag_Baixas.Valor_Liquido), 0) 
FROM 
  DBMicrodata.dbo.NF_Entradas  
  INNER JOIN DBMicrodata.dbo.NFE_Parcelas ON (DBMicrodata.dbo.NF_Entradas.Empresa=DBMicrodata.dbo.NFE_Parcelas.Empresa and DBMicrodata.dbo.NF_Entradas.Documento=DBMicrodata.dbo.NFE_Parcelas.Documento and NF_Entradas.Serie=NFE_Parcelas.Serie and NF_Entradas.Tipo_Fornec=DBMicrodata.dbo.NFE_Parcelas.Tipo_Fornec and DBMicrodata.dbo.NF_Entradas.Fornecedor=DBMicrodata.dbo.NFE_Parcelas.Fornecedor)      
  INNER JOIN DBMicrodata.dbo.Clientes_Principal ON (DBMicrodata.dbo.Clientes_Principal.Codigo=DBMicrodata.dbo.NF_Entradas.Fornecedor and DBMicrodata.dbo.Clientes_Principal.Tipo=NF_Entradas.Tipo_Fornec)
  INNER JOIN DBMicrodata.dbo.Pag_Baixas ON (DBMicrodata.dbo.Pag_Baixas.Empresa=DBMicrodata.dbo.NFE_Parcelas.Empresa and DBMicrodata.dbo.Pag_Baixas.Documento=DBMicrodata.dbo.NFE_Parcelas.Documento and DBMicrodata.dbo.Pag_Baixas.Serie=DBMicrodata.dbo.NFE_Parcelas.Serie and DBMicrodata.dbo.Pag_Baixas.Parcela=DBMicrodata.dbo.NFE_Parcelas.Parcela and DBMicrodata.dbo.Pag_Baixas.Tipo_Fornec=DBMicrodata.dbo.NFE_Parcelas.Tipo_Fornec and DBMicrodata.dbo.Pag_Baixas.Fornecedor=DBMicrodata.dbo.NFE_Parcelas.Fornecedor)
  LEFT JOIN DBMicrodata.dbo.Bancos ON (DBMicrodata.dbo.Pag_Baixas.Nr_Banco=DBMicrodata.dbo.Bancos.Nr_Bco_Bancos)
  LEFT JOIN DBMicrodata.dbo.Pag_Historicos ON (DBMicrodata.dbo.Pag_Baixas.Cod_Historico=DBMicrodata.dbo.Pag_Historicos.Cod_Historico_Historicos)
  LEFT JOIN DBMicrodata.dbo.Pag_Operacoes ON (DBMicrodata.dbo.Pag_Operacoes.Codigo = DBMicrodata.dbo.NFE_Parcelas.Operacao)
 WHERE 
  DBMicrodata.dbo.Pag_Baixas.Data_Baixa BETWEEN CAST(DATEADD(DAY,1,EOMONTH(GETDATE(),-1)) AS DATETIME) AND  CAST(EOMONTH(GETDATE()) AS DATETIME) AND
  (Tipo_Entidade='A' or Tipo_Entidade='F') AND
  DBMicrodata.dbo.Pag_Operacoes.Descricao = 'ADMINISTRATIVO'
  
--TRABALHANDO SELECT
SELECT
	NF_Entradas.Documento,
	NF_Entradas.Serie,
	NF_Entradas.Fornecedor,
	Pag_Operacoes.Descricao AS Operacao,
	NF_Entradas.Referente AS Referencia,
	SUBSTRING(NF_Entradas.Referente,1,2) ReferenciaCodigo, 
	ISNULL(Pag_Baixas.Valor_Liquido, 0) ValorLiquido
FROM 
  DBMicrodata.dbo.NF_Entradas  
  INNER JOIN DBMicrodata.dbo.NFE_Parcelas ON (DBMicrodata.dbo.NF_Entradas.Empresa=DBMicrodata.dbo.NFE_Parcelas.Empresa and DBMicrodata.dbo.NF_Entradas.Documento=DBMicrodata.dbo.NFE_Parcelas.Documento and NF_Entradas.Serie=NFE_Parcelas.Serie and NF_Entradas.Tipo_Fornec=DBMicrodata.dbo.NFE_Parcelas.Tipo_Fornec and DBMicrodata.dbo.NF_Entradas.Fornecedor=DBMicrodata.dbo.NFE_Parcelas.Fornecedor)      
  INNER JOIN DBMicrodata.dbo.Clientes_Principal ON (DBMicrodata.dbo.Clientes_Principal.Codigo=DBMicrodata.dbo.NF_Entradas.Fornecedor and DBMicrodata.dbo.Clientes_Principal.Tipo=NF_Entradas.Tipo_Fornec)
  INNER JOIN DBMicrodata.dbo.Pag_Baixas ON (DBMicrodata.dbo.Pag_Baixas.Empresa=DBMicrodata.dbo.NFE_Parcelas.Empresa and DBMicrodata.dbo.Pag_Baixas.Documento=DBMicrodata.dbo.NFE_Parcelas.Documento and DBMicrodata.dbo.Pag_Baixas.Serie=DBMicrodata.dbo.NFE_Parcelas.Serie and DBMicrodata.dbo.Pag_Baixas.Parcela=DBMicrodata.dbo.NFE_Parcelas.Parcela and DBMicrodata.dbo.Pag_Baixas.Tipo_Fornec=DBMicrodata.dbo.NFE_Parcelas.Tipo_Fornec and DBMicrodata.dbo.Pag_Baixas.Fornecedor=DBMicrodata.dbo.NFE_Parcelas.Fornecedor)
  LEFT JOIN DBMicrodata.dbo.Bancos ON (DBMicrodata.dbo.Pag_Baixas.Nr_Banco=DBMicrodata.dbo.Bancos.Nr_Bco_Bancos)
  LEFT JOIN DBMicrodata.dbo.Pag_Historicos ON (DBMicrodata.dbo.Pag_Baixas.Cod_Historico=DBMicrodata.dbo.Pag_Historicos.Cod_Historico_Historicos)
  LEFT JOIN DBMicrodata.dbo.Pag_Operacoes ON (DBMicrodata.dbo.Pag_Operacoes.Codigo = DBMicrodata.dbo.NFE_Parcelas.Operacao)
 WHERE 
  Pag_Baixas.Data_Baixa BETWEEN CAST(DATEADD(DAY,1,EOMONTH(GETDATE(),-1)) AS DATETIME) AND  CAST(EOMONTH(GETDATE()) AS DATETIME) AND
  Tipo_Entidade IN ('A','F') 
 ORDER BY
	Pag_Operacoes.Descricao
	

--Listagem de Baixas (contas a pagar mes atual)
SELECT
	Documento,
	Serie,
	Fornecedor,
	Operacao,
	Referencia,
	ReferenciaCodigo, 
	ValorLiquido
FROM 
	vwListagemContasPagarBaixasMesAtual
ORDER BY
	Operacao
	
--CONTAS PAGAS MES ATUAL AGRUPADAS POR CUSTO VARIAVEL E CUSTO FIXO 
SELECT
	REPLACE(ISNULL(SUM(ValorLiquido),0),'.',',') AS CustoVariavel
FROM 
	vwListagemContasPagarBaixasMesAtual
WHERE
	ReferenciaCodigo = 'CV'
	
SELECT
	REPLACE(ISNULL(SUM(ValorLiquido),0),'.',',') AS CustoFixo
FROM 
	vwListagemContasPagarBaixasMesAtual
WHERE
	ReferenciaCodigo = 'CF'
--CONTAS PAGAS MES ATUAL AGRUPADAS POR OPERACAO
SELECT
	Operacao,
	REPLACE(ISNULL(SUM(ValorLiquido),0),'.',',') AS CustoTotal
FROM 
	vwListagemContasPagarBaixasMesAtual
GROUP BY
	Operacao	
ORDER BY
	Operacao