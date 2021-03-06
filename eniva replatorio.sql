USE [master]
GO
/****** Object:  StoredProcedure [dbo].[sp_send_rel_replicacao_email]    Script Date: 12/17/2012 16:27:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[sp_send_rel_replicacao_email]
as
begin
  declare @dt_ult_restore datetime
  declare @name char (20)
  declare @corpoemail varchar (4000)

  set @corpoemail = convert(char(20),'Nome da Base') + ' Data do Ultimo Restore
  ' 

  declare c_dt_restore cursor local for 
                                       select
                                         max(restore_date),
                                         destination_database_name
                                       from
                                         msdb..restorehistory rest
                                         inner join master..sysdatabases db on db.name = rest.destination_database_name
                                       group by
                                         destination_database_name
                                       order by 
                                         max(restore_date)

  open c_dt_restore fetch next from c_dt_restore into @dt_ult_restore, @name

  while @@fetch_status = 0
  begin
    set @corpoemail = @corpoemail + @name + ''+ convert(varchar(20),@dt_ult_restore,113)+ '
  '
    fetch next from c_dt_restore into @dt_ult_restore, @name
  end

  close c_dt_restore
  deallocate c_dt_restore

  exec master.dbo.sp_SQLNotify 
     'dba@localcred.com.br',
     'dba@localcred.com.br',
     'Relatorio de Replicação Novo Servidor',
     @corpoemail


end
