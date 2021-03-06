USE [DBProDash]
GO
/****** Object:  StoredProcedure [dbo].[uspSaldoTotalEstoqueFioVereador]    Script Date: 05/27/2021 17:06:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Tiago de Abreu>
-- Description:	<Saldo de fios do estoque da rua vereador>
-- =============================================
ALTER PROCEDURE [dbo].[uspSaldoTotalEstoqueFioVereador] 
  
AS
BEGIN

SELECT
	SUM(pesoLiquido) AS PesoTotalFios
FROM
	FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida );
END
