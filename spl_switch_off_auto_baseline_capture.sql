-- Description: switches off automatic capture of sql plan baselines 


show parameter optimizer_capture_sql_plan_baselines
alter system set optimizer_capture_sql_plan_baselines = FALSE scope=both;
show parameter optimizer_capture_sql_plan_baselines
