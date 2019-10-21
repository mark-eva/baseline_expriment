-- Description: Exports tuning set to a staging table
-- Author: Mark Eva
-- Date 27th of September 2019


DECLARE
BEGIN
DBMS_SQLTUNE.PACK_STGTAB_SQLSET
(
  sqlset_name => '&sqlset_name',
  sqlset_owner => '&sqlset_owner',
  staging_table_name => '&cs_staging_table_name',
  staging_schema_owner => '&staging_schema_owner'
);
END;
/
