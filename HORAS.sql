use horas
go

select 
		data,
		func,
		inicio,
		almoco,
		retorno,
		termino,
		cast(almoco as datetime) - cast(inicio as datetime) as antes_almoco,
		cast(termino as datetime) - cast(retorno as datetime) as pos_almoco,
		((cast(almoco as datetime) - cast(inicio as datetime))) + (cast(termino as datetime) - cast(retorno as datetime)) as total_horas_trabalhadas
		--datepart(hour,((cast(almoco as datetime) - cast(inicio as datetime))) + (cast(termino as datetime) - cast(retorno as datetime)) - @total_h_diarias) as t_horas,
		--datepart(mi,((cast(almoco as datetime) - cast(inicio as datetime))) + (cast(termino as datetime) - cast(retorno as datetime)) - @total_h_diarias) as t_minutos
		into #horas
from pladia
where func = 'nelson'
and 		
		data between '2012-12-01' and '2012-12-31'

declare @total_h_diarias datetime
declare @data datetime 
set @total_h_diarias = '1900-01-01 08:00:00.000'
set @data = CAST(FLOOR(CAST(getdate() AS FLOAT)) AS DATETIME)
select 
		data, 
		func, 
		inicio, 
		almoco, 
		retorno, 
		termino, 
		antes_almoco, 
		pos_almoco, 
		total_horas_trabalhadas,
		case 
			when datepart(hour,total_horas_trabalhadas) < 8 
				then total_horas_trabalhadas
            --caso ainda vc nao fechou o dia, nao calcula esse dia, so vai ser calculado, quando fechar o dia corrente 
			when termino = '00:00' then data - @data
			--caso for sabado ou domingo, ele nao subtrai 8h, mas soma tudo
			when datename(WEEKDAY,data) = 'sunday' or datename(WEEKDAY,data) = 'saturday' then data + total_horas_trabalhadas
					else total_horas_trabalhadas - @total_h_diarias 

			end as horas_excedentes
		into #horas_extras
		from #horas
		
		select * from #horas

		select 
				CAST(SUM(DATEPART(HOUR,horas_excedentes)) + SUM(DATEPART(MINUTE,horas_excedentes))/60 AS VARCHAR) + 'H' + ':' + 
	CAST(SUM(DATEPART(MINUTE,horas_excedentes))%60 AS VARCHAR) + 'MIN' AS TOTAL_HORAS_EXTRAS
		from #horas_extras
	
drop table #horas
drop table #horas_extras


