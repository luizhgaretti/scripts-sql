declare @cnpj varchar(30)
set @cnpj = '00000000000000'
select substring(@cnpj,1,2) + '.' + substring(@cnpj,3,3) + '.' + substring(@cnpj,6,3) + '/' + substring(@cnpj,9,4) + '-' + substring(@cnpj,13,2)

declare @cpf varchar (30)
set @cpf = '37603831814'
sELECT substring(@cpf,1,3) + '.' + substring(@cpf,4,3) + '.' + substring(@cpf,7,3) + '-' + substring(@cpf,10,2) 
go