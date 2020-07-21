
set linesize 3000 pagesize 3000 trimspool on echo on feedback on;
spool /mnt/cgi_tech_team/scripts/DB/Dev/backup/logs/Alter_Database_Set_Standby.log;

alter database set standby database to maximize performance;

spool off;

exit;


