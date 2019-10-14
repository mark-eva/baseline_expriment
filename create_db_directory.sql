create directory sql_baseline_part2 as '/media/sf_scripts/experiments/sql_plan_baselines';
alter user mev030 quota unlimited on users;
grant read  on directory sql_baseline_part2 to mev030;
grant write  on directory sql_baseline_part2 to mev030;
