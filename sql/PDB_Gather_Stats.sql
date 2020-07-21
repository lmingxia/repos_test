
set linesize 3000 pagesize 3000 trimspool on ;
spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_Gather_Stats_&1..log;


execute dbms_stats.gather_schema_stats(ownname => 'OPENFFS', options => 'GATHER', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, cascade => TRUE, degree => DBMS_STATS.AUTO_DEGREE, method_opt => 'FOR ALL COLUMNS SIZE AUTO');
execute dbms_stats.gather_schema_stats(ownname => 'PEGIDP', options => 'GATHER', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, cascade => TRUE, degree => DBMS_STATS.AUTO_DEGREE, method_opt => 'FOR ALL COLUMNS SIZE AUTO');
execute dbms_stats.gather_schema_stats(ownname => 'VSIDP', options => 'GATHER', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, cascade => TRUE, degree => DBMS_STATS.AUTO_DEGREE, method_opt => 'FOR ALL COLUMNS SIZE AUTO');
execute dbms_stats.gather_schema_stats(ownname => 'CCR', options => 'GATHER', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, cascade => TRUE, degree => DBMS_STATS.AUTO_DEGREE, method_opt => 'FOR ALL COLUMNS SIZE AUTO');
execute dbms_stats.gather_schema_stats(ownname => 'VSS', options => 'GATHER', estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE, cascade => TRUE, degree => DBMS_STATS.AUTO_DEGREE, method_opt => 'FOR ALL COLUMNS SIZE AUTO');

--EXECUTE DBMS_STATS.GATHER_SCHEMA_STATS(ownname => 'OPENFFS');
spool off;

exit;

