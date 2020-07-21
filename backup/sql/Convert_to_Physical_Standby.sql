
set linesize 3000 pagesize 3000 trimspool on echo on feedback on;
spool /mnt/cgi_tech_team/scripts/DB/Dev/backup/logs/Convert_to_Physical_Standby.log;

select database_role from v$database;

ALTER DATABASE CONVERT TO PHYSICAL STANDBY;

select database_role from v$database;


spool off;

exit;


