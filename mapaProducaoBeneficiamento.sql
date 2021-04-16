--IMPLANTACAO SOLUÇÃO FABRICHART / PRODASH

SELECT 
	vwBeneficiamentoOP.Romaneio,
	VW_Tnt_Controle_Programacao.OP,
	VW_Tnt_Controle_Programacao.Produto AS ProdutoCodigo,
    VW_Tnt_Controle_Programacao.Desc_Produto AS ProdutoDescricao,
    VW_Tnt_Controle_Programacao.Situacao,
    VW_Tnt_Controle_Programacao.Cor,
    Desc_Cor AS CorDescricao,
    VW_Tnt_Controle_Programacao.Desenho,
    VW_Tnt_Controle_Programacao.Variante,
    REPLACE(CONVERT(NUMERIC(10,2),SUM(ISNULL(VW_Tnt_Controle_Programacao.Metros,0))),'.',',') AS Metros,
    CONVERT(VARCHAR, vwBeneficiamentoOP.DataOP, 103) AS Data
FROM
	DBMicrodata.dbo.VW_Tnt_Controle_Programacao
	INNER JOIN DBPromoda.dbo.vwBeneficiamentoOP ON vwBeneficiamentoOP.OP = VW_Tnt_Controle_Programacao.OP
WHERE
	VW_Tnt_Controle_Programacao.OP IN 
	(
		SELECT 
			VW_Tnt_Controle_Programacao.OP 
		FROM 
			DBMicrodata.dbo.VW_Tnt_Controle_Programacao 
		WHERE 
			VW_Tnt_Controle_Programacao.OP NOT IN 
			(
				SELECT 
					VW_Tnt_Controle_Programacao.OP 
				FROM 
					DBMicrodata.dbo.VW_Tnt_Controle_Programacao 
				WHERE	
					Processo = '0014' AND 
					Tipo_Prog = 'F'
			)
	)AND 
	Processo = '0014' 
GROUP BY 
	vwBeneficiamentoOP.Romaneio,
	VW_Tnt_Controle_Programacao.OP,
	VW_Tnt_Controle_Programacao.Produto,
	VW_Tnt_Controle_Programacao.Desc_Produto,
	VW_Tnt_Controle_Programacao.Situacao,
	VW_Tnt_Controle_Programacao.Cor,
	VW_Tnt_Controle_Programacao.Desc_Cor,
	VW_Tnt_Controle_Programacao.Desenho,
	VW_Tnt_Controle_Programacao.Variante,
	vwBeneficiamentoOP.DataOP
ORDER BY
	vwBeneficiamentoOP.DataOP DESC
	
SELECT 
    Romaneio,
    OP,
    ProdutoCodigo,
    ProdutoDescricao,
    Situacao,
    Cor,
    CorDescricao,
    Desenho,
    Variante,
    Metros,
    Data
FROM
    DBPromoda.dbo.vwBeneficiamentoMapaProducao
ORDER BY
    DataOP DESC;	


--VIEWS PARA NECESSIDADE DE PRODUÇÃO
SELECT * FROM vwRegistroInventarioTecidosBeneficiamento
SELECT * FROM DBPromoda.dbo.vwSaldoTecidosBeneficiamento
	
--SELECT BASE	
SELECT DISTINCT
	Tnt_Romaneio_NFE.Romaneio,
	Tnt_Fluxo.OP AS Op,
	Tnt_Fluxo.Sequencia,
	Tnt_Fluxo.Agrupamento,
	Tnt_Processo.Tipo_Processo,
	Tnt_Tipo_Processo.Descricao AS Descricao_Tipo_Processo,
	Tnt_Fluxo.Processo,
	Tnt_Fluxo.Item,
	Tnt_Processo.Grupo_Maquina AS GrupoMaquina,
	Tnt_Processo.Descricao AS DescricaoProcesso,
	IsNULL(Tnt_Programacao.Status,
	CASE 
		WHEN Tnt_ProcEfet.OP IS NULL THEN 'P' 
	ELSE 
		(CASE WHEN Tnt_ProcEfet.Data_Final IS NULL THEN 'O' 
		 ELSE 'F' 
		 END) 
	END) Status,
	VW_Tnt_OP.Data_OP AS DataOP,
	Tnt_ProcEfet.Data_Inicio AS DataInicio,
	Tnt_ProcEfet.Hora_Inicio AS HoraInicio,
	Tnt_ProcEfet.Data_Final AS DataFinal,
	Tnt_ProcEfet.Hora_Final AS HoraFinal
FROM
	DBMicrodata.dbo.Tnt_Fluxo
	inner join DBMicrodata.dbo.Tnt_Romaneio_NFE ON DBMicrodata.dbo.Tnt_Romaneio_NFE.OP = DBMicrodata.dbo.Tnt_Fluxo.OP
	INNER JOIN DBMicrodata.dbo.VW_Tnt_OP ON DBMicrodata.dbo.VW_Tnt_OP.OP = DBMicrodata.dbo.Tnt_Fluxo.OP   
	INNER JOIN DBMicrodata.dbo.Tnt_Processo ON DBMicrodata.dbo.Tnt_Fluxo.Empresa = DBMicrodata.dbo.Tnt_Processo.Empresa AND DBMicrodata.dbo.Tnt_Fluxo.Processo = DBMicrodata.dbo.Tnt_Processo.Processo 
	INNER JOIN DBMicrodata.dbo.Tnt_Tipo_Processo ON DBMicrodata.dbo.Tnt_Tipo_Processo.Codigo = DBMicrodata.dbo.Tnt_Processo.Tipo_Processo
	LEFT JOIN DBMicrodata.dbo.Tnt_Programacao ON DBMicrodata.dbo.Tnt_Programacao.OP = DBMicrodata.dbo.Tnt_Fluxo.OP AND DBMicrodata.dbo.Tnt_Programacao.Empresa = DBMicrodata.dbo.Tnt_Fluxo.Empresa AND DBMicrodata.dbo.Tnt_Programacao.SeqFluxo = DBMicrodata.dbo.Tnt_Fluxo.Sequencia
	LEFT JOIN DBMicrodata.dbo.Tnt_ProcEfet ON DBMicrodata.dbo.Tnt_Fluxo.Empresa = DBMicrodata.dbo.Tnt_ProcEfet.Empresa AND DBMicrodata.dbo.Tnt_Fluxo.OP = Tnt_ProcEfet.OP AND DBMicrodata.dbo.Tnt_Fluxo.Sequencia = DBMicrodata.dbo.Tnt_ProcEfet.Item_PEf
WHERE 
	IsNULL(Tnt_Programacao.Status,CASE WHEN DBMicrodata.dbo.Tnt_ProcEfet.OP IS NULL THEN ' ' ELSE 'F' END) LIKE '%'; 
