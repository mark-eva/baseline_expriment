-- Description: Creates a staging table that can be used for transporting sql plan baselines 
-- Date: 27th of September 2019
-- Author: Mark Eva

BEGIN
  DBMS_SPM.CREATE_STGTAB_BASELINE(
  table_name      => '&cs_table_name',
  table_owner     => '&owner');
END;
/
