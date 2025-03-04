CREATE FUNCTION DBO.FN_CalculoLucro(
@preco decimal(15,2),
@custo decimal(15,2),
@tipo char(1) --'B' lucro bruto , 'M' margem de lucro
)
RETURNS DECIMAL (15,2)
AS
BEGIN
	DECLARE @RESULTADO DECIMAL(15,2);

IF UPPER(@tipo) = 'B'
BEGIN
	SET @RESULTADO = @preco - @custo;
END
ELSE IF UPPER(@tipo) = 'M'
BEGIN
	SET @RESULTADO = ((@preco - @custo) / @preco) * 100;
END
 RETURN @RESULTADO
end 





--SELECT 
--	nome AS [Nome do produto],
--	preco as [preço de venda],
--	custo,
--	preco - custo as [lucro bruto],
--    dbo.FN_CalculoLucro(preco, custo, 'B') AS [Lucro Bruto (Função)],
--    CONVERT(DECIMAL(15,2), ((preco - custo) / preco) * 100) AS [Margem de Lucro (%) Calculada],
--    dbo.FN_CalculoLucro(preco, custo, 'M') AS [Margem de Lucro (%) (Função)]
--	 FROM Produtos

