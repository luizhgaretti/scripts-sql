SELECT name, value, value_in_use, [description]
FROM sys.configurations
ORDER BY name OPTION (RECOMPILE);