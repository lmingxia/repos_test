
set linesize 3000 pagesize 3000 trimspool on define off ;
spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_Post_Refresh_SQL_&1..log;

--Update the Message of the Day
truncate table openffs.AMS_MSG_OF_DAY;
insert into openffs.AMS_MSG_OF_DAY (actv_fl, uidd, app_fl, efct_endt, efct_stdt, mesg, prty, oplk, sbjc) values
 ('1', '11113333',null,null,sysdate-1,'To report any issues with this iFAMS non-production Sandbox environment please email VAFMBTSandbox@va.gov.',1,sysdate,'Non Prod');
 
 
spool off;

exit;

