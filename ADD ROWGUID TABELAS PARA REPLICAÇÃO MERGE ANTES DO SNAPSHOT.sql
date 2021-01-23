SELECT 'ALTER TABLE ' + NAME + ' add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()'  + CHAR(10) +
'GO' + CHAR(10)
FROM SYS.TABLES
WHERE NAME NOT IN ('sljcfgnf',
'sljdcope',
'sljemp',
'sljope2',
'sljempc',
'sljope',
'sljparac',
'sljparam')
AND NAME NOT LIKE '%BKP%'
AND NAME NOT LIKE 'MS%'
AND NAME NOT LIKE 'SYS%'


