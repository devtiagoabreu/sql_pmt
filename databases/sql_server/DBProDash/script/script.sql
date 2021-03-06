USE [master]
GO
/****** Object:  Database [DBProDash]    Script Date: 05/28/2021 07:21:38 ******/
CREATE DATABASE [DBProDash] ON  PRIMARY 
( NAME = N'DBProDash', FILENAME = N'D:\Microdata\Microdata_SQL\DBProDash.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DBProDash_log', FILENAME = N'D:\Microdata\Microdata_SQL\DBProDash_log.ldf' , SIZE = 3840KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DBProDash].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DBProDash] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [DBProDash] SET ANSI_NULLS OFF
GO
ALTER DATABASE [DBProDash] SET ANSI_PADDING OFF
GO
ALTER DATABASE [DBProDash] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [DBProDash] SET ARITHABORT OFF
GO
ALTER DATABASE [DBProDash] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [DBProDash] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [DBProDash] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [DBProDash] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [DBProDash] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [DBProDash] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [DBProDash] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [DBProDash] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [DBProDash] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [DBProDash] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [DBProDash] SET  DISABLE_BROKER
GO
ALTER DATABASE [DBProDash] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [DBProDash] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [DBProDash] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [DBProDash] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [DBProDash] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [DBProDash] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [DBProDash] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [DBProDash] SET  READ_WRITE
GO
ALTER DATABASE [DBProDash] SET RECOVERY SIMPLE
GO
ALTER DATABASE [DBProDash] SET  MULTI_USER
GO
ALTER DATABASE [DBProDash] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [DBProDash] SET DB_CHAINING OFF
GO
USE [DBProDash]
GO
/****** Object:  Table [dbo].[Estoques]    Script Date: 05/28/2021 07:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Estoques](
	[codigo] [int] IDENTITY(1,1) NOT NULL,
	[descricao] [varchar](60) NOT NULL,
 CONSTRAINT [PK_ESTOQUES] PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Destinos]    Script Date: 05/28/2021 07:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Destinos](
	[codigo] [int] IDENTITY(1,1) NOT NULL,
	[descricao] [varchar](60) NOT NULL,
 CONSTRAINT [PK_DESTINOS] PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Coletas]    Script Date: 05/28/2021 07:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Coletas](
	[coleta] [varchar](20) NOT NULL,
	[data] [datetime] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FiosEntrada]    Script Date: 05/28/2021 07:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FiosEntrada](
	[coleta] [varchar](20) NOT NULL,
	[estoque] [int] NOT NULL,
	[codigoCaixa] [varchar](10) NOT NULL,
	[entradaCaixa] [varchar](3) NOT NULL,
	[romaneioFiosBaixaMicrodata] [varchar](10) NOT NULL,
	[pesoLiquido] [decimal](10, 4) NOT NULL,
	[pesoBruto] [decimal](10, 4) NOT NULL,
	[codigoFio] [varchar](10) NOT NULL,
	[tituloFio] [varchar](255) NOT NULL,
	[cor] [varchar](10) NOT NULL,
	[lote] [varchar](20) NOT NULL,
	[gaveta] [varchar](20) NULL,
	[destino] [varchar](10) NOT NULL,
	[descricaoDestino] [varchar](255) NOT NULL,
	[parcial] [varchar](5) NOT NULL,
	[codigoFornecedor] [varchar](20) NOT NULL,
	[fornecedor] [varchar](255) NOT NULL,
	[documento] [varchar](20) NOT NULL,
	[serie] [varchar](10) NOT NULL,
	[nrPalete] [varchar](10) NULL,
	[vrUnitario] [decimal](10, 4) NOT NULL,
	[dataEntrada] [datetime] NOT NULL,
 CONSTRAINT [PK_FIOSENTRADA] PRIMARY KEY CLUSTERED 
(
	[coleta] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RomaneioFiosBaixaProducao]    Script Date: 05/28/2021 07:21:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RomaneioFiosBaixaProducao](
	[codigo] [int] IDENTITY(1,1) NOT NULL,
	[destino] [int] NOT NULL,
	[operador] [varchar](60) NOT NULL,
	[data] [datetime] NOT NULL,
 CONSTRAINT [PK_ROMANEIOFIOSBAIXAPRODUCAO] PRIMARY KEY CLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[uspSaldoFacionista]    Script Date: 05/28/2021 07:21:40 ******/
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
GO
/****** Object:  View [dbo].[vwBaixaCxsFiosDBMicrodata]    Script Date: 05/28/2021 07:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vwBaixaCxsFiosDBMicrodata]
AS


SELECT
	Ret_BaixaCxsFios.Codigo_Caixa + Ret_BaixaCxsFios.Entrada_Caixa AS coleta,
	Ret_BaixaCxsFios.Codigo_Caixa AS codigoCaixa,
	Ret_BaixaCxsFios.Entrada_Caixa AS entradaCaixa,
	Ret_BaixaCxsFios.Romaneio_Caixa AS romaneioFiosBaixaMicrodata, 
	Ret_BaixaCxsFios.Peso AS pesoLiquido,
	Ret_CxsFios.Peso_Bruto AS pesoBruto, 
	Ret_CxsFios.Produto AS codigoFio,
	Produtos.Descricao AS tituloFio, 
	Ret_CxsFios.Cor AS cor,
	Ret_CxsFios.Lote AS lote,
	Ret_CxsFios.Gaveta,
	Ret_BaixaCxsFios.Destino AS destino, 
	CTE_Destino.Descricao AS descricaoDestino, 
	Ret_BaixaCxsFios.Parcial AS parcial,
	Ret_CxsFios.Fornecedor AS codigoFornecedor,
	Clientes_Principal.Razao_Nome_Cliente AS Fornecedor,
	Ret_CxsFios.Documento AS documento,
	Ret_CxsFios.Serie AS serie, 
	Ret_CxsFios.Nr_palete AS nrPalete, 
	Ret_CxsFios.vr_unitario AS vrUnitario
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
	Clientes_Principal.Tipo = '0';
GO
/****** Object:  View [dbo].[vwSaldoRetornoFiosFacionista]    Script Date: 05/28/2021 07:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vwSaldoRetornoFiosFacionista]
AS

SELECT
	Fat_Facionista.Nota_Fiscal,
	Fat_Facionista.Produto,
	Produtos.Descricao,
	Fat_Facionista.Facionista,
	clientes_principal.Razao_Nome_Cliente AS Nome,
	SUM(ISNULL(Fat_Facionista.PESO,0)) AS Peso,
	'RETORNO' AS TIPO	
FROM
	DBMicrodata.dbo.Fat_Facionista
	INNER JOIN DBMicrodata.dbo.Produtos ON  DBMicrodata.dbo.Produtos.Codigo = DBMicrodata.dbo.Fat_Facionista.Produto
	INNER JOIN DBMicrodata.dbo.clientes_principal ON clientes_principal.Codigo_Cliente = Fat_Facionista.Facionista
WHERE
	DBMicrodata.dbo.Fat_Facionista.Tipo = '2' 
	--AND
	--Fat_Facionista.DataEmissao IS NOT NULL AND
	--Fat_Facionista.Nota_Retorno IS NOT NULL OR 
	--Fat_Facionista.Nota_Retorno <> ''   
GROUP BY
	Fat_Facionista.Nota_Fiscal,
	Fat_Facionista.Facionista,
	clientes_principal.Razao_Nome_Cliente,
	DBMicrodata.dbo.Fat_Facionista.Produto,
	DBMicrodata.dbo.Produtos.Descricao;
GO
/****** Object:  View [dbo].[vwSaldoRemessaFiosFacionista]    Script Date: 05/28/2021 07:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vwSaldoRemessaFiosFacionista]
AS

SELECT
	Fat_Facionista.Nota_Fiscal,
	Fat_Facionista.Produto,
	Produtos.Descricao,
	Fat_Facionista.Facionista,
	clientes_principal.Razao_Nome_Cliente AS Nome,
	SUM(ISNULL(DBMicrodata.dbo.Fat_Facionista.PESO,0)) AS Peso,
	'REMESSA' AS TIPO
FROM
	DBMicrodata.dbo.Fat_Facionista
	INNER JOIN DBMicrodata.dbo.Produtos ON  DBMicrodata.dbo.Produtos.Codigo = DBMicrodata.dbo.Fat_Facionista.Produto
	INNER JOIN DBMicrodata.dbo.clientes_principal ON clientes_principal.Codigo_Cliente = Fat_Facionista.Facionista
WHERE
	Fat_Facionista.Tipo = '1' 
	--AND
	--Fat_Facionista.DataEmissao IS NOT NULL AND
	--Fat_Facionista.Nota_Retorno IS NULL OR 
	--Fat_Facionista.Nota_Retorno = ''             
GROUP BY
	Fat_Facionista.Nota_Fiscal,
	Fat_Facionista.Facionista,
	clientes_principal.Razao_Nome_Cliente,
	Fat_Facionista.Produto,
	Produtos.Descricao;
GO
/****** Object:  Table [dbo].[FiosSaida]    Script Date: 05/28/2021 07:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FiosSaida](
	[coleta] [varchar](20) NOT NULL,
	[romaneioFiosBaixaProducao] [int] NOT NULL,
	[dataSaida] [datetime] NOT NULL,
 CONSTRAINT [PK_FIOSSAIDA] PRIMARY KEY CLUSTERED 
(
	[coleta] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vwFiosRemessaRetornoFacionista]    Script Date: 05/28/2021 07:21:40 ******/
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
/****** Object:  StoredProcedure [dbo].[uspEntradaEstoqueProducao]    Script Date: 05/28/2021 07:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Tiago de Abreu>
-- Description:	<Entrar com Romaneio de Baixa Microdata em estoque de producao>
-- =============================================
CREATE PROCEDURE [dbo].[uspEntradaEstoqueProducao] 
	
-- TIPO: 1 (ROMANEIO) TIPO:2 (COLETA)
@tipo char(1),
@romaneio varchar(20),
@estoque integer
   
AS
BEGIN

--DECLARE
	
	
BEGIN TRY
BEGIN TRAN tranEntradaEstoqueProducao
--verificação se o romaneio de baixa existe
	IF (NOT EXISTS(SELECT TOP 1 romaneioFiosBaixaMicrodata FROM vwBaixaCxsFiosDBMicrodata WHERE romaneioFiosBaixaMicrodata = @romaneio)) 
		RAISERROR('ESTE ROMANEIO NÃO EXISTE!',14,1);
		
	IF(@tipo='1')
	BEGIN
	
		INSERT INTO DBProDash.dbo.FiosEntrada
		(
			coleta,
			estoque,
			codigoCaixa,
			entradaCaixa,
			romaneioFiosBaixaMicrodata, 
			pesoLiquido,
			pesoBruto, 
			codigoFio,
			tituloFio, 
			cor,
			lote,
			Gaveta,
			destino, 
			descricaoDestino, 
			parcial,
			codigoFornecedor,
			Fornecedor,
			documento,
			serie, 
			nrPalete, 
			vrUnitario
		)
				
			SELECT
				coleta,
				@estoque,
				codigoCaixa,
				entradaCaixa,
				romaneioFiosBaixaMicrodata, 
				pesoLiquido,
				pesoBruto, 
				codigoFio,
				tituloFio, 
				cor,
				lote,
				Gaveta,
				destino, 
				descricaoDestino, 
				parcial,
				codigoFornecedor,
				Fornecedor,
				documento,
				serie, 
				nrPalete, 
				vrUnitario
			FROM
				vwBaixaCxsFiosDBMicrodata
			WHERE 
				romaneioFiosBaixaMicrodata = @romaneio
		
		
	END

COMMIT TRAN tranEntradaEstoqueProducao
END TRY
BEGIN CATCH
	ROLLBACK TRAN tranEntradaEstoqueProducao
	SELECT ERROR_MESSAGE() AS Retorno;
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[uspSaldoTotalEstoqueFioVereador]    Script Date: 05/28/2021 07:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Tiago de Abreu>
-- Description:	<Saldo de fios do estoque da rua vereador>
-- =============================================
CREATE PROCEDURE [dbo].[uspSaldoTotalEstoqueFioVereador] 
  
AS
BEGIN

SELECT
	SUM(pesoLiquido) AS PesoTotalFios
FROM
	FiosEntrada
WHERE
	FiosEntrada.coleta NOT IN ( SELECT coleta FROM FiosSaida );
END
GO
/****** Object:  StoredProcedure [dbo].[uspSaldoEstoqueFioVereador]    Script Date: 05/28/2021 07:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Tiago de Abreu>
-- Description:	<Saldo de fios do estoque da rua vereador>
-- =============================================
CREATE PROCEDURE [dbo].[uspSaldoEstoqueFioVereador] 
  
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
GO
/****** Object:  StoredProcedure [dbo].[uspSaidaEstoqueProducao]    Script Date: 05/28/2021 07:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Tiago de Abreu>
-- Description:	<Sair com coleta de caixas do estoque de producao>
-- =============================================
CREATE PROCEDURE [dbo].[uspSaidaEstoqueProducao] 
	
@romaneioFiosBaixaProducao INT

AS
BEGIN
	
BEGIN TRY
BEGIN TRAN tranSaidaEstoqueProducao

	INSERT INTO DBProDash.dbo.FiosSaida
		(
			coleta,
			romaneioFiosBaixaProducao 
			
		)
				
			SELECT
				coleta,
				@romaneioFiosBaixaProducao
			FROM
				FiosEntrada
			WHERE 
				coleta IN (SELECT coletas FROM coleta)
		

COMMIT TRAN tranSaidaEstoqueProducao
END TRY
BEGIN CATCH
	ROLLBACK TRAN tranSaidaEstoqueProducao
	SELECT ERROR_MESSAGE() AS Retorno;
END CATCH
END
GO
/****** Object:  Default [DF__Coleta__data__48CFD27E]    Script Date: 05/28/2021 07:21:39 ******/
ALTER TABLE [dbo].[Coletas] ADD  DEFAULT (getdate()) FOR [data]
GO
/****** Object:  Default [DF__FiosEntra__dataE__38996AB5]    Script Date: 05/28/2021 07:21:39 ******/
ALTER TABLE [dbo].[FiosEntrada] ADD  DEFAULT (getdate()) FOR [dataEntrada]
GO
/****** Object:  Default [DF__RomaneioFi__data__3E52440B]    Script Date: 05/28/2021 07:21:39 ******/
ALTER TABLE [dbo].[RomaneioFiosBaixaProducao] ADD  DEFAULT (getdate()) FOR [data]
GO
/****** Object:  Default [DF__FiosSaida__dataS__3B75D760]    Script Date: 05/28/2021 07:21:40 ******/
ALTER TABLE [dbo].[FiosSaida] ADD  DEFAULT (getdate()) FOR [dataSaida]
GO
/****** Object:  ForeignKey [FiosEntrada_fk0]    Script Date: 05/28/2021 07:21:39 ******/
ALTER TABLE [dbo].[FiosEntrada]  WITH CHECK ADD  CONSTRAINT [FiosEntrada_fk0] FOREIGN KEY([estoque])
REFERENCES [dbo].[Estoques] ([codigo])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[FiosEntrada] CHECK CONSTRAINT [FiosEntrada_fk0]
GO
/****** Object:  ForeignKey [RomaneioFiosBaixaProducao_fk0]    Script Date: 05/28/2021 07:21:39 ******/
ALTER TABLE [dbo].[RomaneioFiosBaixaProducao]  WITH CHECK ADD  CONSTRAINT [RomaneioFiosBaixaProducao_fk0] FOREIGN KEY([destino])
REFERENCES [dbo].[Destinos] ([codigo])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[RomaneioFiosBaixaProducao] CHECK CONSTRAINT [RomaneioFiosBaixaProducao_fk0]
GO
/****** Object:  ForeignKey [FiosSaida_fk0]    Script Date: 05/28/2021 07:21:40 ******/
ALTER TABLE [dbo].[FiosSaida]  WITH CHECK ADD  CONSTRAINT [FiosSaida_fk0] FOREIGN KEY([coleta])
REFERENCES [dbo].[FiosEntrada] ([coleta])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[FiosSaida] CHECK CONSTRAINT [FiosSaida_fk0]
GO
/****** Object:  ForeignKey [FiosSaida_fk1]    Script Date: 05/28/2021 07:21:40 ******/
ALTER TABLE [dbo].[FiosSaida]  WITH CHECK ADD  CONSTRAINT [FiosSaida_fk1] FOREIGN KEY([romaneioFiosBaixaProducao])
REFERENCES [dbo].[RomaneioFiosBaixaProducao] ([codigo])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[FiosSaida] CHECK CONSTRAINT [FiosSaida_fk1]
GO
/****** Object:  ForeignKey [FiosSaida_fk2]    Script Date: 05/28/2021 07:21:40 ******/
ALTER TABLE [dbo].[FiosSaida]  WITH CHECK ADD  CONSTRAINT [FiosSaida_fk2] FOREIGN KEY([romaneioFiosBaixaProducao])
REFERENCES [dbo].[RomaneioFiosBaixaProducao] ([codigo])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FiosSaida] CHECK CONSTRAINT [FiosSaida_fk2]
GO
