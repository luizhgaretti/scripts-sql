Declare @Email VarChar(25),
           @Dominio Varchar(10),
           @TamanhoDominio SmallInt

Set @Email='junior@latexsr.com.br'
Set @TamanhoDominio=(Select PatIndex('%@%',@Email))
Select @Dominio=Substring(@Email,PatIndex('%@%',@Email),CharIndex('.',@Email)-@TamanhoDominio)

If @TamanhoDominio >=2
 Print 'Dom�nio: '+@Dominio+' � v�lido'
Else
Print 'Dom�nio: '+@Dominio+' inv�lido'
