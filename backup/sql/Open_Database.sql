
set linesize 3000 pagesize 3000 trimspool on echo on feedback on;
spool /mnt/cgi_tech_team/scripts/DB/Dev/backup/logs/Open_Database.log;

alter database open;
select database_role from v$database;


spool off;

exit;


