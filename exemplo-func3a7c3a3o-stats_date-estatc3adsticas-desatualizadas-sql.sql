SELECT name AS stats_name, 
    STATS_DATE(object_id, stats_id) AS statistics_update_date
FROM sys.stats 
order by statistics_update_date Desc
