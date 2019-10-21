-- Description: Loads a plan hash value to particular sql_tuning set 
declare
baseline_ref_cur DBMS_SQLTUNE.SQLSET_CURSOR;
begin
open baseline_ref_cur for
select VALUE(p) from table(
DBMS_SQLTUNE.SELECT_WORKLOAD_REPOSITORY(&begin_snap_id, &end_snap_id,'sql_id='||CHR(39)||'&sql_id'||CHR(39)||' and plan_hash_value=&plan_hash_value',NULL,NULL,NULL,NULL,NULL,NULL,'ALL')) p;
DBMS_SQLTUNE.LOAD_SQLSET('&sqlset_name', baseline_ref_cur);
end;
/
