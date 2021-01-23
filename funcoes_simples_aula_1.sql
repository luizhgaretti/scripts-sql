**______________________________Historico_Pedido_01_______________________**

create or replace function fun_historico_pedido
(p_seq_historico_pedido in historico_pedido.seq_historico_pedido%type)
return  historico_pedido.val_total_pedido%type is

begin

for x in (select val_total_pedido from historico_pedido
where seq_historico_pedido=p_seq_historico_pedido) loop
return x.val_total_pedido;
end loop;
end fun_historico_pedido;
/

**__________________________________Pedido_02____________________________**

create or replace function fun_consulta_pedido
(p_cod_pedido in pedido.cod_pedido%type)
return  pedido.val_total_pedido%type is

begin

for x in (select val_total_pedido from pedido
where cod_pedido=p_cod_pedido) loop
return x.val_total_pedido;
end loop;
end fun_consulta_pedido;
/

**________________________________Cliente_03_____________________________**

create or replace function fun_cliente
(p_cod_cliente in cliente.cod_cliente%type)
Return cliente.nom_cliente%type is

begin

for x in (select nom_cliente from cliente
where cod_cliente=p_cod_cliente) loop
return x.nom_cliente;
end loop;
end fun_cliente;
/

**______________________Endereco_cliente_04______________________________**

create or replace function fun_consulta_endereco_cliente
(p_seq_endereco_cliente in endereco_cliente.seq_endereco_cliente%type)
return  endereco_cliente.sta_ativo%type is

begin

for x in (select sta_ativo from endereco_cliente
where seq_endereco_cliente=p_seq_endereco_cliente) loop
return x.sta_ativo;
end loop;
end fun_consulta_endereco_cliente;
/

**__________________________Produto_05___________________________________**

create or replace function fun_consulta_produto
(p_cod_produto in produto.cod_produto%type)
return  produto.nom_produto%type is

begin

for x in (select nom_produto from produto
where cod_produto=p_cod_produto) loop
return x.nom_produto;
end loop;
end fun_consulta_produto;
/

**__________________________Vendedor_06_________________________________**
create or replace function fun_consulta_produto
(p_cod_produto in produto.cod_produto%type)
return  produto.nom_produto%type is

begin

for x in (select nom_produto from produto
where cod_produto=p_cod_produto) loop
return x.nom_produto;
end loop;
end fun_consulta_produto;
/

**__________________________Tipo_endereco_07____________________________**

create or replace function fun_consulta_tipo_endereco
(p_cod_tipo_endereco in tipo_endereco.cod_tipo_endereco%type)
return  tipo_endereco.des_tipo_endereco%type is

begin

for x in (select des_tipo_endereco from tipo_endereco
where cod_tipo_endereco=p_cod_tipo_endereco) loop
return x.des_tipo_endereco;
end loop;
end fun_consulta_tipo_endereco;
/

**__________________________Usuario_08___________________________________**

create or replace function fun_consulta_usuario
(p_cod_usuario in usuario.cod_usuario%type)
return  usuario.nom_usuario%type is

begin

for x in (select nom_usuario from usuario
where cod_usuario=p_cod_usuario) loop
return x.nom_usuario;
end loop;
end fun_consulta_usuario;
/

**__________________________Cidade_09____________________________________**

create or replace function fun_consulta_cidade
(p_cod_cidade in cidade.cod_cidade%type)
return  cidade.nom_cidade%type is

begin

for x in (select nom_cidade from cidade
where cod_cidade=p_cod_cidade) loop
return x.nom_cidade;
end loop;
end fun_consulta_cidade;
/

**__________________________Consulta_Pais_10_____________________________**

create or replace function fun_consulta_pais
(p_cod_pais in pais.cod_pais%type)
return  pais.nom_pais%type is

begin

for x in (select nom_pais from pais
where cod_pais=p_cod_pais) loop
return x.nom_pais;
end loop;
end fun_consulta_pais;
/

**__________________________Consulta_Estado_11___________________________**

create or replace function fun_consulta_estado
(p_cod_estado in estado.cod_estado%type)
return  estado.nom_estado%type is

begin

for x in (select nom_estado from estado
where cod_estado=p_cod_estado) loop
return x.nom_estado;
end loop;
end fun_consulta_estado;
/

**__________________________Movimento_Estoque_12________________________**

create or replace function fun_consulta_movimento_estoque
(p_seq_movimento_estoque in movimento_estoque.seq_movimento_estoque%type)
return  movimento_estoque.qtd_movimentacao_estoque%type is

begin

for x in (select qtd_movimentacao_estoque from movimento_estoque
where seq_movimento_estoque=p_seq_movimento_estoque) loop
return x.qtd_movimentacao_estoque;
end loop;
end fun_consulta_movimento_estoque;
/

**__________________________Tipo_Movimento_Estoque_13___________________**

create or replace function fun_tipo_movimento_estoque
(p_cod_tipo_movimento_estoque in tipo_movimento_estoque.cod_tipo_movimento_estoque%type)
return  tipo_movimento_estoque.des_tipo_movimento_estoque%type is

begin

for x in (select des_tipo_movimento_estoque from tipo_movimento_estoque
where cod_tipo_movimento_estoque=p_cod_tipo_movimento_estoque) loop
return x.des_tipo_movimento_estoque;
end loop;
end;
/

**___________________________Estoque_14_________________________________**

create or replace function fun_consulta_estoque
(p_cod_estoque in estoque.cod_estoque%type)
return  estoque.nom_estoque%type is

begin

for x in (select nom_estoque from estoque
where cod_estoque=p_cod_estoque) loop
return x.nom_estoque;
end loop;
end fun_consulta_estoque;
/

**_____________________________item_pedido_15____________________________**


create or replace function fun_item_pedido (
 p_cod_pedido in item_pedido.cod_pedido%type,
 p_cod_item_pedido in item_pedido.cod_item_pedido%type)
return item_pedido.qtd_item%type is

begin

for x in (select qtd_item from item_pedido
where cod_pedido=p_cod_pedido and cod_item_pedido=p_cod_item_pedido) loop
return x.qtd_item;
end loop;
end fun_item_pedido;
/

**_________________________estoque_produto_16____________________________**

create or replace function fun_estoque_produto (
  p_cod_produto in estoque_produto.cod_produto%type,
  p_cod_estoque in estoque_produto.cod_estoque%type,
  p_dat_estoque in estoque_produto.dat_estoque%type)
  
return estoque_produto.qtd_produto%type is

begin

for x in (select qtd_produto from estoque_produto
          where cod_produto=p_cod_produto and
                cod_estoque=p_cod_estoque and
                dat_estoque=p_dat_estoque) loop

return x.qtd_produto;

end loop;
end fun_estoque_produto;
/

**_________________________cliente_vendedor_17___________________________**

create or replace function fun_cliente_vendedor (
p_cod_cliente in cliente_vendedor.cod_cliente%type,
p_cod_vendedor in cliente_vendedor.cod_vendedor%type,
p_dat_inicio in cliente_vendedor.dat_inicio%type)

return cliente_vendedor.dat_termino%type is

begin

for x in (select dat_termino from cliente_vendedor
          where
          cod_cliente=p_cod_cliente and
          cod_vendedor=p_cod_vendedor and
          dat_inicio=p_dat_inicio) loop

return x.dat_termino;
end loop;
end fun_cliente_vendedor;
/

**_________________________produto_composto_18__________________________**

create or replace function fun_produto_composto (
p_cod_produto_relacionado in produto_composto.cod_produto_relacionado%type,
p_cod_produto in produto_composto.cod_produto%type)

return produto_composto.qtd_produto%type is

begin

for x in (select qtd_produto from produto_composto
          where
          p_cod_produto_relacionado=cod_produto_relacionado and
          p_cod_produto=cod_produto) loop

return x.qtd_produto;

end loop;
end fun_produto_composto;
/


__________________________________________________________________________



















