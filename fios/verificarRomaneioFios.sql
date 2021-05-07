-- romaneio de baixa realizada para regularizar estoque e fisco
--data de baixa: 2021-01-30 12:18:00
SELECT
	Ret_BaixaCxsFios.Romaneio_Caixa AS romaneio, 
	Ret_BaixaCxsFios.Codigo_Caixa AS codigoCaixa,
	Ret_BaixaCxsFios.Entrada_Caixa AS entradaCaixa,
	Ret_BaixaCxsFios.Codigo_Caixa + Ret_BaixaCxsFios.Entrada_Caixa AS coleta,
	Ret_BaixaCxsFios.Peso AS pesoLiquido,
	Ret_CxsFios.Peso_Bruto AS pesoBruto, 
	Ret_CxsFios.Produto AS codigoFio,
	Produtos.Descricao AS tituloFio, 
	Ret_CxsFios.Cor AS cor,
	Ret_BaixaCxsFios.Destino AS destino, 
	CTE_Destino.Descricao AS descricaoDestino, 
	Ret_BaixaCxsFios.Parcial AS parcial,
	Ret_CxsFios.Fornecedor AS codigoFornecedor,
	Clientes_Principal.Razao_Nome_Cliente AS Fornecedor,
	Ret_CxsFios.Documento AS documento,
	Ret_CxsFios.Serie AS serie, 
	Ret_CxsFios.Nr_palete AS nrPalete, 
	Ret_CxsFios.vr_unitario AS vrUnitario, 
	'' produtoReferenciado,
	Ret_CxsFios.Data AS dataEntrada,
	Ret_BaixaCxsFios.Hora_Saida AS dataSaida
FROM
	DBMicrodata.dbo.Ret_BaixaCxsFios 
	INNER JOIN DBMicrodata.dbo.Ret_CxsFios ON (Ret_BaixaCxsFios.Empresa = Ret_CxsFios.Empresa 
	AND Ret_BaixaCxsFios.Codigo_Caixa = Ret_CxsFios.Codigo_Caixa 
	AND Ret_BaixaCxsFios.Entrada_Caixa = Ret_CxsFios.Entrada_Caixa)
	LEFT JOIN DBMicrodata.dbo.CTE_Destino ON (Ret_BaixaCxsFios.Destino = CTE_Destino.Codigo)
	INNER JOIN DBMicrodata.dbo.Clientes_Principal ON Clientes_Principal.Codigo = Ret_CxsFios.Fornecedor 
	INNER JOIN DBMicrodata.dbo.Produtos ON Produtos.Codigo = Ret_CxsFios.Produto
WHERE 
	Ret_BaixaCxsFios.Empresa = '01' AND
	Ret_BaixaCxsFios.Romaneio_Caixa = '007724' AND
	Clientes_Principal.Tipo = '0'
ORDER BY 
	Ret_BaixaCxsFios.Codigo_Caixa