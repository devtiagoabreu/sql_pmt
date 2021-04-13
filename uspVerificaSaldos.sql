USE [DBPromoda]
GO
/****** Object:  StoredProcedure [dbo].[uspVerificaSaldos]    Script Date: 04/13/2021 14:26:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Tiago de Abreu>
-- Description:	<VERIFICAR SALDOS>
-- =============================================
ALTER PROCEDURE [dbo].[uspVerificaSaldos] 
	
@Leitura VARCHAR(255)

AS
BEGIN

DECLARE

@ProdutoCodigo VARCHAR(10),
@Situacao VARCHAR(10),
@Cor VARCHAR(10),
@Desenho VARCHAR(10),
@Variante VARCHAR(10),
@Categoria VARCHAR(10),
@Metros NUMERIC(18,5),
@SaldoEstoquePrimeira NUMERIC(18,5),
@SaldoEstoqueSegunda NUMERIC(18,5),
@SaldoBeneficiamento NUMERIC(18,5),
@SaldoCarteira NUMERIC(18,5)

 
SET @ProdutoCodigo = (SELECT Produto FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@Leitura, 1, 13))); 
SET @Situacao = (SELECT Situacao FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@Leitura, 1, 13))); 
SET @Cor = (SELECT Cor FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@Leitura, 1, 13))); 
SET @Desenho = (SELECT Desenho FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@Leitura, 1, 13))); 
SET @Variante = (SELECT Variante FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@Leitura, 1, 13))); 
SET @Categoria = (SELECT Categoria_Tinto FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@Leitura, 1, 13))); 
SET @Metros = (SELECT Metros FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@Leitura, 1, 13))); 
SET @SaldoEstoquePrimeira = (SELECT Metros FROM vwSaldoTecidosEstoque WHERE ProdutoCodigo = @ProdutoCodigo AND Situacao = @Situacao AND Cor = @Cor AND Desenho = @Desenho AND Variante = @Variante AND Categoria = '01');
SET @SaldoEstoqueSegunda = (SELECT Metros FROM vwSaldoTecidosEstoque WHERE ProdutoCodigo = @ProdutoCodigo AND Situacao = @Situacao AND Cor = @Cor AND Desenho = @Desenho AND Variante = @Variante AND Categoria = '02');
SET @SaldoBeneficiamento = (SELECT Metros FROM vwSaldoTecidosBeneficiamento WHERE ProdutoCodigo = @ProdutoCodigo AND Situacao = @Situacao AND Cor = @Cor AND Desenho = @Desenho AND Variante = @Variante);
SET @SaldoCarteira = (SELECT Metros FROM vwSaldoTecidosCarteira WHERE ProdutoCodigo = @ProdutoCodigo AND Situacao = @Situacao AND Cor = @Cor AND Desenho = @Desenho AND Variante = @Variante);

SELECT
	ISNULL(@ProdutoCodigo,0) AS Produto,
	ISNULL(@Situacao,0) AS Situacao,
	ISNULL(@Cor,0) AS Cor,
	ISNULL(@Desenho,0) AS Desenho,
	ISNULL(@Variante,0) AS Variante,
	ISNULL(@Categoria,0) AS Categoria,
	ISNULL(@Metros,0) AS Metros,
	ISNULL(@SaldoEstoquePrimeira,0) AS SaldoEstoquePrimeira,
	ISNULL(@SaldoEstoqueSegunda,0) AS SaldoEstoqueSegunda,
	ISNULL(@SaldoBeneficiamento,0) AS SaldoBeneficiamento,
	ISNULL(@SaldoCarteira,0) AS SaldoCarteira,
	(ISNULL(@SaldoEstoquePrimeira,0) + ISNULL(@SaldoBeneficiamento,0) - ISNULL(@SaldoCarteira,0)) AS Necessidade;




	
	
	


END
