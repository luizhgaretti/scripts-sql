SELECT TABLE_NAME, COLUMN_NAME, COLLATION_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'sljpro' and column_name = 'dsccompras'

/****************************************************************************/

Select 
case 
	when CAST(c.dsccompras AS CHAR(200)) COLLATE SQL_Latin1_General_CP1_CI_AS = '' 
		then CAST(c.DscCompras as char(200)) COLLATE SQL_Latin1_General_CP1_CI_AS 
			else b.Dpros 
end as dpros
From SljEest a 
LEFT Join SljEesti b on b.EmpDopNums = a.EmpDopNums 
Join SljOpe o on o.Dopes = a.Dopes 
LEFT Join SljPro c on c.cPros = b.cPros 
Left Join SljNFis d on d.EmpDopNums = a.EmpDopNums 
Left Join sljsts s On s.cods = a.pstatus 
Left Join sljevent v On v.codevents = a.codevents 
Left Join SljDcRf r On r.IdDcRfs = b.IdDcRfs 
Where a.Datas BetWeen '20120401' And '20120430' And a.Emps = 'ESC' 
And a.Dopes = 'DISTRIBUICAO        '   
And (b.Qtds >= 0 Or b.Qtds is null) And a.numes Between 1 And 1000  
--And c.CGrus in ('SC I01') And c.Mercs in ('BIJ') And c.Linhas in ('          ')

/****************************************************************************/

alter table sljpro alter column dsccompras text collate SQL_Latin1_General_CP1_CI_AS