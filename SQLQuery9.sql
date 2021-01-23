select  top 1 *
from Andamento_da_Cobranca fhis 
inner join Contratos fdiv 
on fdiv.NumeroContrato = fhis.NumeroContrato

