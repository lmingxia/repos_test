set define on echo on feedback on timing on trimspool on pagesize 1000 linesize 3000;

column spoolname new_value spoolname;
select '/mnt/cgi_tech_team/scripts/DB/Dev/logs/EMR_9085' ||'_'|| '&1' || '_' || '&2' || '.log' spoolname from dual;
spool '&spoolname'

update &2..AMS_SCTY_USER_DIR set ACTV_FL = '1' where user_id = 'admin';
update &2..AMS_SCTY_USER_DIR set EXP_USER_FL = '0' where user_id = 'admin';
-- not in OPENFFS -- update &2..AMS_SCTY_USER_DIR set NUM_OF_FALD_LGNS = '0' where user_id = 'admin';
update &2..AMS_SCTY_USER_DIR set ACTV_DT = sysdate where user_id = 'admin';
-- not in OPENFFS -- update &2..AMS_SCTY_USER_DIR set PSWD_CRET_DT = sysdate where user_id = 'admin';
update &2..AMS_SCTY_USER_DIR set EFCT_STDT = (sysdate-1) where user_id = 'admin';
update &2..AMS_SCTY_USER_DIR set EFCT_ENDT = (sysdate+3650) where user_id = 'admin';
-- not in OPENFFS -- update &2..AMS_SCTY_USER_DIR set GRCE_PSWD_FL = '0' where user_id = 'admin';
update &2..AMS_SCTY_USER2 set LAST_LGN_TIME = sysdate where user_id = 'admin';
commit;

spool off;
exit;


