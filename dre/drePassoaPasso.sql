--COLETANDO DADOS
--1)LISTAR ENTRADAS EMITIDAS NO MES ATUAL E AGRUPA-LAS POR VENCIMENTO (CONTAS A RECEBER)
--VENCIMENTO TOTAL MES
--RECEITA BRUTA (PLANILHA)
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
	
	
--CONTAS PAGAS MES ATUAL LANÇADAS MANUALMENTE EM DADOS COMPLEMENTARES POR CUSTO VARIAVEL E CUSTO FIXO
SELECT 
	REPLACE(SUM(ISNULL(valor,0)),'.',',') AS CustoVariavelManual 
FROM 
	tblDREDadosComplementares 
	INNER JOIN tblDREReferencias ON tblDREReferencias.id = tblDREDadosComplementares.tblDREReferencias_id 
WHERE 
	tblDREReferencias.tipo = 'CV'
	
SELECT 
	REPLACE(SUM(ISNULL(valor,0)),'.',',') AS CustoFixoManual 
FROM 
	tblDREDadosComplementares 
	INNER JOIN tblDREReferencias ON tblDREReferencias.id = tblDREDadosComplementares.tblDREReferencias_id 
WHERE 
	tblDREReferencias.tipo = 'CF'

	
--CONTAS PAGAS MES ATUAL AGRUPADAS POR CUSTO VARIAVEL E CUSTO FIXO 
SELECT
	REPLACE(ISNULL(SUM(ValorLiquido),0),'.',',') AS CustoVariavelSistema
FROM 
	vwListagemContasPagarBaixasMesAtual
WHERE
	ReferenciaCodigo = 'CV'
	
SELECT
	REPLACE(ISNULL(SUM(ValorLiquido),0),'.',',') AS CustoFixoSistema
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
	
--DETALHANDO CUSTOS VARIAVEIS (PLANILHA)


--DETALHANDO CUSTOS FIXOS (PLANILHA)


--CRIANDO NOVAS TABELAS PARA INSERIR DADOS COMPLEMENTARES DA DRE
CREATE TABLE tblDREReferencias (
  id INTEGER  NOT NULL   IDENTITY ,
  descricao VARCHAR(60)  NOT NULL    ,
PRIMARY KEY(id));
GO

CREATE TABLE tblDREDadosComplementares (
  id INTEGER  NOT NULL   IDENTITY ,
  tblDREReferencias_id INTEGER  NOT NULL  ,
  valor DECIMAL(18,5)  NOT NULL DEFAULT 0 ,
  data_2 DATETIME  NOT NULL DEFAULT GETDATE() ,
  operador VARCHAR(5)      ,
PRIMARY KEY(id)  ,
  FOREIGN KEY(tblDREReferencias_id)
    REFERENCES tblDREReferencias(id));
GO


CREATE INDEX tblDREDadosComplementares_FKIndexDREReferencias ON tblDREDadosComplementares (tblDREReferencias_id);
GO


CREATE INDEX IFK_REL_tblDREDadosComplementa ON tblDREDadosComplementares (tblDREReferencias_id);
GO

--ALTERANDO TABELA DE REFERENCIAS
--ISERINDO NOVO CAMPO TIPO CUSTO VARIAVEL(CV) E CUSTO FIXO (CF)
ALTER TABLE tblDREReferencias
ADD tipo CHAR(2) NULL DEFAULT 'CV';

--UPDATE TABELA DE REFERENCIAS - CAMPO TIPO
UPDATE tblDREReferencias
SET 
	tipo = 'CV'
WHERE
	id = 7

--POPULANDO DRE REFERENCIAS
--EXEMPLO:
INSERT INTO tblDREReferencias
	(
		descricao
	)
	VALUES
	(
		'FERIAS / 13 SALARIO'
	);
	
	
INSERT tblDREReferencias

-- =============================================
--	id	descricao
--	1	'COMISSAO VENDEDORES'
--	2	'COMISSAO GERENTES COMERCIAIS'
--	3	'PIS'
--	4	'COFINS'
--	5	'ICMS'
--	6	'IMPOSTOS PIS/COFINS/ICMS'
--	7	'FERIAS / 13 SALARIO'
-- =============================================
	
--PARÂMETROS @Operador varchar(5), @Valor decimal(18,5), @Referencia int, @Data_2 datetime
--4) COMISSAO VENDEDORES (VALOR NAO INSERIDO NO SISTEMA)
EXEC uspDREDadosComplementaresInsert '96', @Valor,1,'2021-04-10 00:00:001'

--5) COMISSAO GER.COMERCIAL (VALOR NAO INSERIDO NO SISTEMA)
EXEC uspDREDadosComplementaresInsert '96', @Valor,2,'2021-04-10 00:00:001'

--6) IMPOSTOS (VALOR PROCESSADO PELO SISTEMA DE FORMA ERRADA DEVIDO A FALTA DE INFORMACAO DO ESCRITORIO - )
EXEC uspDREDadosComplementaresInsert '96', @Valor,6,'2021-04-10 00:00:001'

--7) FERIAS / 13 SALARIO
EXEC uspDREDadosComplementaresInsert '96', @Valor,7,'2021-04-10 00:00:001'

--3) FATURAMENTO EMPRESAS: 01|02
SELECT 
	REPLACE(SUM(ISNULL(ValorTotalItens,0)),'.',',') as faturamento	 
FROM
	vwFaturamentoMesAtualPorGrupoSintetico


-- ANALISANDO DADOS
-- ANALISE DE LUCRATIVIDADE (PLANILHA)

-- RECEITA BRUTA	                     1.397.194,05	100,00%
-- DEDUÇOES		                                        0,00%
-- CUSTO VARIAVEL		                                0,00%
-- CUSTO FIXO		                                    0,00%
-- RESULTADO OPERACIONAL		                        0,00%
--		                                                0,00%

EXEC uspDREAnaliseLucratividadeMesAtual 


--BALANCO (PLANILHA)



