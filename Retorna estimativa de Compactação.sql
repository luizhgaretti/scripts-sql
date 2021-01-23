Retorna o tamanho atual do objeto solicitado e faz a estimativa do tamanho do objeto para o estado de compactação solicitado


sp_estimate_data_compression_savings 
     [ @schema_name = ] 'schema_name'  
   , [ @object_name = ] 'object_name' 
   , [@index_id = ] index_id 
   , [@partition_number = ] partition_number 
   , [@data_compression = ] 'data_compression' 
[;]


USE AdventureWorks2012;
GO
EXEC sp_estimate_data_compression_savings 'Production', 'WorkOrderRouting', NULL, NULL, 'ROW' 