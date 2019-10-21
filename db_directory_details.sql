col owner for a30
set lines 180
set wrap off
set pages 999
col directory_name for a30
col directory_path for a50

select owner
, directory_name
, directory_path
from dba_directories
where owner like '%&owner%'
and directory_name like '%&directory_name%';
