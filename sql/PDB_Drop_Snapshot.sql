
set linesize 3000 pagesize 3000 trimspool on ;
spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_Drop_Snapshot_&1..log;

alter session set container = &1;
ALTER PLUGGABLE DATABASE DROP SNAPSHOT Sandbox6_&2;

spool off;

exit;


