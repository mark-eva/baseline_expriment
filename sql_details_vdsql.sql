alter  session set nls_date_format = 'dd-mm-yyyy hh24:mi:ss';

set lines 300
set wrap off
col sql_id for a20
col LAST_ACTIVE_TIME for a25
col executions for 999,999,999
col FETCHES for 999,999,999
col sql_text for a50
col avg_time_per_exec_mili for 999999999.999



select sql_text
, sql_id
, PLAN_HASH_VALUE
, CHILD_NUMBER
, FETCHES
, LAST_ACTIVE_TIME
, EXECUTIONS
, ELAPSED_TIME / EXECUTIONS /1000/1000  avg_time_per_exec_mili
from v$sql
where sql_text like '%&sql_text_like%'
and sql_id like '%&sql_id%'
order by sql_id, CHILD_NUMBER, PLAN_HASH_VALUE ;


