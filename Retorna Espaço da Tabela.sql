Execute sp_espacotabela 

Create Procedure sp_espacotabela 
as 
  
/* 
  Fabiano Cores 02.12.2010 
  http://sqlburger.blogspot.com 
*/
  
  Declare @vname sysname 
  Declare @tmpTamTabela table 
	( 
		name		sysname     null,
		rows		int         null,
		reserved	varchar(25) null,
		data		varchar(25) null,
		index_size	varchar(25) null,
		unused		varchar(25) null ) 
  
  Declare cp1 cursor local fast_forward read_only for 
    select name from sysobjects 
     where type = 'U' 
     order by name 
  
  open cp1 
  
  while 1 = 1 
  begin 
    fetch next from cp1 into @vname 
    if @@fetch_status <> 0 break 
  
    insert into @tmpTamTabela (name, rows, reserved 
                             , data, index_size, unused) 
      exec sp_spaceused @vname 
  
  end 
  close cp1 
  deallocate cp1 
  
  select name as 'Nome' 
       , rows as 'Linhas' 
       , convert(int, replace(reserved, ' KB','')) as 'Tamanho total' 
       , convert(int, replace(data, ' KB',''))as 'Dados' 
       , convert(int, replace(index_size, ' KB',''))as 'Index' 
       , convert(int, replace(unused, ' KB',''))as 'Não utilizado' 
    from @tmpTamTabela 
   order by convert(int, replace(reserved, ' KB','')) desc 