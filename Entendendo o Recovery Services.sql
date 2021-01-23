ENTENDO O RECOVERY no SQL SERVER
Quando o SQL Serveré iniciado, cada banco de dados passa por um processo chamado Recovery(ou Restart Recovery), esse Recovery ocorre em duas Fases: UNDO e REDO

REDO (Refazer): Nessa Fase todas as transações efetivadas no log de transação são descarregadas no disco.
O REDO usa a mesma lógica do processo de CHECKPOINT. Se o o LSN armazenado na pagina é menos ou igual ao LSN do registro de log que está sendo gravado na pagina,
a alteracao é gravada. Caso contrario ela é pulada, considerada como já perpetuada no disco.
Quando a Faze REDO termina... inicia-se a fase UNDO.

UNDO (Desfazer): A fase UNDO percorre todo o log de transação e invalida qualquer transação no lof que ainda esteja aberta, garantindo que uma transação nao efetivada
não possa ser gravada no disco. Quando a fase UNDO termina, o banco de dados passa por um processo referido como Avanço(rolling forward).

Quando o SQL passa por esse processo de avanço, O SQL Server le o ultimo LSN gravado no log de transação, incrementa o LSN e grava no cabeçalho de cada aquivo de dados
dentro do banco de dados, garantindo que as transaçoes mais antigas do que o ponto de avanço nao possam ser gravadas nos arquivos de dados.

Para complementar, quando o SQL Server é iniciado, além de fazer todo esse processo de Recovery, ele também faz um checkDB nos banco de dados, 
validando estrutura dos BDs, também recria o TemoDB. Detecta CPUs, RAM do servidor. Starta primeiro o Master.