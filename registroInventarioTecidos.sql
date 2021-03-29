--RELATORIO: REGISTRO DE INVENTARIO (TECIDOS)
--MODULO: SIMTECIDOS
--DATA: 29/03/2021
--OBS: RELATORIO MICRODATA NÃO POSSUI O CAMPO 'VARIANTE'

--EM ESTOQUE SINTETICO
SELECT
	CP.Produto AS ProdutoCodigo,
	Produtos.Descricao AS ProdutoDescricao,
	CP.Situacao,
	CP.Cor,
	Car_Cores.Descricao AS CorDescricao,
	CP.Desenho,
	CP.Variante,
	SUM(ISNULL(CP.Metros,0)) AS Metros,
	SUM(ISNULL(CP.Peso,0)) AS Peso
FROM 
	DBMicrodata.dbo.Cte_Peca CP 
	LEFT JOIN DBMicrodata.dbo.CTE_Baixa CB ON CP.Empresa=CB.Empresa and CP.Situacao=CB.Situacao and CP.Nro_Rolo=CB.Nro_Rolo and CP.Nro_Peca=CB.Nro_Peca
	INNER JOIN DBMicrodata.dbo.Produtos ON Produtos.Codigo = CP.Produto
	INNER JOIN DBMicrodata.dbo.Produtos_Tecidos ON Produtos_Tecidos.Produto = CP.Produto
	INNER JOIN DBMicrodata.dbo.Car_Cores ON Car_Cores.Codigo = CP.Cor
WHERE 
	CP.Empresa like '01' AND 
	CP.Situacao like '%' AND 
	CP.Nro_Rolo like '%' AND 
	CP.Nro_Peca like '%' AND 
	CP.Produto like '%' AND 
	Cor like '%' AND 
	Desenho like '%' AND 
	Categoria_Tinto Like '%01%' AND 
	IsNull(Variante, '') Like '%' AND
	CB.Data_Saida IS NULL
GROUP BY
	CP.Produto,
	Produtos.Descricao,
	CP.Situacao,
	CP.Cor,
	Car_Cores.Descricao,
	CP.Desenho,
	CP.Variante,
	CP.Categoria
ORDER BY
	CP.Produto,
	CP.Situacao,
	CP.Cor,
	CP.Desenho,
	CP.Variante

--EM ESTOQUE / CUSTO SITUACAO
SELECT
	CP.Produto AS ProdutoCodigo,
	Produtos.Descricao AS ProdutoDescricao,
	CP.Situacao,
	CP.Cor,
	Car_Cores.Descricao AS CorDescricao,
	CP.Desenho,
	CP.Variante,
	SUM(ISNULL(CP.Metros,0)) AS Metros,
	SUM(ISNULL(CP.Peso,0)) AS Peso,
	ISNULL((CASE   
		WHEN CP.Situacao = '000' THEN Produtos_Tecidos.Custo_Cru
		WHEN CP.Situacao = '001' THEN Produtos_Tecidos.Custo_Remessa
		WHEN CP.Situacao = '002' THEN Produtos_Tecidos.Custo_Estampado
		WHEN CP.Situacao = '009' THEN Produtos_Tecidos.Custo_Estampado
		ELSE '0'	
	END),0) AS CustoMetro,
	ISNULL(Produtos_Tecidos.Custo_Outros, 0) AS CustoMetroOutros,
	ISNULL((CASE   
		WHEN CP.Situacao = '000' THEN Produtos_Tecidos.Custo_Cru
		WHEN CP.Situacao = '001' THEN Produtos_Tecidos.Custo_Remessa
		WHEN CP.Situacao = '002' THEN Produtos_Tecidos.Custo_Estampado
		WHEN CP.Situacao = '009' THEN Produtos_Tecidos.Custo_Estampado
		ELSE '0'	
	END),0) * SUM(ISNULL(CP.Metros,0)) AS CustoTotal
FROM 
	DBMicrodata.dbo.Cte_Peca CP 
	LEFT JOIN DBMicrodata.dbo.CTE_Baixa CB ON CP.Empresa=CB.Empresa and CP.Situacao=CB.Situacao and CP.Nro_Rolo=CB.Nro_Rolo and CP.Nro_Peca=CB.Nro_Peca
	INNER JOIN DBMicrodata.dbo.Produtos ON Produtos.Codigo = CP.Produto
	INNER JOIN DBMicrodata.dbo.Produtos_Tecidos ON Produtos_Tecidos.Produto = CP.Produto
	INNER JOIN DBMicrodata.dbo.Car_Cores ON Car_Cores.Codigo = CP.Cor
WHERE 
	CP.Empresa like '01' AND 
	CP.Situacao like '%' AND 
	CP.Nro_Rolo like '%' AND 
	CP.Nro_Peca like '%' AND 
	CP.Produto like '%' AND 
	Cor like '%' AND 
	Desenho like '%' AND 
	Categoria_Tinto Like '%01%' AND 
	IsNull(Variante, '') Like '%' AND
	CB.Data_Saida IS NULL
GROUP BY
	CP.Produto,
	Produtos.Descricao,
	CP.Situacao,
	CP.Cor,
	Car_Cores.Descricao,
	CP.Desenho,
	CP.Variante,
	CP.Categoria,
	Produtos_Tecidos.Custo_Cru,
	Produtos_Tecidos.Custo_Remessa,
	Produtos_Tecidos.Custo_Estampado,
	Produtos_Tecidos.Custo_Estampado,
	Produtos_Tecidos.Custo_Outros
ORDER BY
	CP.Produto,
	CP.Situacao,
	CP.Cor,
	CP.Desenho,
	CP.Variante
	
--BAIXA POR INVENTARIO	
SELECT
	CP.Produto AS ProdutoCodigo,
	Produtos.Descricao AS ProdutoDescricao,
	CP.Situacao,
	CP.Cor,
	Car_Cores.Descricao AS CorDescricao,
	CP.Desenho,
	CP.Variante,
	SUM(ISNULL(CP.Metros,0)) AS Metros,
	SUM(ISNULL(CP.Peso,0)) AS Peso,
	CB.Observacao ,
	CB.Corte_Altera,
	CB.Data_Saida 
FROM 
	DBMicrodata.dbo.Cte_Peca CP 
	LEFT JOIN DBMicrodata.dbo.CTE_Baixa CB ON CP.Empresa=CB.Empresa and CP.Situacao=CB.Situacao and CP.Nro_Rolo=CB.Nro_Rolo and CP.Nro_Peca=CB.Nro_Peca
	INNER JOIN DBMicrodata.dbo.Produtos ON Produtos.Codigo = CP.Produto
	INNER JOIN DBMicrodata.dbo.Produtos_Tecidos ON Produtos_Tecidos.Produto = CP.Produto
	INNER JOIN DBMicrodata.dbo.Car_Cores ON Car_Cores.Codigo = CP.Cor
WHERE 
	CP.Empresa like '01' AND 
	CP.Situacao like '%' AND 
	CP.Nro_Rolo like '%' AND 
	CP.Nro_Peca like '%' AND 
	CP.Produto like '%' AND 
	Cor like '%' AND 
	Desenho like '%' AND 
	Categoria_Tinto Like '%01%' AND 
	IsNull(Variante, '') Like '%' AND
	CB.Observacao LIKE 'Baixa por Inventário%' AND
	CB.Corte_Altera = 'I'
GROUP BY
	CP.Produto,
	Produtos.Descricao,
	CP.Situacao,
	CP.Cor,
	Car_Cores.Descricao,
	CP.Desenho,
	CP.Variante,
	CP.Categoria,
	CB.Observacao ,
	CB.Corte_Altera,
	CB.Data_Saida 
ORDER BY
	CP.Produto,
	CP.Situacao,
	CP.Cor,
	CP.Desenho,
	CP.Variante
