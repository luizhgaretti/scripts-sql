-- Retorna Total por Contador por Dia
Select	MachineName,
		ObjectName,
		CounterName,
		SUBSTRING(CounterDatetime,9,2) + '-' + SUBSTRING(CounterDatetime,6,2) + '-' + SUBSTRING(CounterDatetime,0,5) Data,
		(SUM(CounterValue)/2) Media,
		SUM(CounterValue) Total
		From CounterData C1, CounterDetails C2
Where C1.CounterID = C2.CounterID
--And CounterName = '% Processor Time'
Group by SUBSTRING(CounterDatetime,9,2) + '-' + SUBSTRING(CounterDatetime,6,2) + '-' + SUBSTRING(CounterDatetime,0,5),
		CounterName, MachineName, ObjectName
Order by 1 ASC