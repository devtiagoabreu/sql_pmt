USE [DBPromoda]
GO

/****** Object:  View [dbo].[vwPedidosFaturadosE2]    Script Date: 05/10/2021 15:02:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwPedidosFaturadosE2]
    
AS   

SELECT
	NFe AS QtdePedidos,
	ISNULL(Metros, 0) AS Metros,
	ValorTotal AS ValorTotal,
	DataNFe
FROM
	vwPedidosFaturadosQuantidadeValorEmp02
WHERE
	vwPedidosFaturadosQuantidadeValorEmp02.GrupoOperacao = 'GERAL' 
	 

GO


