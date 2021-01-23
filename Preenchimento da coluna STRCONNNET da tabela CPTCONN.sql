select * from cptconn

begin tran

Update cptconn 
set strconnnet='Data Source=192.168.0.13;Initial Catalog=CEP;Persist Security Info=True;UID=usuarios;Pwd=sistemas;MultipleActiveResultSets=True'
WHERE cidconns = 'cep'   

rollback

commit