
set linesize 3000 pagesize 3000 trimspool on echo on feedback on;
spool /mnt/cgi_tech_team/scripts/DB/Dev/backup/logs/Drop_Restore_Point.log;

drop restore point PROD_POINT;


spool off;

exit;


