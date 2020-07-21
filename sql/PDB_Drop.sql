
set linesize 3000 pagesize 3000 trimspool on ;
spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_Drop_&1..log;

alter pluggable database &1 close immediate;
drop pluggable database &1 including datafiles;

spool off;

exit;


