
set linesize 3000 pagesize 3000 trimspool on echo on feedback on;
spool /mnt/cgi_tech_team/scripts/DB/Dev/backup/logs/Activate_Standby_Database.log;

select database_role from v$database;
alter database activate standby database;
select database_role from v$database;


spool off;

exit;


