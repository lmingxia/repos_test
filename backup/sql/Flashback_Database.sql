
set linesize 3000 pagesize 3000 trimspool on echo on feedback on;
spool /mnt/cgi_tech_team/scripts/DB/Dev/backup/logs/Flashback_Database.log;

flashback database to restore point PROD_POINT;


spool off;

exit;


