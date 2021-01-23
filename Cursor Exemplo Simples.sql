
Declare Cursor_Teste Cursor For
	Select * From Produto

Open Cursor_Teste
Fetch Next From Cursor_Teste


While (@@Fetch_Status = 0)
Begin 
	Update Produto set ProdDataCad = GetDate()
	FETCH NEXT FROM Cursor_Teste
End

Close Cursor_Teste
Deallocate Cursor_Teste