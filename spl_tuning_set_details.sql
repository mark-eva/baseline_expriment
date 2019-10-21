set lines 200
set wrap off
col sql_text for a60
col sql_id for a20
col SQLSET_NAME for a30
col SQLSET_OWNER for a20

SELECT a.sql_text
, a.SQL_ID
, a.SQLSET_OWNER
, a.SQLSET_NAME
, a.PLAN_HASH_VALUE
, a.executions
, b.created
FROM   dba_sqlset_statements a, DBA_SQLSET b
where a.SQLSET_ID = b.ID
and  a.sqlset_name like  '%&tuning_set_name%';
