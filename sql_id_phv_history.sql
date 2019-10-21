col stddev_etime heading 'stddev|etime' noprint
col std_dev noprint
col min_etime_seconds noprint
set lines 300


col INSTANCE_NUMBER heading 'I|NO' format 9
col PLAN_HASH_VALUE heading 'PLAN|HASH|VALUE'
col rank heading 'RA' format 99
col avg_etime_seconds heading 'AVG|ETIME|(ms)'
col med_etime_seconds heading 'MED|ETIME|(ms)'
col max_etime_seconds heading 'MAX|ETIME|(ms)'
col etime heading 'ETIME|(ms)'
col is_current heading 'IS|CURR'
col sql_plan_baseline heading 'SQL|PLAN|BASELINE' format a10 word_wrapped
col sql_profile_name heading 'SQL|PROFILE|NAME' format a8 word_wrapped
col MIN_SNAP_ID heading 'MIN|SNAP|ID'
col MAX_SNAP_ID heading 'MAX|SNAP|ID'
col min_time heading 'MIN|TIME' format a8
col max_time heading 'MAX|TIME' format a8
col avg_cpu_time heading 'AVG|CPU|TIME|(ms)'
col avg_lio heading 'AVG|LIO'
col avg_pio heading 'AVG|PIO'


With P1 AS(
SELECT h.instance_number,
       h.sql_id,
       h.plan_hash_value,
           min(s.snap_id) min_snap_id,
           max(s.snap_id) max_snap_id,
       to_char(MIN(s.begin_interval_time),'dd-mm-yy hh24:mi') min_time,
       to_char(MAX(s.end_interval_time),'dd-mm-yy hh24:mi') max_time,
       round(MEDIAN(h.elapsed_time_delta / h.executions_delta)/1000,2) med_etime_seconds,
       round(AVG(h.elapsed_time_delta / h.executions_delta)/1000,2)    avg_etime_seconds,
       round(MIN(h.elapsed_time_delta / h.executions_delta)/1000,2)    min_etime_seconds,
       round(MAX(h.elapsed_time_delta / h.executions_delta)/1000,2)    max_etime_seconds,
       round(STDDEV(h.elapsed_time_delta / h.executions_delta) / AVG(h.elapsed_time_total / h.executions_delta),2) std_dev,
       SUM(h.executions_delta) execs,
       round(MEDIAN(h.elapsed_time_delta / h.executions_delta) * MAX(h.executions_delta)/1000,2) total_etime_seconds,
           round(AVG(h.cpu_time_delta / h.executions_delta)/1000,2) avg_cpu_time,
       round(AVG(h.buffer_gets_delta / h.executions_delta),0)    avg_lio,
       round(AVG(h.disk_Reads_delta / h.executions_delta),0)    avg_pio
  FROM dba_hist_sqlstat h,  dba_hist_snapshot s
 WHERE h.executions_delta > 0
   AND h.plan_hash_value > 0
   AND s.snap_id = h.snap_id
   AND s.instance_number = h.instance_number
   --AND CAST(s.end_interval_time AS DATE) > SYSDATE - 90
   and h.sql_id='&&1'
 GROUP BY h.instance_number,
       h.sql_id,
       h.plan_hash_value
	   ),
prof AS(
select distinct
p.name sql_profile_name,
s.sql_id,s.PLAN_HASH_VALUE,s.INSTANCE_NUMBER
from
dba_sql_profiles p,
DBA_HIST_SQLSTAT s
where
p.name=s.sql_profile)
select * from (
select P1.instance_number,
P1.sql_id,P1.plan_hash_value,
row_number() over (partition by P1.sql_id order by avg_etime_seconds) rank ,
round(stddev(avg_etime_seconds) over (partition by P1.sql_id),2) stddev_etime,
std_dev,
avg_etime_seconds,
med_etime_seconds,
min_etime_seconds,
max_etime_seconds,
decode(s.plan_hash_value,NULL,'NO','YES') is_current,
s.sql_plan_baseline,
sql_profile_name,
min_snap_id,max_snap_id,
min_time,max_time,
trunc(execs) execs,
total_etime_seconds etime,
avg_cpu_time,
avg_lio,
avg_pio
from P1,(select distinct INST_ID,sql_id,plan_hash_value,sql_plan_baseline from gv$sql) s,prof
where P1.sql_id=s.sql_id (+) and P1.plan_hash_value = s.plan_hash_value (+)
and P1.instance_number = s.inst_id (+)
and P1.sql_id = prof.sql_id (+) and P1.PLAN_HASH_VALUE = prof.PLAN_HASH_VALUE (+)
and P1.instance_number = prof.INSTANCE_NUMBER (+)
)
order by stddev_etime desc, rank; 
