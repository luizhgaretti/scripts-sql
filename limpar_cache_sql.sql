	CHECKPOINT; 
	GO 
	DBCC DROPCLEANBUFFERS
	GO
	DBCC FREEPROCCACHE
	GO
	DBCC FREEPROCCACHE
	go
	DBCC FLUSHPROCINDB(5)  -- id do banco -> print db_id('dl_cpt2009')
	go
	DBCC FREESYSTEMCACHE ('ALL')
	go
	DBCC FREESYSTEMCACHE ('ALL') WITH MARK_IN_USE_FOR_REMOVAL
	go
	DBCC FREESESSIONCACHE WITH NO_INFOMSGS
	GO
	GO