
set linesize 3000 pagesize 3000 trimspool on echo on feedback on;
spool /mnt/cgi_tech_team/scripts/DB/Dev/backup/logs/Startup_Mount.log;

startup mount;

spool off;

exit;


