
set linesize 3000 pagesize 3000 trimspool on echo on feedback on;
spool /mnt/cgi_tech_team/scripts/DB/Dev/backup/logs/Create_Restore_Point.log;

create restore point prod_point guarantee flashback database;


spool off;

exit;


