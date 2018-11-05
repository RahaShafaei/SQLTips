/*
https://stackoverflow.com/questions/53148615/sql-query-for-getting-latest-coordinates-from-database
SQL query for getting latest coordinates from database

I have a question as a newbie: I have small project for fleetTracker, 
I want to get the latest coordinates for each fleet in a day, 
so i have gps database like below:

gpsDateTime         | long | lat  | fleetNumber
--------------------+------+------+-------------
2018-10-03 14:11:00 | 123  | -123 | ABC1234
2018-10-03 14:21:00 | 124  | -124 | ABC1234
2018-10-03 14:31:00 | 125  | -125 | ABC1234
2018-10-03 14:41:00 | 126  | -126 | ABC1234
2018-10-03 14:51:00 | 127  | -127 | ABC1234
......
2018-10-04 14:11:00 | 123  | -123 | ABC1234
2018-10-04 14:21:00 | 124  | -124 | ABC1234
2018-10-04 14:31:00 | 125  | -125 | ABC1234
2018-10-04 14:41:00 | 126  | -126 | ABC1234
2018-10-04 14:51:00 | 127  | -127 | ABC1234
......    
2018-10-03 14:11:00 | 123  | -123 | JKL4321
......
2018-10-03 14:21:00 | 124  | -124 | JKL4322
2018-10-03 14:31:00 | 125  | -125 | JKL4323
2018-10-03 14:41:00 | 126  | -126 | JKL4324
2018-10-03 14:51:00 | 127  | -127 | JKL4325
2018-10-04 14:11:00 | 123  | -123 | JKL4321
2018-10-04 14:21:00 | 124  | -124 | JKL4322
2018-10-04 14:31:00 | 125  | -125 | JKL4323
2018-10-04 14:41:00 | 126  | -126 | JKL4324
2018-10-04 14:51:00 | 127  | -127 | JKL4325

I need the result like this (only the latest one each fleetNumber):
2018-10-03 14:51:00 |127 |-127|ABC1234
2018-10-03 14:51:00 |127 |-127|JKL4325
*/
select * from
(
select 
gpsDateTime as Timee,long,lat, fleetNumber,
row_number() over(partition by fleetNumber order by gpsDateTime desc ) as rn
from GPS 
Where cast(gpsDateTime as Date) =  '2018-10-03' 
)X where rn=1
-----------------------------------------------------------------------
--*********************************************************************
-----------------------------------------------------------------------
SET NOCOUNT ON;
/*This line of code is used in SQL for not returning the number rows affected in the execution of the query. 
If we dont require the number of rows affected, 
we can use this as this would help in saving memory usage and increase the speeed of execution of the query.*/
-----------------------------------------------------------------------
--*********************************************************************
-----------------------------------------------------------------------
/*Sql Server provides a mechanism where we don’t need to restart the service to recycle the error logs, 
instead we can execute the system stored procedure SP_CYCLE_ERRORLOG to reinitialize the error logs.*/
EXECUTE SP_CYCLE_ERRORLOG 
-----------------------------------------------------------------------
--*********************************************************************
-----------------------------------------------------------------------
/*
Make Tree
*/
WITH table_1
     AS ( SELECT parent_id,
                 child_id
          FROM   MAP
          UNION ALL
          SELECT child_id      AS Parent_id,
                 id_to_trigger AS child_id
          FROM   ATTRIBUTES ),
     tree
     AS ( SELECT child_id
          FROM   table_1
          WHERE  parent_id = 1
          UNION ALL
          SELECT TABLE_1.child_id
          FROM   table_1
                 inner join tree
                         ON TREE.child_id = TABLE_1.parent_id )
SELECT *
FROM   tree 
-----------------------------------------------------------------------
--*********************************************************************
-----------------------------------------------------------------------






