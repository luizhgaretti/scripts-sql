select c.sNome, nomebd,  max(tamanho_MB) as tamanhobd, max(dt_historico) as data
from Tb_MON_Mov_TamanhoBDClientes t
join Tb_MON_Cad_Clientes c on c.ncodigo = t.nCliente and c.flgAtivo = 1
where versao = 'sql2005' and tipo = 'Express Edition'
and snome not like '%vivara%'
and dt_historico between '20120701' and '20120731'
and tamanho_MB > 3000
group by versao, tipo, sNome, nomebd
order by 1 


