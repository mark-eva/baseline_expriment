--Description: Simple procedure to create a sql_tuning set

exec dbms_sqltune.create_sqlset(sqlset_name => '&sql_tuning_set_name',description => '&sql_tuning_set_description');
