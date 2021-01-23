2)	Faça uma função chamada fun_consulta_vendedor_mome, para consultar vendedores  usando como parâmetro o nome. Use para fazer a consulta SELECT INTO, e use os exceptions necessários.

create or replace function fun_consulta_vendedor_mome(p_nom_vendedor in vendedor.nom_vendedor%type) return varchar2 is
	x varchar2(90);
begin
	select cod_vendedor into x from vendedor 
	where nom_vendedor=p_nom_vendedor;
	return x;
exception 
when others then 
	return 'Provavelmente o usuario nao existe';
end;