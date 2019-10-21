-- Description: Shows the contents of a sql tuning set

COLUMN SQL_TEXT FORMAT a30   
COLUMN SCH FORMAT a3
COLUMN ELAPSED FORMAT 999999999
set lines 200
set wrap off
col sql_id for a20
col TOTAL_BUFFERGETS_MB for  999,999,999,999

SELECT SQL_ID, PARSING_SCHEMA_NAME AS "SCH", SQL_TEXT, 
       ELAPSED_TIME AS "ELAPSED", BUFFER_GETS
, BUFFER_GETS * 8 /1024 "TOTAL_BUFFERGETS_MB"
FROM   TABLE( DBMS_SQLTUNE.SELECT_SQLSET( '&sql_tuning_set_name' ) )
where sql_id like '%&&sql_id%';
