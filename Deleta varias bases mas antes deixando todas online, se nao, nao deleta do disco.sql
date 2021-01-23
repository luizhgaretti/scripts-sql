--se tiver que precisa ser deletada e estiver offline, ele deixa online, se nao, ele apenas tira do sql, mas nao deleta do disco
select 		
	   'alter database ' + name + ' set online' + char(10) +
	    'go' + char(10)
		from sys.databases
where name in
('amj01',
'amsterdam',
'Livari',
'tb_home',
'mb_teste',
'cbslj03',
'cbslj01',
'tiffanybr',
'Araslj01',
'tst_pdv',
'tiffanybr_df',
'nature',
'rh_sef_jac',
'dl_Estoque_1',
'dl_Estoque_2',
'AmsSpLj033',
'pdv_vivara',
'pdv_vivara_prod2009',
'pdvVivara',
'ecdcontab',
'vivecdcontab')			

												
--comeca a delecao das bases
select 		
	   'alter database ' + name + ' set single_user with rollback immediate' + char(10) +
       'go' + char(10) +
	   'drop database ' + name + char(10) +
       'go' + char(10)
from sys.databases where name in
('amj01',
'amsterdam',
'Livari',
'tb_home',
'mb_teste',
'cbslj03',
'cbslj01',
'tiffanybr',
'Araslj01',
'tst_pdv',
'tiffanybr_df',
'nature',
'rh_sef_jac',
'dl_Estoque_1',
'dl_Estoque_2',
'AmsSpLj033',
'pdv_vivara',
'pdv_vivara_prod2009',
'pdvVivara',
'ecdcontab',
'vivecdcontab')