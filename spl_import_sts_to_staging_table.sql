-- Description: Import tuning set from a  staging table
-- Author: Mark Eva
-- Date 27th of September 2019

BEGIN
DBMS_SQLTUNE.unpack_stgtab_sqlset (sqlset_name => '&sql_set_name',
sqlset_owner => '%',
replace => TRUE,
staging_table_name => '&staging_table',
staging_schema_owner => '&owner_of_staging_table'
);
END;
/

