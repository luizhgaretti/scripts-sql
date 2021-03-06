use lobv
SELECT TOP (1)*
FROM 	TBFONE
WHERE LEN(NR_TELEFONE) > 8


INSERT INTO TBFONE (NR_CPF_CNPJ,NR_DDD,NR_TELEFONE)
VALUES ('00024979257801','11', '64869773')  


SELECT *
FROM TBFONE
WHERE NR_CPF_CNPJ = '00024979257801'

BEGIN TRAN
DELETE tbfone FROM tbfone AS TB2 WHERE RECNUM = (SELECT --A.RECNUM AS REC,
								--A.NR_TELEFONE,
								B.RECNUM,
								--B.NR_TELEFONE, 
								CASE WHEN LEN(A.NR_TELEFONE) = 8 THEN A.RECNUM 
									ELSE B.RECNUM 
										END 
							  FROM TBFONE AS A
							  INNER JOIN TBFONE AS B
							  ON SUBSTRING(A.NR_TELEFONE,2,8) = B.NR_TELEFONE
							  AND A.NR_DDD = B.NR_DDD
							  AND A.NR_CPF_CNPJ = B.NR_CPF_CNPJ
							  WHERE A.NR_DDD = '11')
							  