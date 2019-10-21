set wrap off
set pages 10000
SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR(sql_id=> '&sql_id', cursor_child_no => &child_cursor ,FORMAT=>'ALLSTATS LAST +PEEKED_BINDS +PROJECTION +ALIAS +PREDICATE +COST +BYTES'));
