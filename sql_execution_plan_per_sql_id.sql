set wrap off
set lines 250
col plan_table_output for a180

SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR(sql_id=> '&sql_id', cursor_child_no => &child_cursor ,FORMAT=>'ALLSTATS LAST'));
