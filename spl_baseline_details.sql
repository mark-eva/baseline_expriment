
set wrap off
col PLAN_NAME for a45
col ENABLED for a10
col ACCEPTED for a10
col FIXED for a10
col SQL_HANDLE for a45
set lines 200
alter session set nls_date_format = 'dd-mm-yyyy hh24:mi:ss';
col CREATED for a20


show parameter baseline


select SQL_HANDLE
, PLAN_NAME
, CREATED
, ENABLED
, ACCEPTED
, FIXED
from DBA_SQL_PLAN_BASELINES
where PLAN_NAME like '%&sql_plan_name%'
and SQL_TEXT like '%&sql_text_like%'
order by  ACCEPTED, CREATED  Desc;

 
