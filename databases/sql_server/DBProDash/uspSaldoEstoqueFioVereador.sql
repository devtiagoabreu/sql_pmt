USE [DBProDash]
GO
/****** Object:  StoredProcedure [dbo].[uspSaldoEstoqueFioVereador]    Script Date: 05/27/2021 17:06:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Tiago de Abreu>
-- Description:	<Saldo de fios do estoque da rua vereador>
-- =============================================
ALTER PROCEDURE [dbo].[uspSaldoEstoqueFioVereador] 
  
AS
BEGIN

SELECT
	codigoFio AS Fio,
	tituloFio AS Descricao,
	COUNT(COLETA) AS QtdCaixas,
	SUM(pesoLiquido) AS SaldoPeso
FROM
	DBProDash.dbo.FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida )	
GROUP BY
	codigoFio,
	tituloFio
ORDER BY 
	FiosEntrada.tituloFio;
END
