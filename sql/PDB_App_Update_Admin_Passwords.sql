
set linesize 3000 pagesize 3000 trimspool on feedback on echo on heading on;
spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_App_Update_Admin_Passwords_&1..log;

update  vsidp.ams_scty_user_dir set pswd = 'yaczYSfwM0biOTilcchkd/XWDdeqSk5oMPx2hErEq5xx2HsdElpSx1Vv', pswd_cret_dt = sysdate where user_id = 'admin';	
update  pegidp.ams_scty_user_dir set pswd = 'EO+r2ukzQdVwEHN2iGfV7WTdSraUPW5b+GnSjLVUjWfMz3phsOMiaQKY', pswd_cret_dt = sysdate where user_id = 'admin';	
update pegidp.AMS_SCTY_USER_DIR set PSWD = 'OY5lh+7PsqkFW5n+14Kpj+XWjqNlvkXtu7I6YQ6/kIlzdzT+KjaNpust' where user_id = 'webMethods';


update pegidp.AMS_SCTY_USER_DIR set ACTV_FL = '1' where user_id = 'webMethods';
update pegidp.AMS_SCTY_USER_DIR set EXP_USER_FL = '0' where user_id = 'webMethods' ;
update pegidp.AMS_SCTY_USER_DIR set NUM_OF_FALD_LGNS = '0' where user_id = 'webMethods' ;
update pegidp.AMS_SCTY_USER_DIR set ACTV_DT = sysdate where user_id = 'webMethods' ;
update pegidp.AMS_SCTY_USER_DIR set PSWD_CRET_DT = sysdate where user_id = 'webMethods' ;
update pegidp.AMS_SCTY_USER_DIR set EFCT_STDT = (sysdate-1) where user_id = 'webMethods' ;
update pegidp.AMS_SCTY_USER_DIR set EFCT_ENDT = (sysdate+3650) where user_id = 'webMethods' ;
update pegidp.AMS_SCTY_USER_DIR set GRCE_PSWD_FL = '0' where user_id = 'webMethods' ;
update pegidp.AMS_SCTY_USER2 set LAST_LGN_TIME = sysdate where user_id = 'webMethods' ;

commit;

spool off;

exit;

