--Saldo Facionista
--Saldo Facionista SIMConsultaGeral - Parâmetros: Empresa: 01 | Datas: Datas do dia Atual
Exec sp_CTE_RelFacioCol '''01''', '', '', '', '2021-05-24T00:00:00', '2021-05-24T00:00:00', 0
Exec sp_CTE_RelFacioCol '''01''', '', '', '', '2021-05-24', '2021-05-24', 0
EXEC uspSaldoFacionista

SELECT
	DBMicrodata.dbo.Fat_Facionista.Produto,
	DBMicrodata.dbo.Produtos.Descricao,
	Fat_Facionista.Facionista,
	clientes_principal.Razao_Nome_Cliente AS Nome,
	ISNULL(SUM(DBMicrodata.dbo.Fat_Facionista.PESO),0) AS Peso,
	'REMESSA' AS TIPO
FROM
	DBMicrodata.dbo.Fat_Facionista
	INNER JOIN DBMicrodata.dbo.Produtos ON  DBMicrodata.dbo.Produtos.Codigo = DBMicrodata.dbo.Fat_Facionista.Produto
	INNER JOIN DBMicrodata.dbo.clientes_principal ON clientes_principal.Codigo_Cliente = Fat_Facionista.Facionista
WHERE
	Fat_Facionista.Tipo = '1' 
GROUP BY
	Fat_Facionista.Facionista,
	clientes_principal.Razao_Nome_Cliente,
	Fat_Facionista.Produto,
	Produtos.Descricao;
	
	
SELECT
	Fat_Facionista.Produto,
	Produtos.Descricao,
	Fat_Facionista.Facionista,
	clientes_principal.Razao_Nome_Cliente AS Nome,
	ISNULL(SUM(Fat_Facionista.PESO),0) AS Peso,
	'RETORNO' AS TIPO	
FROM
	DBMicrodata.dbo.Fat_Facionista
	INNER JOIN DBMicrodata.dbo.Produtos ON  DBMicrodata.dbo.Produtos.Codigo = DBMicrodata.dbo.Fat_Facionista.Produto
	INNER JOIN DBMicrodata.dbo.clientes_principal ON clientes_principal.Codigo_Cliente = Fat_Facionista.Facionista
WHERE
	DBMicrodata.dbo.Fat_Facionista.Tipo = '2'	   
GROUP BY
	Fat_Facionista.Facionista,
	clientes_principal.Razao_Nome_Cliente,
	DBMicrodata.dbo.Fat_Facionista.Produto,
	DBMicrodata.dbo.Produtos.Descricao;
	
	
	
	
	
