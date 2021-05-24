USE [DBProDash]
GO
/****** Object:  StoredProcedure [dbo].[uspSaldoFacionista]    Script Date: 05/24/2021 09:54:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Tiago de Abreu>
-- Description:	<Saldo de fios na empresa Facionista>
-- =============================================
CREATE PROCEDURE [dbo].[uspSaldoFacionista] 
  
AS
BEGIN

DECLARE
	@data date
	
	SET @data = (SELECT CONVERT(date, GETDATE()));
		
	Exec DBMicrodata.dbo.sp_CTE_RelFacioCol '''01''', '', '', '', @data, @data, 0
END
