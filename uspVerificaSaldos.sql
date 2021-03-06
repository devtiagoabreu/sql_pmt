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
	
@leitura VARCHAR(255)

AS
BEGIN

	DECLARE

	@ProdutoCodigo VARCHAR(10),
	@Situacao VARCHAR(10),
	@Cor VARCHAR(10),
	@Desenho VARCHAR(10),
	@Variante VARCHAR(10),
	@Categoria VARCHAR(10),
	@Metros NUMERIC(18,2),
	@SaldoEstoquePrimeira NUMERIC(18,2),
	@SaldoEstoquePrimeiraCru NUMERIC(18,2),
	@SaldoEstoqueSegunda NUMERIC(18,2),
	@SaldoBeneficiamento NUMERIC(18,2),
	@SaldoCarteira NUMERIC(18,2),
	@Necessidade NUMERIC(18,2),
	@ProntaEntrega NUMERIC(18,2),
	@Retorno VARCHAR(500)

	BEGIN TRY
		
		IF (NOT EXISTS(SELECT ISNULL(Produto,0) FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@leitura, 1, 13))))
			RAISERROR('OPS! ESTA PEÇA JÁ FOI BAIXADA, DELETADA OU NÃO EXISTE!',14,1);
		 
		SET @ProdutoCodigo = (SELECT ISNULL(Produto,0) FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@leitura, 1, 13))); 
		SET @Situacao = (SELECT ISNULL(Situacao,0) FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@leitura, 1, 13))); 
		SET @Cor = (SELECT ISNULL(Cor,0) FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@leitura, 1, 13))); 
		SET @Desenho = (SELECT ISNULL(Desenho,0) FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@leitura, 1, 13))); 
		SET @Variante = (SELECT ISNULL(Variante,0) FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@leitura, 1, 13))); 
		SET @Categoria = (SELECT ISNULL(Categoria_Tinto,0) FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@leitura, 1, 13))); 
		SET @Metros = (SELECT ISNULL(Metros,0) FROM DBMicrodata.dbo.Cte_Peca WHERE Nro_Rolo+Nro_Peca = (SELECT SUBSTRING(@leitura, 1, 13))); 
		SET @SaldoEstoquePrimeira = (SELECT ISNULL(Metros,0) FROM vwSaldoTecidosEstoque WHERE ProdutoCodigo = @ProdutoCodigo AND Situacao = @Situacao AND Cor = @Cor AND Desenho = @Desenho AND Variante = @Variante AND Categoria = '01');
		SET @SaldoEstoquePrimeiraCru = (SELECT ISNULL(Metros,0) FROM vwSaldoTecidosEstoque WHERE ProdutoCodigo = @ProdutoCodigo AND Situacao = '000' AND Categoria = '01');
		SET @SaldoEstoqueSegunda = (SELECT ISNULL(Metros,0) FROM vwSaldoTecidosEstoque WHERE ProdutoCodigo = @ProdutoCodigo AND Situacao = @Situacao AND Cor = @Cor AND Desenho = @Desenho AND Variante = @Variante AND Categoria = '02');
		SET @SaldoBeneficiamento = (SELECT ISNULL(Metros,0) FROM vwSaldoTecidosBeneficiamento WHERE ProdutoCodigo = @ProdutoCodigo AND Situacao = @Situacao AND Cor = @Cor AND Desenho = @Desenho AND Variante = @Variante);
		SET @SaldoCarteira = (SELECT ISNULL(Metros,0) FROM vwSaldoTecidosCarteira WHERE ProdutoCodigo = @ProdutoCodigo AND Situacao = @Situacao AND Cor = @Cor AND Desenho = @Desenho AND Variante = @Variante);
		SET @ProntaEntrega = (SELECT (ISNULL(@SaldoEstoquePrimeira,0)+ISNULL(@SaldoBeneficiamento,0)));
		
		
		IF (@SaldoCarteira > 0) AND (@SaldoCarteira > @ProntaEntrega)
		BEGIN
			SET @Necessidade = (ISNULL(@SaldoCarteira,0) - (ISNULL(@SaldoEstoquePrimeira,0) + ISNULL(@SaldoBeneficiamento,0)));
		END
		ELSE 
		BEGIN
			SET @Necessidade = 0;
		END	

		SET @Retorno = (SELECT  'PRODUTO: ' + CAST(ISNULL(@ProdutoCodigo,0) AS VARCHAR(20)) + '/SITUAÇÃO: ' + CAST(ISNULL(@Situacao,0) AS VARCHAR(20)) + '/COR: ' + CAST(ISNULL(@Cor,0) AS VARCHAR(20)) + '/DESENHO: ' + CAST(ISNULL(@Desenho,0) AS VARCHAR(20)) + '/VARIANTE: ' +  CAST(ISNULL(@Variante,0) AS VARCHAR(20)) + '/CATEGORIA: ' + CAST(ISNULL(@Categoria,0) AS VARCHAR(20)) + '/METROS: ' + REPLACE(CAST(ISNULL(@Metros,0) AS VARCHAR(20)),'.',',') + '/ESTOQUE 1ª: ' + REPLACE(CAST(ISNULL(@SaldoEstoquePrimeira,0) AS VARCHAR(20)),'.',',') + '/ESTOQUE CRU: ' + REPLACE(CAST(ISNULL(@SaldoEstoquePrimeiraCru,0) AS VARCHAR(20)),'.',',') + '/ESTOQUE 2ª: ' + REPLACE(CAST(ISNULL(@SaldoEstoqueSegunda,0) AS VARCHAR(20)),'.',',') + '/BENEFICIAMENTO: ' + REPLACE(CAST(ISNULL(@SaldoBeneficiamento,0) AS VARCHAR(20)),'.',',') + '/CARTEIRA: ' + REPLACE(CAST(ISNULL(@SaldoCarteira,0) AS VARCHAR(20)),'.',',') + '/NECESSIDADE: ' + REPLACE(CAST(ISNULL(@Necessidade,0) AS VARCHAR(20)),'.',','));
			
		SELECT @Retorno AS Retorno;
		
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS Retorno;
	END CATCH

END
