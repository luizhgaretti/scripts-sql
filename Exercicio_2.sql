2)	Faça uma função chamada fun_consulta_vendedor_mome, para consultar vendedores  usando como parâmetro o nome. Use para fazer a consulta SELECT INTO, e use os exceptions necessários.

create or replace function fun_consulta_vendedor_nome (p_nom_vendedor in vendedor.nom_vendedor%type) return vendedor.nom_vendedor%type is

type vendedor_record is record (codigo vendedor.cod_vendedor%type, nome vendedor.nom_vendedor%type, status vendedor.sta_ativo%type);

x vendedor_record;

begin

if length(p_nom_vendedor) <3 then

raise_application_error (-20300, 'nome deve conter tres ou mais caracteres');

end if;

select * into x from vendedor
where p_nom_vendedor=nom_vendedor;

return x.codigo||' '||x.nome||' '||x.status;

end fun_consulta_vendedor_nome;
/

var teste varchar2(900)
 exec :teste:=fun_consulta_vendedor_nome ('vendedor1');