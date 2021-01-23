ENTENDO O RECOVERY no SQL SERVER
Quando o SQL Server� iniciado, cada banco de dados passa por um processo chamado Recovery(ou Restart Recovery), esse Recovery ocorre em duas Fases: UNDO e REDO

REDO (Refazer): Nessa Fase todas as transa��es efetivadas no log de transa��o s�o descarregadas no disco.
O REDO usa a mesma l�gica do processo de CHECKPOINT. Se o o LSN armazenado na pagina � menos ou igual ao LSN do registro de log que est� sendo gravado na pagina,
a alteracao � gravada. Caso contrario ela � pulada, considerada como j� perpetuada no disco.
Quando a Faze REDO termina... inicia-se a fase UNDO.

UNDO (Desfazer): A fase UNDO percorre todo o log de transa��o e invalida qualquer transa��o no lof que ainda esteja aberta, garantindo que uma transa��o nao efetivada
n�o possa ser gravada no disco. Quando a fase UNDO termina, o banco de dados passa por um processo referido como Avan�o(rolling forward).

Quando o SQL passa por esse processo de avan�o, O SQL Server le o ultimo LSN gravado no log de transa��o, incrementa o LSN e grava no cabe�alho de cada aquivo de dados
dentro do banco de dados, garantindo que as transa�oes mais antigas do que o ponto de avan�o nao possam ser gravadas nos arquivos de dados.

Para complementar, quando o SQL Server � iniciado, al�m de fazer todo esse processo de Recovery, ele tamb�m faz um checkDB nos banco de dados, 
validando estrutura dos BDs, tamb�m recria o TemoDB. Detecta CPUs, RAM do servidor. Starta primeiro o Master.