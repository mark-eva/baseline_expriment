-- Description: Pins a particular plan hash_value to a sql_id where the phv has been incoporated in a sql_tuning set


DECLARE
l_plans_loaded  PLS_INTEGER;
BEGIN
l_plans_loaded := DBMS_SPM.load_plans_from_sqlset(sqlset_name => '&sqtuning_set_name', fixed => 'YES', basic_filter => 'plan_hash_value = ''&phv''');
commit;
END;
/
