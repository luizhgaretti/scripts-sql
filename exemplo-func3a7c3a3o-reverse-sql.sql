Declare @Texto VarChar(100)

Set @Texto = 'Este � um pequeno texto para exemplificar a utiliza��o da fun��o Reverse'

Print 'Texto Normal'+Char(13)+@Texto


Print 'Texto Invertido'+Char(13)+Reverse(@Texto)