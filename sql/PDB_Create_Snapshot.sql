
set linesize 3000 pagesize 3000 trimspool on timing on;
spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_Create_Snapshot_&1..log;

alter session set container = &1;
ALTER PLUGGABLE DATABASE SNAPSHOT Sandbox6_&2;

spool off;

exit;


