CREATE TABLE teste01 (numero NUMBER(3),
                      letra  VARCHAR2(3));

CREATE TABLE teste02 (numero NUMBER(3),
                      letra  VARCHAR2(3));

INSERT INTO teste01 VALUES(1,'A');
INSERT INTO teste01 VALUES(2,'B');
INSERT INTO teste01 VALUES(3,'C');
INSERT INTO teste01 VALUES(4,'D');
INSERT INTO teste01 VALUES(5,'E');
INSERT INTO teste01 VALUES(6,'F');
INSERT INTO teste01 VALUES(7,'G');
INSERT INTO teste01 VALUES(8,'H');
INSERT INTO teste01 VALUES(9,'I');
INSERT INTO teste01 VALUES(10,'J');
INSERT INTO teste01 VALUES(11,'L');
INSERT INTO teste01 VALUES(12,'M');
INSERT INTO teste01 VALUES(13,'N');
INSERT INTO teste01 VALUES(14,'O');
INSERT INTO teste01 VALUES(15,'P');
INSERT INTO teste01 VALUES(16,'Q');
INSERT INTO teste01 VALUES(17,'R');
INSERT INTO teste01 VALUES(18,'S');
INSERT INTO teste01 VALUES(19,'T');
INSERT INTO teste01 VALUES(20,'U');

commit;

select * from teste01;
select * from teste02;

MERGE INTO teste02 b
USING (
   SELECT numero, letra
			  FROM teste01 ) a
ON (b.numero = a.numero)
WHEN MATCHED THEN
   UPDATE SET b.letra = a.letra
WHEN NOT MATCHED THEN
   INSERT (b.numero, b.letra)	VALUES (a.numero, a.letra);		

commit;   

select * from teste01;
select * from teste02;
							