Select Descricao,
         Case When CharIndex(' ',Descricao,1)=0 Then 'N�o Tem' Else 'Tem'
         End
From Produtos