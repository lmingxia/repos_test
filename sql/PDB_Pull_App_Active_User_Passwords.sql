set linesize 3000 pagesize 3000 trimspool on heading off feedback off echo off verify off;

spool /mnt/cgi_tech_team/scripts/DB/Dev/sql/PDB_App_reset_passwords_&1..sql;

--Set all users to inactive
select 'set linesize 3000 pagesize 3000 trimspool on echo on heading on feedback on;' from dual;
select 'spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_App_reset_passwords_&1..log;' from dual;

select 'update openffs.ams_scty_user_dir set actv_fl = 0;' from dual;

-------Pull the password for active users before we refresh
select 'update pegidp.ams_scty_user_dir set pswd = ''' || p.pswd || ''' where user_id = ''' || p.user_id || ''';' 
from pegidp.ams_scty_user_dir p, openffs.ams_scty_user_dir o
where p.user_id = o.user_id
and o.actv_fl = 1 
union
select 'update pegidp.ams_scty_user_dir set pswd = ''' || p.pswd || ''' where user_id = ''' || p.user_id || ''';' 
from pegidp.ams_scty_user_dir p
where user_id = 'admin';

------Pull the list of users to reset to active after refresh
select 'update openffs.ams_scty_user_dir set actv_fl = 1 where user_id = ''' || p.user_id || ''';' 
from pegidp.ams_scty_user_dir p, openffs.ams_scty_user_dir o
where p.user_id = o.user_id
and o.actv_fl = 1 
union
select 'update openffs.ams_scty_user_dir set actv_fl = 1 where user_id = ''' || p.user_id || ''';' 
from pegidp.ams_scty_user_dir p
where user_id = 'admin';

select 'commit;' from dual;
select 'spool off;' from dual;
select 'exit;' from dual;

spool off;

exit;

