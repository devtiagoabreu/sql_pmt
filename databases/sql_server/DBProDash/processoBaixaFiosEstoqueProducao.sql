--------------------PROCESSO DE BAIXA DE FIOS ESTOQUE DE PRODUCAO---------------------------------
--ROMANEIO Nº1	
--GERA NOVO ROMANEIO DE BAIXA
INSERT INTO RomaneioFiosBaixaProducao
           (destino,operador)
     VALUES
           (2,'ABREU')
GO

--VER QUAL O ÚLTIMO CÓDIGO DE ROMANEIO
SELECT TOP 1 codigo FROM romaneioFiosBaixaProducao ORDER BY codigo DESC;
--RESULTADO
--codigo
--1

--DELETA DADOS DA TABELA COLETA
TRUNCATE TABLE DBProDash.dbo.Coletas;

--VERIFICAR SE TABELA COLETAS FOI DELETADA
SELECT * FROM DBProDash.dbo.Coletas

--POPULAR TABELA COLETA 
INSERT INTO Coletas
	(
		coleta
	)
VALUES
	('0201371001'),
	('0201370001'),
	('0201368001'),
	('0201367001'),
	('0201510001'),
	('0201415001'),
	('0201616001'),
	('0201367001'),
	('0201414001'),
	('0201618001'),
	('0197880001'),
	('0197805001'),
	('0197814001'),
	('0197867001'),
	('0197806001'),
	('0197826001'),
	('0197853001'),
	('0197862001'),
	('0197856001'),
	('0197854001'),
	('0197821001'),
	('0197922001'),
	('0197756001'),
	('0197841001'),
	('0197830001'),
	('0197869001'),
	('0197893001'),
	('0197901001'),
	('0197883001'),
	('0197900001')
GO 

--VERIFICAR SE TABELA COLETAS FOI POPULADA
SELECT * FROM DBProDash.dbo.Coletas

--VERIFICANDO COLETAS REPETIDAS
SELECT 
	coleta, 
	COUNT(*) AS Qtd 
FROM 
	Coletas
GROUP BY 
	coleta
HAVING 
	COUNT(*) > 1

--RESULTADO
--coleta	Qtd
--0201367001	2

--MOSTRANDO CAIXAS QUE NAO FORAM IDENTIFICADAS NA TABELA DE ENTRADA
SELECT
	coleta
FROM
	Coletas
WHERE 
	coleta NOT IN (SELECT coleta FROM FiosEntrada WHERE	coleta IN (SELECT coleta FROM DBProDash.dbo.Coletas))
--RESULTADO
--0



--VERIFICANDO COLETA NA TABELA DE ENTRADA - O QUE TENHO DA COLETA QUE ESTÁ NA TABELA DE ENTRADA
SELECT
	*
FROM
	FiosEntrada
WHERE 
	coleta IN (SELECT coleta FROM DBProDash.dbo.Coletas)
--RESULTADO
--29 CAIXAS
	
--VERIFICAR SE EXITE NA COLETA CAIXAS BAIXADAS
SELECT
	*
FROM
	FiosSaida
WHERE 
	coleta IN (SELECT coleta FROM DBProDash.dbo.Coletas)	
--RESULTADO
--0	

--EFETUANDO A BAIXA DA COLETA
INSERT INTO DBProDash.dbo.FiosSaida
		(
			coleta,
			romaneioFiosBaixaProducao
		)
SELECT
	coleta,
	1
FROM
	FiosEntrada
WHERE 
	coleta IN (SELECT coleta FROM Coletas);
	
--MOSTRAR CAIXAS QUE FORAM BAIXADAS DO ESTOQUE DE PRODUCAO
SELECT
	coleta,
	romaneioFiosBaixaProducao
FROM
	FiosSaida
WHERE 
	romaneioFiosBaixaProducao IN (1);
	
--LISTANDO DADOS DO ROMANEIO DE BAIXA
SELECT
	FiosSaida.coleta AS Caixa_Fio,
	FiosEntrada.codigoFio,
	FiosEntrada.tituloFio,
	FiosEntrada.cor,
	FiosEntrada.lote,
	REPLACE(FiosEntrada.pesoLiquido,'.',',') AS Peso_Liquido,
	REPLACE(FiosEntrada.pesoBruto,'.',',') AS Peso_Bruto,
	REPLACE(FiosEntrada.vrUnitario,'.',',') AS vrUnitario,
	Estoques.descricao AS Estoque,
	Destinos.descricao AS Destino,
	FiosSaida.romaneioFiosBaixaProducao AS RomaneioBaixa,
	FiosEntrada.romaneioFiosBaixaMicrodata AS RomaneioMicrodata,
	FiosEntrada.gaveta,
	FiosEntrada.codigoFornecedor,
	FiosEntrada.fornecedor,
	FiosEntrada.documento,
	FiosEntrada.serie,
	FiosEntrada.dataEntrada,
	FiosSaida.dataSaida
FROM
	FiosSaida
	INNER JOIN FiosEntrada ON FiosEntrada.coleta = FiosSaida.coleta 
	INNER JOIN Estoques ON Estoques.codigo = FiosEntrada.estoque 
	INNER JOIN RomaneioFiosBaixaProducao ON RomaneioFiosBaixaProducao.codigo = FiosSaida.romaneioFiosBaixaProducao
	INNER JOIN Destinos ON Destinos.codigo = RomaneioFiosBaixaProducao.destino
WHERE 
	FiosSaida.romaneioFiosBaixaProducao IN (1);

--VERIFICAR ESTOQUE
SELECT
	*
FROM
	FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida )
	
--VERIFICAR ESTOQUE COM REPLACE

SELECT
	coleta,
	codigoFio,
	tituloFio,
	REPLACE(pesoLiquido,'.',',') AS pesoLiquido
FROM
	FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida )
	
--TOTAL DE CAIXAS	
SELECT
	COUNT(coleta) AS qtdCaixas
FROM
	FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida )
	
--PESO TOTAL POR TITULO DE FIO
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
    DBProDash.dbo.FiosEntrada.tituloFio;
--PESO TOTAL 
SELECT
	SUM(pesoLiquido) AS pesoLiquido
FROM
	FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida )	
	

-----------------------FIM------------










--------------------PROCESSO DE BAIXA DE FIOS ESTOQUE DE PRODUCAO---------------------------------
--ROMANEIO Nº2	
--GERA NOVO ROMANEIO DE BAIXA
INSERT INTO RomaneioFiosBaixaProducao
           (destino,operador)
     VALUES
           (2,'ABREU')
GO

--VER QUAL O ÚLTIMO CÓDIGO DE ROMANEIO
SELECT TOP 1 codigo FROM romaneioFiosBaixaProducao ORDER BY codigo DESC;
--RESULTADO
--codigo
--2

--DELETA DADOS DA TABELA COLETA
TRUNCATE TABLE DBProDash.dbo.Coletas;

--VERIFICAR SE TABELA COLETAS FOI DELETADA
SELECT * FROM DBProDash.dbo.Coletas

--POPULAR TABELA COLETA 
INSERT INTO Coletas
	(
		coleta
	)
VALUES
	('0197737001'),
	('0197801001'),
	('0197781001'),
	('0197809001'),
	('0197807001'),
	('0197775001'),
	('0197769001'),
	('0197754001'),
	('0197770001'),
	('0197917001'),
	('0197804001'),
	('0197847001'),
	('0197752001'),
	('0197760001'),
	('0197798001'),
	('0197872001'),
	('0197803001'),
	('0197783001'),
	('0197874001'),
	('0197820001'),
	('0197824001'),
	('0197788001'),
	('0197852001'),
	('0197892001'),
	('0197865001'),
	('0197920001'),
	('0197793001'),
	('0197792001'),
	('0019799001'),
	('0197753001'),
	('0197894001'),
	('0197864001'),
	('0197782001'),
	('0197925001'),
	('0197751001'),
	('0197748001'),
	('0197816001'),
	('0197800001'),
	('0197812001'),
	('0197914001')
GO 

--VERIFICAR SE TABELA COLETAS FOI POPULADA
SELECT * FROM DBProDash.dbo.Coletas

--VERIFICANDO COLETAS REPETIDAS
SELECT 
	coleta, 
	COUNT(*) AS Qtd 
FROM 
	Coletas
GROUP BY 
	coleta
HAVING 
	COUNT(*) > 1

--RESULTADO
--0

--MOSTRANDO CAIXAS QUE NAO FORAM IDENTIFICADAS NA TABELA DE ENTRADA
SELECT
	coleta
FROM
	Coletas
WHERE 
	coleta NOT IN (SELECT coleta FROM FiosEntrada WHERE	coleta IN (SELECT coleta FROM DBProDash.dbo.Coletas))
--RESULTADO
--coleta
--0019799001



--VERIFICANDO COLETA NA TABELA DE ENTRADA - O QUE TENHO DA COLETA QUE ESTÁ NA TABELA DE ENTRADA
SELECT
	*
FROM
	FiosEntrada
WHERE 
	coleta IN (SELECT coleta FROM DBProDash.dbo.Coletas)
--RESULTADO
--39 CAIXAS
	
--VERIFICAR SE EXITE NA COLETA CAIXAS BAIXADAS
SELECT
	*
FROM
	FiosSaida
WHERE 
	coleta IN (SELECT coleta FROM DBProDash.dbo.Coletas)	
--RESULTADO
--0	

--EFETUANDO A BAIXA DA COLETA
INSERT INTO DBProDash.dbo.FiosSaida
		(
			coleta,
			romaneioFiosBaixaProducao
		)
SELECT
	coleta,
	2
FROM
	FiosEntrada
WHERE 
	coleta IN (SELECT coleta FROM Coletas);
	
--MOSTRAR CAIXAS QUE FORAM BAIXADAS DO ESTOQUE DE PRODUCAO
SELECT
	coleta,
	romaneioFiosBaixaProducao
FROM
	FiosSaida
WHERE 
	romaneioFiosBaixaProducao IN (2);
	
--LISTANDO DADOS DO ROMANEIO DE BAIXA
SELECT
	FiosSaida.coleta AS Caixa_Fio,
	FiosEntrada.codigoFio,
	FiosEntrada.tituloFio,
	FiosEntrada.cor,
	FiosEntrada.lote,
	REPLACE(FiosEntrada.pesoLiquido,'.',',') AS Peso_Liquido,
	REPLACE(FiosEntrada.pesoBruto,'.',',') AS Peso_Bruto,
	REPLACE(FiosEntrada.vrUnitario,'.',',') AS vrUnitario,
	Estoques.descricao AS Estoque,
	Destinos.descricao AS Destino,
	FiosSaida.romaneioFiosBaixaProducao AS RomaneioBaixa,
	FiosEntrada.romaneioFiosBaixaMicrodata AS RomaneioMicrodata,
	FiosEntrada.gaveta,
	FiosEntrada.codigoFornecedor,
	FiosEntrada.fornecedor,
	FiosEntrada.documento,
	FiosEntrada.serie,
	FiosEntrada.dataEntrada,
	FiosSaida.dataSaida
FROM
	FiosSaida
	INNER JOIN FiosEntrada ON FiosEntrada.coleta = FiosSaida.coleta 
	INNER JOIN Estoques ON Estoques.codigo = FiosEntrada.estoque 
	INNER JOIN RomaneioFiosBaixaProducao ON RomaneioFiosBaixaProducao.codigo = FiosSaida.romaneioFiosBaixaProducao
	INNER JOIN Destinos ON Destinos.codigo = RomaneioFiosBaixaProducao.destino
WHERE 
	FiosSaida.romaneioFiosBaixaProducao IN (2);

--VERIFICAR ESTOQUE
SELECT
	*
FROM
	FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida )
	
--VERIFICAR ESTOQUE COM REPLACE

SELECT
	coleta,
	codigoFio,
	tituloFio,
	REPLACE(pesoLiquido,'.',',') AS pesoLiquido
FROM
	FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida )
	
--TOTAL DE CAIXAS	
SELECT
	COUNT(coleta) AS qtdCaixas
FROM
	FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida )
	
--PESO TOTAL POR TITULO DE FIO
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
    DBProDash.dbo.FiosEntrada.tituloFio;
--PESO TOTAL 
SELECT
	SUM(pesoLiquido) AS pesoLiquido
FROM
	FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida )	
	

-----------------------FIM------------







--------------------PROCESSO DE BAIXA DE FIOS ESTOQUE DE PRODUCAO---------------------------------
--ROMAENIO Nº3	
--GERA NOVO ROMANEIO DE BAIXA
INSERT INTO RomaneioFiosBaixaProducao
           (destino,operador)
     VALUES
           (1,'ABREU')
GO

--VER QUAL O ÚLTIMO CÓDIGO DE ROMANEIO
SELECT TOP 1 codigo FROM romaneioFiosBaixaProducao ORDER BY codigo DESC;
--RESULTADO
--codigo
--3

--DELETA DADOS DA TABELA COLETA
TRUNCATE TABLE DBProDash.dbo.Coletas;


--ALIMENTANDO TABELA COLETA 
INSERT INTO Coletas
	(
		coleta
	)
VALUES
	('0253115001'),
    ('0200248001'),
	('0200247001'),
	('0200246001'),
	('0200249001'),
	('0200245001'),
	('0200244001'),
	('0200243001'),
	('0200242001'),
	('0200241001'),
	('0200240001'),
	('0200239001'),
	('0200238001'),
	('0200228001'),
	('0200227001'),
	('0200226001'),
	('0200231001'),
	('0200230001'),
	('0200229001'),
	('0200234001'),
	('0200233001'),
	('0200232001'),
	('0200237001'),
	('0200236001'),
	('0200235001'),
	('0200530001'),
	('0200025001'),
	('0200030001'),
	('0200028001'),
	('0200621001'),
	('0200026001'),
	('0200021001'),
	('0200023001'),
	('0200528001'),
	('0200024001'),
	('0200022001'),
	('0200527001'),
	('0200088001'),
	('0200630001'),
	('0200532001'),
	('0200531001'),
	('0200529001'),
	('0200029001'),
	('0200027001'),
	('0200096001'),
	('0200090001'),
	('0200526001'),
	('0200525001'),
	('0200089001'),
	('0200108001'),
	('0200106001'),
	('0200104001'),
	('0200107001'),
	('0200105001'),
	('0200103001'),
	('0200114001'),
	('0200112001'),
	('0200109001'),
	('0200113001'),
	('0200111001'),
	('0200110001'),
	('0200120001'),
	('0200118001'),
	('0200119001'),
	('0200117001'),
	('0200115001'),
	('0200524001'),
	('0200523001'),
	('0200522001'),
	('0200521001'),
	('0200520001'),
	('0200505001'),
	('0200506001'),
	('0200507001'),
	('0000000086'),
	('0200508001'),
	('0200503001'),
	('0200511001'),
	('0200510001'),
	('0200512001'),
	('0200514001'),
	('0200509001'),
	('0200517001'),
	('0200516001'),
	('0200515001'),
	('0200513001'),
	('0200519001'),
	('0200518001'),
	('0200519001'),
	('0200515001'),
	('0200517001'),
	('0200516001'),
	('0200513001'),
	('0200518001'),
	('0200522001'),
	('0200521001'),
	('0200520001'),
	('0200523001'),
	('0200524001');
GO 

--VERIFICANDO COLETAS REPETIDAS
SELECT 
	coleta, 
	COUNT(*) AS Qtd 
FROM 
	Coletas
GROUP BY 
	coleta
HAVING 
	COUNT(*) > 1

--RESULTADO
--coleta	   Qtd
--0200513001	2
--0200515001	2
--0200516001	2
--0200517001	2
--0200518001	2
--0200519001	2
--0200520001	2
--0200521001	2
--0200522001	2
--0200523001	2
--0200524001	2

--MOSTRANDO CAIXAS QUE NAO FORAM IDENTIFICADAS NA TABELA DE ENTRADA
SELECT
	coleta
FROM
	Coletas
WHERE 
	coleta NOT IN (SELECT coleta FROM FiosEntrada WHERE	coleta IN (SELECT coleta FROM DBProDash.dbo.Coletas))
--RESULTADO
--coleta
--0000000086
--0253115001


--VERIFICANDO COLETA NA TABELA DE ENTRADA - O QUE TENHO DA COLETA QUE ESTÁ NA TABELA DE ENTRADA
SELECT
	*
FROM
	FiosEntrada
WHERE 
	coleta IN (SELECT coleta FROM DBProDash.dbo.Coletas)
	
--VERIFICAR SE EXITE NA COLETA CAIXAS BAIXADAS
SELECT
	*
FROM
	FiosSaida
WHERE 
	coleta IN (SELECT coleta FROM DBProDash.dbo.Coletas)	
--RESULTADO
--0	

--EFETUANDO A BAIXA DA COLETA
INSERT INTO DBProDash.dbo.FiosSaida
		(
			coleta,
			romaneioFiosBaixaProducao
		)
SELECT
	coleta,
	3
FROM
	FiosEntrada
WHERE 
	coleta IN (SELECT coleta FROM Coletas);
	
--MOSTRAR CAIXAS QUE FORAM BAIXADAS DO ESTOQUE DE PRODUCAO
SELECT
	coleta,
	romaneioFiosBaixaProducao
FROM
	FiosSaida
WHERE 
	romaneioFiosBaixaProducao IN (3);
	
--LISTANDO DADOS DO ROMANEIO DE BAIXA
SELECT
	FiosSaida.coleta AS Caixa_Fio,
	FiosEntrada.codigoFio,
	FiosEntrada.tituloFio,
	FiosEntrada.cor,
	FiosEntrada.lote,
	REPLACE(FiosEntrada.pesoLiquido,'.',',') AS Peso_Liquido,
	REPLACE(FiosEntrada.pesoBruto,'.',',') AS Peso_Bruto,
	REPLACE(FiosEntrada.vrUnitario,'.',',') AS vrUnitario,
	Estoques.descricao AS Estoque,
	Destinos.descricao AS Destino,
	FiosSaida.romaneioFiosBaixaProducao AS RomaneioBaixa,
	FiosEntrada.romaneioFiosBaixaMicrodata AS RomaneioMicrodata,
	FiosEntrada.gaveta,
	FiosEntrada.codigoFornecedor,
	FiosEntrada.fornecedor,
	FiosEntrada.documento,
	FiosEntrada.serie,
	FiosEntrada.dataEntrada,
	FiosSaida.dataSaida
FROM
	FiosSaida
	INNER JOIN FiosEntrada ON FiosEntrada.coleta = FiosSaida.coleta 
	INNER JOIN Estoques ON Estoques.codigo = FiosEntrada.estoque 
	INNER JOIN RomaneioFiosBaixaProducao ON RomaneioFiosBaixaProducao.codigo = FiosSaida.romaneioFiosBaixaProducao
	INNER JOIN Destinos ON Destinos.codigo = RomaneioFiosBaixaProducao.destino
WHERE 
	FiosSaida.romaneioFiosBaixaProducao IN (3);

--VERIFICAR ESTOQUE
SELECT
	*
FROM
	FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida )
	
--VERIFICAR ESTOQUE COM REPLACE

SELECT
	coleta,
	codigoFio,
	tituloFio,
	REPLACE(pesoLiquido,'.',',') AS pesoLiquido
FROM
	FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida )
	
--TOTAL DE CAIXAS	
SELECT
	COUNT(coleta) AS qtdCaixas
FROM
	FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida )
	
--PESO TOTAL POR TITULO DE FIO
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
    DBProDash.dbo.FiosEntrada.tituloFio;
--PESO TOTAL 
SELECT
	SUM(pesoLiquido) AS pesoLiquido
FROM
	FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida )	
	

-----------------------FIM------------






