--DRE--
--TOTAL DE BAIXAS POR OPERAÇÃO
--PROCEDURE: uspDashTotalDeBaixas

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
  DBMicrodata.dbo.Pag_Baixas.Data_Baixa>= CAST(CAST(GETDATE() - DAY(GETDATE()) + 1 AS DATE) AS DATETIME) AND 
  DBMicrodata.dbo.Pag_Baixas.Data_Baixa<= GETDATE() AND 
  (Tipo_Entidade='A' or Tipo_Entidade='F') AND
  DBMicrodata.dbo.Pag_Operacoes.Descricao = 'ADMINISTRATIVO'
	  
--TRABALHANDO COM DATAS	  
SELECT 
	CAST(CAST(GETDATE() - DAY(GETDATE()) AS DATE) AS DATETIME),
	DATEADD(MONTH, -1,CAST(CAST(GETDATE() - DAY(GETDATE()) + 1 AS DATE) AS DATETIME)),
	CAST(CAST(GETDATE() - DAY(GETDATE()) AS DATE) AS DATETIME),
	DAY(GETDATE()),
	DATEADD(MONTH, 0,CAST(CAST(GETDATE() - DAY(GETDATE()) + 1 AS DATE) AS DATETIME)),
	DATEADD(MONTH, 1,CAST(CAST(GETDATE() - DAY(GETDATE()) AS DATE) AS DATETIME))
	
--PRIMEIRO DIA DO MES
SELECT CAST(DATEADD(DAY,1,EOMONTH(GETDATE(),-1)) AS DATETIME)
--ULTIMO DIA DO MES	
SELECT CAST(EOMONTH(GETDATE()) AS DATETIME) AS 'This Month';  
--OUTRAS FORMAS
SELECT EOMONTH ( GETDATE(), 1 ) AS 'Next Month';  
SELECT EOMONTH ( GETDATE(), -1 ) AS 'Last Month'; 
	
--RETORNA BAIXAS DAS OPERACOES ADMINISTRATIVAS NO PERIODO DO PRIMEIRO AO ULTIMO DIA DO MES ATUAL
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
  DBMicrodata.dbo.Pag_Baixas.Data_Baixa>= DATEADD(MONTH, 0,CAST(CAST(GETDATE() - DAY(GETDATE()) + 1 AS DATE) AS DATETIME)) AND 
  DBMicrodata.dbo.Pag_Baixas.Data_Baixa<= DATEADD(MONTH, 1,CAST(CAST(GETDATE() - DAY(GETDATE()) AS DATE) AS DATETIME)) AND 
  (Tipo_Entidade='A' or Tipo_Entidade='F') AND
  DBMicrodata.dbo.Pag_Operacoes.Descricao = 'ADMINISTRATIVO';
 
 --RETONANDO PREVISÃO DE SALDO
 SELECT 	
	(SELECT 
		SUM(Valor) AS A_Pagar
	FROM 
		DBMicrodata.dbo.VW_Rec_DuplicatasEmAberto
	WHERE
		Empresa = '01' AND
		Vencimento >= CAST(CAST(GETDATE() - DAY(GETDATE()) + 1 AS DATE) AS DATETIME) AND 
		Vencimento <= DATEADD(MONTH,+4,CAST(CAST(GETDATE() - DAY(GETDATE()) AS DATE) AS DATETIME))) AS Receber,
	(SELECT
	   SUM(Valor_Parcela) AS ValorTotal
	FROM 
		DBMicrodata.dbo.VW_Pag_Titulo_Aberto
	WHERE
		Empresa = '01' AND
		Vencimento >= CAST(CAST(GETDATE() - DAY(GETDATE()) + 1 AS DATE) AS DATETIME) AND 
		Vencimento <= DATEADD(MONTH,+4,CAST(CAST(GETDATE() - DAY(GETDATE()) AS DATE) AS DATETIME))) AS Pagar,
	((SELECT 
		SUM(Valor) AS A_Pagar
	FROM 
		DBMicrodata.dbo.VW_Rec_DuplicatasEmAberto
	WHERE
		Empresa = '01' AND
		Vencimento >= CAST(CAST(GETDATE() - DAY(GETDATE()) + 1 AS DATE) AS DATETIME) AND 
		Vencimento <= DATEADD(MONTH,+4,CAST(CAST(GETDATE() - DAY(GETDATE()) AS DATE) AS DATETIME))) -
	(SELECT
	   SUM(Valor_Parcela) AS ValorTotal
	FROM 
		DBMicrodata.dbo.VW_Pag_Titulo_Aberto
	WHERE
		Empresa = '01' AND
		Vencimento >= CAST(CAST(GETDATE() - DAY(GETDATE()) + 1 AS DATE) AS DATETIME) AND 
		Vencimento <= DATEADD(MONTH,+4,CAST(CAST(GETDATE() - DAY(GETDATE()) AS DATE) AS DATETIME)))) AS Saldo		
	



--DUPLICATA EM ABERTO
SELECT 
	SUM(Valor) AS A_Pagar
FROM 
	DBMicrodata.dbo.VW_Rec_DuplicatasEmAberto
WHERE
	Empresa = '01' AND
	Vencimento >= CAST(CAST(GETDATE() - DAY(GETDATE()) + 1 AS DATE) AS DATETIME) AND 
	Vencimento <= DATEADD(MONTH,+4,CAST(CAST(GETDATE() - DAY(GETDATE()) AS DATE) AS DATETIME))
	
--TRABALHANDO COM DATAS
SELECT 
	CAST(CAST(GETDATE() - DAY(GETDATE()) + 1 AS DATE) AS DATETIME),
	DATEADD(MONTH,+4,CAST(CAST(GETDATE() - DAY(GETDATE()) AS DATE) AS DATETIME))