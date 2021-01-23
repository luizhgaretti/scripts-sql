-- Paulo Alonso - 23/07/2012
-- Este script retorna (como mensagem de saída) o script para geração de log de uma tabela do sistema, que é informada na variável @Tabela
-- Ele vai gerar o script de criação da tabela que armazenará os registros de log e os triggers de insert, delete e update que serão responsáveis pela criação do log

DECLARE @Tabela VARCHAR(50),
		@NomeCampo VARCHAR(30),
		@TipoCampo VARCHAR(30),
		@TamanhoCampo INT,
		@Str VARCHAR(200),
		@NumChv INT,
		@NumCampo INT,
		@Cont INT

-- O valor desta variável é o nome da tabela onde serão criado os triggers de log
SET @Tabela = 'CTRL_LOTE_ITEM_MOV_ESTQ'

-- Conta quantos campos fazem parte da chave primária da tabela
SELECT @NumChv = COUNT(*)
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS TBL 
JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KY ON TBL.constraint_name = KY.constraint_name
JOIN SYSCOLUMNS COL ON COL.name = KY.column_name AND COL.id = object_id(@Tabela)
JOIN SYSTYPES TIPO ON TIPO.usertype = COL.usertype
WHERE TBL.constraint_type = 'PRIMARY KEY' AND TBL.table_name = @Tabela

-- Conta quantos campos a tabela tem
SELECT @NumCampo = COUNT(*)
FROM SYSOBJECTS AS TABELA, SYSCOLUMNS AS COLUNA, SYSTYPES AS TIPO
WHERE TABELA.Id = COLUNA.Id AND COLUNA.UserType = TIPO.UserType AND TABELA.Name = @Tabela

IF @NumChv = 0
BEGIN
	PRINT 'Tabela ' + @Tabela + ' não encontrada'
	RETURN
END

-- Navega pelos campos da chave primária da tabela
DECLARE CHAVE CURSOR FOR
	SELECT KY.column_name, TIPO.name, COL.length
	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS TBL 
	JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KY ON TBL.constraint_name = KY.constraint_name
	JOIN SYSCOLUMNS COL ON COL.name = KY.column_name AND COL.id = object_id(@Tabela)
	JOIN SYSTYPES TIPO ON TIPO.usertype = COL.usertype
	WHERE TBL.constraint_type = 'PRIMARY KEY' AND TBL.table_name = @Tabela
	ORDER BY ordinal_position

-- Navega pelas colunas da tabela
DECLARE COLUNAS CURSOR FOR
	SELECT COLUNA.Name AS COLUNA, TIPO.Name AS TIPO, COLUNA.Length AS TAMANHO
	FROM SYSOBJECTS AS TABELA, SYSCOLUMNS AS COLUNA, SYSTYPES AS TIPO
	WHERE TABELA.Id = COLUNA.Id AND COLUNA.UserType = TIPO.UserType AND TABELA.Name = @Tabela
	
	
-- Script de criação da tabela de log
PRINT 'CREATE TABLE LOG_' + @Tabela + '('

OPEN CHAVE

FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @TipoCampo = 'varchar'
	BEGIN
		PRINT '    ' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + '),'
	END
	ELSE IF @TipoCampo = 'numeric'
	BEGIN
		PRINT '    ' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ',4),'
	END
	ELSE
	BEGIN
		PRINT '    ' + @NomeCampo + ' ' + UPPER(@TipoCampo) + ','
	END
	
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

CLOSE CHAVE

PRINT '    LogSeq INT,'
PRINT '    LogData DATETIME DEFAULT (GETDATE()),'
PRINT '    LogOper VARCHAR(30),'
PRINT '    LogUsuCod VARCHAR(30),'
PRINT '    LogTexto TEXT'
PRINT ')' + CHAR(13)
	
----------------------------------------------------------------------------------------------------------------------------------------------

-- Script da trigger de INSERT	
PRINT 'CREATE TRIGGER LOG_' + @Tabela + '_INS ON ' + @Tabela + ' FOR INSERT AS'
PRINT '    DECLARE @VUsuCod VARCHAR(100),'
PRINT '            @Seq INT,'

SET @Cont = 1

OPEN CHAVE

-- Declara as variáveis referentes aos campos da chave primária
FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Condição para verificar se deve colocar vírgula no final ou não
	IF @Cont < @NumChv
		IF @TipoCampo = 'varchar'
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + '),'
		END
		ELSE IF @TipoCampo = 'numeric'
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ',4),'
		END
		ELSE
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + ','
		END
	ELSE
		IF @TipoCampo = 'varchar'
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ')'
		END
		ELSE IF @TipoCampo = 'numeric'
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ',4)'
		END
		ELSE
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo)
		END		
	
	SET @Cont = @Cont + 1
	
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo	
END

CLOSE CHAVE

SET @Cont = 1

-- Atribui valor às variáveis referentes aos campos da chave primária
PRINT CHAR(13) + '    SELECT'

OPEN CHAVE

FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Condição para verificar se deve colocar vírgula no final ou não
	IF @Cont < @NumChv
		PRINT '        @V' + @NomeCampo + ' = ' + @NomeCampo + ','
	ELSE
		PRINT '        @V' + @NomeCampo + ' = ' + @NomeCampo
		
	SET @Cont = @Cont + 1
		
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

PRINT '    FROM INSERTED' + CHAR(13)

CLOSE CHAVE
	
PRINT '    SELECT @Seq = (SELECT ISNULL(MAX(LogSeq + 1), 1)'
PRINT '    FROM LOG_' + @Tabela
PRINT '    WHERE'

-- Adiciona os campos da chave primária da tabela na cláusula WHERE	
SET @Cont = 1

OPEN CHAVE

FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Condição para verificar se deve colocar AND no final ou não
	IF @Cont < @NumChv
		PRINT '        ' + @NomeCampo + ' = @VNew' + @NomeCampo + ' AND'
	ELSE
		PRINT '        ' + @NomeCampo + ' = @VNew' + @NomeCampo + CHAR(13)
		
	SET @Cont = @Cont + 1
		
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

CLOSE CHAVE

-- Busca o usuário logado, se não houver usuário logado no Apolo insere o valor INSERT
PRINT '    IF OBJECT_ID(''tempdb..#user_apolo'') IS NOT NULL'
PRINT '        SELECT @VUsuCod =  userapolo FROM #user_apolo'
PRINT '    ELSE'
PRINT '        SELECT @VUsuCod = ''INSERT''' + CHAR(13)

SET @Str = ''

OPEN CHAVE

-- Pega o nome das colunas da chave primária para adicionar ao insert
FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Str = @Str + @NomeCampo + ', '
		
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

CLOSE CHAVE

-- Inicia o script de insert na tabela de log
PRINT '    INSERT INTO LOG_' + @Tabela + ' (' + @Str + 'LogSeq, LogData, LogOper, LogUsuCod, LogTexto)'

SET @Str = ''

OPEN CHAVE

-- Pega o valor dos campos da chave primária para adiocionar ao insert
FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Str = @Str + '@V' + @NomeCampo + ', '
		
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

CLOSE CHAVE

-- Termina o script de insert
PRINT '    VALUES ' + '(' + @Str + '@Seq , GETDATE(), ''Inserção'', @VUsuCod, NULL)'
PRINT 'END' + CHAR(13)

----------------------------------------------------------------------------------------------------------------------------------------------

-- Script da trigger de DELETE	
PRINT 'CREATE TRIGGER LOG_' + @Tabela + '_DEL ON ' + @Tabela + ' FOR DELETE AS'
PRINT '    DECLARE @VUsuCod VARCHAR(100),'
PRINT '            @Seq INT,'

OPEN CHAVE

-- Declara as variáveis referentes aos campos da chave primária
SET @Cont = 1

FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Condição para verificar se deve colocar vírgula no final ou não
	IF @Cont < @NumChv
		IF @TipoCampo = 'varchar'
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + '),'
		END
		ELSE IF @TipoCampo = 'numeric'
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ',4),'
		END
		ELSE
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + ','
		END
	ELSE
		IF @TipoCampo = 'varchar'
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ')'
		END
		ELSE IF @TipoCampo = 'numeric'
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ',4)'
		END
		ELSE
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo)
		END		
	
	SET @Cont = @Cont + 1
	
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo	
END

CLOSE CHAVE

SET @Cont = 1

-- Atribui valor às variáveis referentes aos campos da chave primária
PRINT CHAR(13) + '    SELECT'

OPEN CHAVE

FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Condição para verificar se deve colocar vírgula no final ou não
	IF @Cont < @NumChv
		PRINT '        @V' + @NomeCampo + ' = ' + @NomeCampo + ','
	ELSE
		PRINT '        @V' + @NomeCampo + ' = ' + @NomeCampo
		
	SET @Cont = @Cont + 1
		
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

PRINT '    FROM INSERTED' + CHAR(13)

CLOSE CHAVE

-- Pega a sequência do registro	
PRINT '    SELECT @Seq = (SELECT ISNULL(MAX(LogSeq + 1), 1)'
PRINT '    FROM LOG_' + @Tabela
PRINT '    WHERE'

-- Adiciona os campos da chave primária da tabela na cláusula WHERE	
SET @Cont = 1

OPEN CHAVE

FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Condição para verificar se deve colocar AND no final ou não
	IF @Cont < @NumChv
		PRINT '        ' + @NomeCampo + ' = @VNew' + @NomeCampo + ' AND'
	ELSE
		PRINT '        ' + @NomeCampo + ' = @VNew' + @NomeCampo + CHAR(13)
		
	SET @Cont = @Cont + 1
		
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

CLOSE CHAVE

-- Busca o usuário logado, se não houver usuário logado no Apolo insere o valor DELETE
PRINT '    IF OBJECT_ID(''tempdb..#user_apolo'') IS NOT NULL'
PRINT '        SELECT @VUsuCod =  userapolo FROM #user_apolo'
PRINT '    ELSE'
PRINT '        SELECT @VUsuCod = ''DELETE''' + CHAR(13)

SET @Str = ''

OPEN CHAVE

-- Pega o nome das colunas da chave primária para adicionar ao insert
FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Str = @Str + @NomeCampo + ', '
		
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

CLOSE CHAVE

-- Inicia o script de insert na tabela de log
PRINT '    INSERT INTO LOG_' + @Tabela + ' (' + @Str + 'LogSeq, LogData, LogOper, LogUsuCod, LogTexto)'

SET @Str = ''

OPEN CHAVE

-- Pega o valor das colunas da chave primária para adicionar ao insert
FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Str = @Str + '@V' + @NomeCampo + ', '
		
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

CLOSE CHAVE

-- Termina o script de insert na tabela de log
PRINT '    VALUES ' + '(' + @Str + '@Seq , GETDATE(), ''Exclusão'', @VUsuCod, NULL)'
PRINT 'END' + CHAR(13)

----------------------------------------------------------------------------------------------------------------------------------------------

-- Script do trigger de UPDATE
PRINT 'CREATE TRIGGER LOG_' + @Tabela + '_UPD ON ' + @Tabela +' FOR UPDATE AS'

PRINT 'BEGIN'
PRINT '    DECLARE @LogTexto VARCHAR(4000),'
PRINT '	           @VUsuCod  VARCHAR(100),'
PRINT '            @Seq INT,'

OPEN CHAVE

-- Declara as variáveis referentes aos campos da chave primária
SET @Cont = 1

FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Condição para verificar se deve colocar vírgula no final ou não
	IF @Cont < @NumChv
		IF @TipoCampo = 'varchar'
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + '),'
		END
		ELSE IF @TipoCampo = 'numeric'
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ',4),'
		END
		ELSE
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + ','
		END
	ELSE
		IF @TipoCampo = 'varchar'
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ')'
		END
		ELSE IF @TipoCampo = 'numeric'
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ',4)'
		END
		ELSE
		BEGIN
			PRINT '            @V' + @NomeCampo + ' ' + UPPER(@TipoCampo)
		END		
	
	SET @Cont = @Cont + 1
	
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo	
END

CLOSE CHAVE

SET @Cont = 1

-- Atribui valor às variáveis referentes aos campos da chave primária
PRINT CHAR(13) + '    SELECT'

OPEN CHAVE

FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Condição para verificar se deve colocar vírgula no final ou não
	IF @Cont < @NumChv
		PRINT '        @V' + @NomeCampo + ' = ' + @NomeCampo + ','
	ELSE
		PRINT '        @V' + @NomeCampo + ' = ' + @NomeCampo
		
	SET @Cont = @Cont + 1
		
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

PRINT '    FROM INSERTED' + CHAR(13)

CLOSE CHAVE

-- Pega a sequência do registro	
PRINT '    SELECT @Seq = (SELECT ISNULL(MAX(LogSeq + 1), 1)'
PRINT '    FROM LOG_' + @Tabela
PRINT '    WHERE'

-- Adiciona os campos da chave primária da tabela na cláusula WHERE	
SET @Cont = 1

OPEN CHAVE

FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	-- Condição para verificar se deve colocar AND no final ou não
	IF @Cont < @NumChv
		PRINT '        ' + @NomeCampo + ' = @VNew' + @NomeCampo + ' AND'
	ELSE
		PRINT '        ' + @NomeCampo + ' = @VNew' + @NomeCampo + CHAR(13)
		
	SET @Cont = @Cont + 1
		
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

CLOSE CHAVE

-- Busca o usuário logado, se não houver usuário logado no Apolo insere o valor UPDATE
PRINT '    IF OBJECT_ID(''tempdb..#user_apolo'') IS NOT NULL'
PRINT '        SELECT @VUsuCod =  userapolo FROM #user_apolo'
PRINT '    ELSE'
PRINT '        SELECT @VUsuCod = ''UPDATE''' + CHAR(13)

-- Inicia o texto do log
PRINT '    SET @LogTexto = ''' + @Tabela +  ' - campo(s) : '''

-- Declaração das variáveis para cada campo
PRINT CHAR(13) + '    DECLARE'

SET @Cont = 1

OPEN COLUNAS

FETCH NEXT FROM COLUNAS INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @Cont < @NumCampo
		IF @TipoCampo = 'varchar'
		BEGIN
			PRINT '        @VOld' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + '),'
			PRINT '        @VNew' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + '),'
		END
		ELSE IF @TipoCampo = 'numeric'
		BEGIN
			PRINT '        @VOld' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ',4),'
			PRINT '        @VNew' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ',4),'
		END
		ELSE
		BEGIN
			PRINT '        @VOld' + @NomeCampo + ' ' + UPPER(@TipoCampo) + ','
			PRINT '        @VNew' + @NomeCampo + ' ' + UPPER(@TipoCampo) + ','
		END
	ELSE
		IF @TipoCampo = 'varchar'
		BEGIN
			PRINT '        @VOld' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + '),'
			PRINT '        @VNew' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ')'
		END
		ELSE IF @TipoCampo = 'numeric'
		BEGIN
			PRINT '        @VOld' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ',4),'
			PRINT '        @VNew' + @NomeCampo + ' ' + UPPER(@TipoCampo) + '(' + CAST(@TamanhoCampo AS VARCHAR(5)) + ',4)'
		END
		ELSE
		BEGIN
			PRINT '        @VOld' + @NomeCampo + ' ' + UPPER(@TipoCampo) + ','
			PRINT '        @VNew' + @NomeCampo + ' ' + UPPER(@TipoCampo)
		END
		
	SET @Cont = @Cont + 1
	
	FETCH NEXT FROM COLUNAS INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

CLOSE COLUNAS

-- Atribuição dos valores antigos
PRINT CHAR(13) + '    SELECT'

SET @Cont = 1

OPEN COLUNAS

FETCH NEXT FROM COLUNAS INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @Cont < @NumCampo
		PRINT '        @VOld' + @NomeCampo + ' = ' + @NomeCampo + ','
	ELSE
		PRINT '        @VOld' + @NomeCampo + ' = ' + @NomeCampo
		
	SET @Cont = @Cont + 1
	
	FETCH NEXT FROM COLUNAS INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

CLOSE COLUNAS
	
PRINT '    FROM DELETED'

PRINT CHAR(13) + '    SELECT'

SET @Cont = 1

OPEN COLUNAS

-- Atribuição dos valores novos
FETCH NEXT FROM COLUNAS INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	IF @Cont < @NumCampo
		PRINT '        @VNew' + @NomeCampo + ' = ' + @NomeCampo + ','
	ELSE
		PRINT '        @VNew' + @NomeCampo + ' = ' + @NomeCampo
		
	SET @Cont = @Cont + 1
	
	FETCH NEXT FROM COLUNAS INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

CLOSE COLUNAS

PRINT '    FROM INSERTED'
PRINT ''

OPEN COLUNAS

-- Verificação de alterações	
FETCH NEXT FROM COLUNAS INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT '    IF ISNULL(@VOld' + @NomeCampo + ', ''0'') <> ISNULL(@VNew' + @NomeCampo + ', ''0'')'
	PRINT '    BEGIN'
	PRINT '        SET @LogTexto = @LogTexto +''' + @NomeCampo + ' Alterado de : ISNULL(@VOld' + @NomeCampo + ', '''')' + ' Para : ISNULL(@VOld' + @NomeCampo + ', ''''),   '''
	PRINT '    END'
	
	FETCH NEXT FROM COLUNAS INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

CLOSE COLUNAS

SET @Str = ''

OPEN CHAVE

-- Pega o nome das colunas da chave primária para adicionar ao insert
FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Str = @Str + @NomeCampo + ', '
		
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

CLOSE CHAVE

-- Inicia o script de insert na tabela de log
PRINT CHAR(13) + '    INSERT INTO LOG_' + @Tabela + ' (' + @Str + 'LogSeq, LogData, LogOper, LogUsuCod, LogTexto)'

SET @Str = ''

OPEN CHAVE

-- Pega o valor das colunas da chave primária para adicionar ao insert
FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Str = @Str + '@V' + @NomeCampo + ', '
		
	FETCH NEXT FROM CHAVE INTO @NomeCampo, @TipoCampo, @TamanhoCampo
END

CLOSE CHAVE

-- Termina o script de insert na tabela de log
PRINT '    VALUES ' + '(' + @Str + '@Seq , GETDATE(), ''Alteração'', @VUsuCod, @LogTexto)'
PRINT 'END' + CHAR(13)

DEALLOCATE COLUNAS
DEALLOCATE CHAVE