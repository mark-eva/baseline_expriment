/*
Description: import sql plan baseline to pre-created staging table
Author: Mark Eva
Date: 9th of October 2019

*/

SET SERVEROUTPUT ON
DECLARE
  l_plans_packed  PLS_INTEGER;
BEGIN
  l_plans_packed := DBMS_SPM.UNPACK_STGTAB_BASELINE (
    table_name      => '&staging_table_name',
    table_owner     => '&table_owner',
    plan_name       => '&plan_name',
    sql_handle      => '&sql_handle'	
);
    

  DBMS_OUTPUT.put_line('Plans Packed: ' || l_plans_packed);
END;
/
