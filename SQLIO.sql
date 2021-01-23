-k specifies the type of operation to be performed, W Stands for write, and R stands for read.
-S specifies the numer of seconds for which the test will run.
-f specifies the type of read or write operation to be performed on the test file
-o specifies the I/O requests per thread.
-b specifies the block size using which the test will be performed.
-F specifies the parameter file(its param.txt in our case)
-d specifies the drive to test
-B specifies the buffering to use. "H" denotes hardware buffer to use.
-t specifies the number of threads to use during the test. Here in our case we have used two threads, each doing 1 I/O request at a time(denoted by -o )

From the above output the two most important output to consider is I/O per second and MB/sec.
If you increase the time duration for the test with -s argument, the output will be different.


-> Sequential Read/write: As far as reading and writing performance in terms of disk's is concerned, you need to understand what is sequential read & write.
In sequential read, data is read from ordered or adjacent blocks sequentially, in other words blocks are read one after the other. This kind of read or write is very fast, because the controller head does not require fast movement form one block to another(as all are in order or say one after the other). Same applies for Write.

-> Random Read/Write: The name suggests that blocks from the disk are read which are random. Which means blocks are read from here and there. This of course will be slow, compared to sequential.
Caching in SAN/iSCSI controllers: Almost all SAN and iSCSI controller's employ caching as a mechanism for faster access of highly used data.
In fact it caches most recently used blocks so that no time is required accessing it again. This caching can prevent us from getting accurate results while doing a performance test. The best method to overcome this problem is to use a very large file for read and write, which is larger than the cache.


-- Exemplos
sqlio -kW -s300 -frandom -o32 -b8 -LS -Fparam.txt
sqlio -kR -s300 -frandom -o32 -b8 -LS -Fparam.txt


-- Links
http://www.slashroot.in/microsoft-sqlio-disk-performance-test-and-benchmark-tool
http://www.brentozar.com/archive/2008/09/finding-your-san-bottlenecks-with-sqlio/
http://blogs.msdn.com/b/sqlmeditation/archive/2013/04/04/choosing-what-sqlio-tests-to-run-and-automating-sqlio-testing-somewhat.aspx
https://www.simple-talk.com/sql/database-administration/the-sql-server-sqlio-utility/



Obs: Na pasta SQLIO que é criada no "C:\program file<>86\SQLIO" existe um aquivo param.txt
neste arquivo é configurado o "carga" que será utilizada para analise quando startar o SQL IO
2 0x0 100 = significa que será aberta duas Thread de 100mbs