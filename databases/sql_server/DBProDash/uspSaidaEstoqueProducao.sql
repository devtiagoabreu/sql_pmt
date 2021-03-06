USE [DBProDash]
GO
/****** Object:  StoredProcedure [dbo].[uspSaidaEstoqueProducao]    Script Date: 05/27/2021 17:05:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Tiago de Abreu>
-- Description:	<Sair com coleta de caixas do estoque de producao>
-- =============================================
ALTER PROCEDURE [dbo].[uspSaidaEstoqueProducao] 
	
@romaneioFiosBaixaProducao INT

AS
BEGIN
	
BEGIN TRY
BEGIN TRAN tranSaidaEstoqueProducao

	INSERT INTO DBProDash.dbo.FiosSaida
		(
			coleta,
			romaneioFiosBaixaProducao 
			
		)
				
			SELECT
				coleta,
				@romaneioFiosBaixaProducao
			FROM
				FiosEntrada
			WHERE 
				coleta IN (SELECT coletas FROM coleta)
		

COMMIT TRAN tranSaidaEstoqueProducao
END TRY
BEGIN CATCH
	ROLLBACK TRAN tranSaidaEstoqueProducao
	SELECT ERROR_MESSAGE() AS Retorno;
END CATCH
END
