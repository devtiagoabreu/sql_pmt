USE [DBProDash]
GO

/****** Object:  View [dbo].[vwFiosRemessaRetornoFacionista]    Script Date: 05/24/2021 10:12:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[vwFiosRemessaRetornoFacionista]
AS

select
	vwSaldoRemessaFiosFacionista.tipo,
	vwSaldoRemessaFiosFacionista.facionista,
	vwSaldoRemessaFiosFacionista.Razao_Nome_Cliente AS nome, 
	vwSaldoRemessaFiosFacionista.produto,
	vwSaldoRemessaFiosFacionista.descricao,
	vwSaldoRemessaFiosFacionista.peso 
from
	vwSaldoRemessaFiosFacionista
group by
	vwSaldoRemessaFiosFacionista.tipo,
	vwSaldoRemessaFiosFacionista.facionista,
	vwSaldoRemessaFiosFacionista.Razao_Nome_Cliente, 
	vwSaldoRemessaFiosFacionista.produto,
	vwSaldoRemessaFiosFacionista.descricao,
	vwSaldoRemessaFiosFacionista.peso

union ALL
	
select
	vwSaldoRetornoFiosFacionista.tipo,
	vwSaldoRetornoFiosFacionista.facionista,
	vwSaldoRetornoFiosFacionista.Razao_Nome_Cliente AS nome,  
	vwSaldoRetornoFiosFacionista.produto,
	vwSaldoRetornoFiosFacionista.descricao,
	vwSaldoRetornoFiosFacionista.peso 
from
	vwSaldoRetornoFiosFacionista
group by
	vwSaldoRetornoFiosFacionista.tipo,
	vwSaldoRetornoFiosFacionista.facionista,
	vwSaldoRetornoFiosFacionista.Razao_Nome_Cliente, 
	vwSaldoRetornoFiosFacionista.produto,
	vwSaldoRetornoFiosFacionista.descricao,
	vwSaldoRetornoFiosFacionista.peso


GO


