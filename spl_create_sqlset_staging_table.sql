
BEGIN
  DBMS_SQLTUNE.create_stgtab_sqlset(table_name=> '&table_name', schema_name => '&schema_name');
END;
/
