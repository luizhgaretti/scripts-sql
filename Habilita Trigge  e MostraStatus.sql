/*
=======================================================
= Habilta Trigger									  =
= @Enabled = 1 habilita os trigger					  =
= Default 0 - Apenas lista os trigger e seus status.  =
=======================================================
*/

Declare x cursor for select name,parent_obj 
from sysobjects where xtype='TR' 

declare @trname varchar(50) 
declare @enabled int 
declare @st int 
declare @parobj int 
declare @instrucao varchar(200) 
open x 
fetch next from x into @trname,@parobj 

-- Se @enabled = 1 habilita os trigger, Default 0 - apenas lista os trigger e seus status.
SET @enabled = 0
IF @@fetch_status = -1
 print 'Não existe TRIGGER neste Database !' 
ELSE
BEGIN
    while @@fetch_status=0 
    begin 
      set @st=ObjectProperty(Object_ID(@trname),'ExecIsTriggerDisabled') 
      IF @st=1 
          begin 
              IF @enabled = 1
         begin
            print 'O trigger ' + @trname + ' da tabela ' + object_name(@parobj) + ' estava desativado e foi ativado !!' 
             select @instrucao='alter table ' + object_name(@parobj) + ' enable trigger ' + @trname 
               exec(@instrucao) 
  end
       ELSE
      print 'O trigger ' + @trname + ' da tabela ' + object_name(@parobj) + ' está desativado !'  
         end 
      ELSE
         print 'O trigger ' + @trname + ' da tabela ' + object_name(@parobj) + ' está ativado !'  

      fetch next from x into @trname,@parobj 
   end 
END
close x 
deallocate x