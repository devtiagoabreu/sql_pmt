USE [DBPromoda]
GO
/****** Object:  StoredProcedure [dbo].[uspDREAnaliseLucratividade]    Script Date: 05/10/2021 12:23:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[uspDREAnaliseLucratividade]
    
    @dataInicial varchar(15) -- '02/05/2021'
      
AS   
DECLARE

@faturamento decimal(18,5),
@deducoes decimal(18,5),
@custoVariavel decimal(18,5),
@custoFixo decimal(18,5),
@resultadoOperacional decimal(18,5)

SET @faturamento = (SELECT SUM(ISNULL(ValorTotalItens,0)) AS faturamento FROM vwFaturamentoPorGrupoSintetico WHERE DataNFe BETWEEN CAST(DATEADD(DAY,1,EOMONTH(CONVERT(DATETIME, @dataInicial, 103),-1)) AS DATETIME) AND  CAST(EOMONTH(CONVERT(DATETIME, @dataInicial, 103)) AS DATETIME) );

SET @custoVariavel = (
	SELECT
		ISNULL(SUM(ValorLiquido),0) + (SELECT ISNULL(SUM(valor),0) FROM tblDREDadosComplementares INNER JOIN tblDREReferencias ON tblDREReferencias.id = tblDREDadosComplementares.tblDREReferencias_id WHERE tblDREReferencias.tipo = 'CV' AND MONTH(tblDREDadosComplementares.data_2) = MONTH(CONVERT(DATETIME, @dataInicial, 103)) AND YEAR(tblDREDadosComplementares.data_2) = YEAR(CONVERT(DATETIME, @dataInicial, 103)) ) 
	FROM 
		vwListagemContasPagarBaixas
	WHERE
		ReferenciaCodigo = 'CV' AND
		vwListagemContasPagarBaixas.Data_Baixa BETWEEN CAST(DATEADD(DAY,1,EOMONTH(CONVERT(DATETIME, @dataInicial, 103),-1)) AS DATETIME) AND  CAST(EOMONTH(CONVERT(DATETIME, @dataInicial, 103)) AS DATETIME)
);					

SET @custoFixo = (
	SELECT
		ISNULL(SUM(ValorLiquido),0) + (SELECT ISNULL(SUM(valor),0) FROM tblDREDadosComplementares INNER JOIN tblDREReferencias ON tblDREReferencias.id = tblDREDadosComplementares.tblDREReferencias_id WHERE tblDREReferencias.tipo = 'CF' AND MONTH(tblDREDadosComplementares.data_2) = MONTH(CONVERT(DATETIME, @dataInicial, 103)) AND YEAR(tblDREDadosComplementares.data_2) = YEAR(CONVERT(DATETIME, @dataInicial, 103)) ) 
	FROM 
		vwListagemContasPagarBaixas
	WHERE
		ReferenciaCodigo = 'CF' AND
		vwListagemContasPagarBaixas.Data_Baixa BETWEEN CAST(DATEADD(DAY,1,EOMONTH(CONVERT(DATETIME, @dataInicial, 103),-1)) AS DATETIME) AND  CAST(EOMONTH(CONVERT(DATETIME, @dataInicial, 103)) AS DATETIME)
);

SET @resultadoOperacional = @faturamento - (@custoVariavel + @custoFixo);


SELECT
	@faturamento AS faturamento,
	@custoVariavel AS custoVariavel,
	@custoVariavel / @faturamento AS custoVariavelPorc,
	@custoFixo AS custoFixo,
	@custoFixo / @faturamento AS custoFixoPorc,
	@resultadoOperacional AS resultadoOperacional,
	@resultadoOperacional / @faturamento AS resultadoOperacionalPorc,
	'REPLACE . POR ,' AS REP,
	REPLACE(ISNULL(@faturamento,0),'.',',') AS faturamento,
	REPLACE(ISNULL(@custoVariavel,0),'.',',') AS custoVariavel,
	REPLACE(ISNULL(@custoVariavel / @faturamento,0),'.',',') AS custoVariavelPorc,
	REPLACE(ISNULL(@custoFixo,0),'.',',') AS custoFixo,
	REPLACE(ISNULL(@custoFixo / @faturamento,0),'.',',') AS custoFixoPorc,
	REPLACE(ISNULL(@resultadoOperacional,0),'.',',') AS resultadoOperacional,
	REPLACE(ISNULL(@resultadoOperacional / @faturamento,0),'.',',') AS resultadoOperacionalPorc

