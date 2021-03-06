USE [DBPromoda]
GO
/****** Object:  StoredProcedure [dbo].[uspDREDadosComplementaresInsert]    Script Date: 05/10/2021 08:30:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Tiago de Abreu>
-- Description:	<Inserir Produção Tecelagem>
-- =============================================
CREATE PROCEDURE [dbo].[uspDREDadosComplementaresInsert] 
	
	
   @Operador varchar(5),
   @Valor decimal(18,5),
   @Referencia int,
   @Data_2 datetime   

AS
BEGIN
--variáveis
DECLARE
	@Id int
	
	BEGIN TRY
	BEGIN TRAN tranDREDadosComplementaresInsert
--verificação 
		IF (EXISTS(SELECT id FROM tblDREDadosComplementares WHERE MONTH(data_2) = MONTH(@Data_2) AND tblDREReferencias_id = @Referencia))
			RAISERROR('OPS! VOCE JA INSERIU ESTA REFERENCIA NESTE MES, FAVOR ALTERAR REFERENCIA EXISTENTE!',14,1);
--insert
		INSERT INTO tblDREDadosComplementares
		(
			operador,
			valor,
			tblDREReferencias_id,
			data_2
		)
		VALUES
		(
			
			@Operador,
			@Valor,
			@Referencia,
			@Data_2

		)
    COMMIT TRAN tranDREDadosComplementaresInsert
	SET @Id = @@IDENTITY;
	SELECT @Id;
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN tranDREDadosComplementaresInsert
		SELECT ERROR_MESSAGE() AS Retorno;
	END CATCH
END


