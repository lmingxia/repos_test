
set linesize 3000 pagesize 3000 trimspool on echo on feedback on;
spool /mnt/cgi_tech_team/scripts/DB/Dev/backup/logs/Turn_Flashback_On.log;

alter database flashback on;


spool off;

exit;


