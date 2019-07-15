SET ECHO ON
VARIABLE object_type VARCHAR2(30)
EXECUTE :object_type := 'RULE';

select count (*) from  mev030.test_table
where OBJECT_TYPE = :object_type;


SET ECHO ON
VARIABLE object_type VARCHAR2(30)
EXECUTE :object_type := 'SYNONYM';

select count (*) from  mev030.test_table
where OBJECT_TYPE = :object_type;

