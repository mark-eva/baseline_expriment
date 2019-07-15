select count (*), object_type from mev030.test_table
group by object_type
order by 1 desc;	

