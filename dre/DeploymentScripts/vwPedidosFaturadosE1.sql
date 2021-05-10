USE [DBPromoda]
GO

/****** Object:  View [dbo].[vwPedidosFaturadosMesAtualE1]    Script Date: 05/10/2021 14:56:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[vwPedidosFaturadosE1]
    
AS   

SELECT
	NFe AS QtdePedidos,
	ISNULL(Metros, 0) AS Metros,
	ValorTotal AS ValorTotal,
	DataNFe
FROM
	vwPedidosFaturadosQuantidadeValorEmp01
	
WHERE
	vwPedidosFaturadosQuantidadeValorEmp01.GrupoOperacao = 'GERAL' AND
	ValorTotal <> 0;

GO


