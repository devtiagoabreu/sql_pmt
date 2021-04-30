SELECT
	ISNULL(COUNT(DISTINCT QtdeDoc),0) AS QtdeDoc,
	ISNULL(SUM(ValorTotal),0) AS ValorTotal,
	vencimento
FROM
	vwFinanceiroContasReceber
WHERE
	vwFinanceiroContasReceber.Vencimento BETWEEN CAST(CAST(GETDATE() - DAY(GETDATE()) + 1 AS DATE) AS DATETIME) AND CAST(EOMONTH(getdate()) AS DATETIME)
GROUP BY
	vencimento