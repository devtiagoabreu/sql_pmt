USE [DBProDash]
GO
/****** Object:  StoredProcedure [dbo].[uspEntradaEstoqueProducao]    Script Date: 05/27/2021 17:05:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Tiago de Abreu>
-- Description:	<Entrar com Romaneio de Baixa Microdata em estoque de producao>
-- =============================================
ALTER PROCEDURE [dbo].[uspEntradaEstoqueProducao] 
	
-- TIPO: 1 (ROMANEIO) TIPO:2 (COLETA)
@tipo char(1),
@romaneio varchar(20),
@estoque integer
   
AS
BEGIN

--DECLARE
	
	
BEGIN TRY
BEGIN TRAN tranEntradaEstoqueProducao
--verificação se o romaneio de baixa existe
	IF (NOT EXISTS(SELECT TOP 1 romaneioFiosBaixaMicrodata FROM vwBaixaCxsFiosDBMicrodata WHERE romaneioFiosBaixaMicrodata = @romaneio)) 
		RAISERROR('ESTE ROMANEIO NÃO EXISTE!',14,1);
		
	IF(@tipo='1')
	BEGIN
	
		INSERT INTO DBProDash.dbo.FiosEntrada
		(
			coleta,
			estoque,
			codigoCaixa,
			entradaCaixa,
			romaneioFiosBaixaMicrodata, 
			pesoLiquido,
			pesoBruto, 
			codigoFio,
			tituloFio, 
			cor,
			lote,
			Gaveta,
			destino, 
			descricaoDestino, 
			parcial,
			codigoFornecedor,
			Fornecedor,
			documento,
			serie, 
			nrPalete, 
			vrUnitario
		)
				
			SELECT
				coleta,
				@estoque,
				codigoCaixa,
				entradaCaixa,
				romaneioFiosBaixaMicrodata, 
				pesoLiquido,
				pesoBruto, 
				codigoFio,
				tituloFio, 
				cor,
				lote,
				Gaveta,
				destino, 
				descricaoDestino, 
				parcial,
				codigoFornecedor,
				Fornecedor,
				documento,
				serie, 
				nrPalete, 
				vrUnitario
			FROM
				vwBaixaCxsFiosDBMicrodata
			WHERE 
				romaneioFiosBaixaMicrodata = @romaneio
		
		
	END

COMMIT TRAN tranEntradaEstoqueProducao
END TRY
BEGIN CATCH
	ROLLBACK TRAN tranEntradaEstoqueProducao
	SELECT ERROR_MESSAGE() AS Retorno;
END CATCH
END
