Fa�a o seguinte:

 

1 - Dentro do banco Master.

 

2 - Select @@ServerName --> ser� exibido o nome do servidor.

 

3 - sp_dropserver 'NomeAntigodoServidor'

 

4 - sp_addserver 'NovoNomedoServidor', LOCAL

 

5 - Reinicialize o seu servidor.

 

6 - Entre no Query Analyzer, se conectando ao servidor local.

 

7 - Select @@ServerName --> dever� ser exibido o novo nome especificado para o servidor.

 

Obs: N�o se esque�a de colocar no final da linha de comando da sp_addserver a palavra LOCAL, para especificar como servidor local.
