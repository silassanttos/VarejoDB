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
