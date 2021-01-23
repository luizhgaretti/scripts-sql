/****** Object:  Trigger [trUpdPagamentoSemST]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trUpdPagamentoSemST] 
ON [dbo].[PAGAMENTO] FOR UPDATE 
AS 

IF UPDATE (inPago) AND @@rowcount = 1 
BEGIN
	UPDATE dbo.PAGAMENTO
	SET inStatus = 1
	FROM INSERTED 
	WHERE INSERTED.cdPagamento = PAGAMENTO.cdPagamento
	AND INSERTED.nrExercicio <=2010



/****** Object:  Trigger [trRepNrAutorizacao]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE TRIGGER [dbo].[trRepNrAutorizacao]
ON [dbo].[AUTORIZACAOAIDF] FOR UPDATE 

AS 
IF UPDATE (nrAutorizacao) AND @@rowcount = 1
BEGIN 
    
    if(
       select count(*) 
       from   dbo.AUTORIZACAOAIDF,inserted
       where  AUTORIZACAOAIDF.nrAutorizacao in(
       					       select inserted.nrAutorizacao 
						from  inserted
					      )
	  and AUTORIZACAOAIDF.cdAutorizacaoAidf <> inserted.cdAutorizacaoAidf
      )> 0
    
    
 	BEGIN
    
    		RAISERROR 50000 'Número de Autorização de Aidf já existente.'
    		rollback
    		
	END
END
GO


/****** Object:  Trigger [trInsDocumentoSemST]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trInsDocumentoSemST] 
ON [dbo].[DOCUMENTO]  FOR INSERT 

AS 

SET NOCOUNT ON

IF EXISTS (
    	   SELECT 1 
    	   FROM inserted 
    	   WHERE nrTipoDeclaracao = 1
    	   AND inSubstituicaoTributaria = 0 
    	   AND dtEmissao < '2010-12-01' 
   	  )	

BEGIN
	UPDATE dbo.DOCUMENTO
	SET inStatus = 1
	FROM INSERTED 
	WHERE INSERTED.cdDOcumento = DOCUMENTO.cdDocumento


END

SET NOCOUNT OFF
GO


/****** Object:  Trigger [trDelDocumentoSemST]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trDelDocumentoSemST] 
ON [dbo].[DOCUMENTO] FOR DELETE AS 

SET NOCOUNT ON

IF EXISTS (
    		SELECT 1 
    		FROM deleted
    		WHERE nrTipoDeclaracao = 1
    		AND inSubstituicaoTributaria = 0 
    		AND dtEmissao < '2010-12-01' 
   	  ) 
    
    
BEGIN
INSERT INTO dbo.DOCUMENTOHISTSEMST
(
 cdDocumento,
 nrDocumento,
 vlIss,
 vlReceita,
 nrMes,
 dtEmissao,
 vlAliquota,
 nrExercicio,
 inGeracaoPagamento,
 inSubstituicaoTributaria,
 cdAtividade,
 cdItemAtividade,
 cdPessoaPrestador,
 nrTipoDeclaracao,
 cdPessoaTomador,
 cdSerieNotaFiscal,
 dcSerieNotaFiscal,
 cdTipoDocumento,
 inTeste,
 dtDeclaracao,
 cdImportacaoLancamentoItens,
 tpInconsistencia,
 inSituacaoInconsistencia,
 inStatus
)

SELECT  cdDocumento,
        nrDocumento,
	vlIss,
    	vlReceita,
    	nrMes,
    	dtEmissao,
	vlAliquota,
	nrExercicio,
	inGeracaoPagamento,
	inSubstituicaoTributaria,
	cdAtividade,
	cdItemAtividade,
	cdPessoaPrestador,
	nrTipoDeclaracao,
	cdPessoaTomador,
	cdSerieNotaFiscal,
	dcSerieNotaFiscal,
	cdTipoDocumento,
	inTeste,
	dtDeclaracao,
	cdImportacaoLancamentoItens,
	tpInconsistencia,
	inSituacaoInconsistencia,
	inStatus
FROM	deleted 	 
WHERE nrTipoDeclaracao = 1
    AND inSubstituicaoTributaria = 0 
    AND dtEmissao < '2010-12-01'

END

SET NOCOUNT OFF
GO


/****** Object:  Trigger [trUpdDocumentoSemST]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trUpdDocumentoSemST] 
ON [dbo].[DOCUMENTO] FOR UPDATE 
AS 


IF (((UPDATE (vlReceita) and @@ROWCOUNT = 1) 
      OR (UPDATE (dtEmissao) and @@ROWCOUNT = 1) 
      OR (UPDATE (inSubstituicaoTributaria) and @@ROWCOUNT = 1))
      AND EXISTS (
            	   SELECT 1 
		   FROM inserted 
           	   WHERE nrTipoDeclaracao = 1
                   AND inSubstituicaoTributaria = 0 
                   AND dtEmissao < '2010-12-01' 
                 )
           
   )

BEGIN
	UPDATE dbo.DOCUMENTO
	SET inStatus = 1
	FROM INSERTED 
	WHERE INSERTED.cdDOcumento = DOCUMENTO.cdDocumento

END
GO