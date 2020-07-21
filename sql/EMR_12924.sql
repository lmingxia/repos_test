set define on echo on feedback on timing on trimspool on pagesize 1000 linesize 3000;

column spoolname new_value spoolname;
select '/mnt/cgi_tech_team/scripts/DB/Dev/logs/EMR_12924' ||'_'|| '&1' || '.log' spoolname from dual;
spool '&spoolname'
set serveroutput on define off;


DECLARE
   CURSOR c1 IS
      SELECT distinct cd from openffs.mf_scty_orgn where uidy not in(select SCTY_ORGN_ID 
	  from openffs.MF_PRNC_ROLE_JN where SCTY_ROLE_ID = '&7804&ADMIN' 
	  and SCTY_PRNC_ID = (select user_guid from openffs.AMS_SCTY_USER_DIR where user_id = 'admin'));

	v_sec_org varchar(100);
BEGIN
   open c1;
		loop
   		fetch c1 into v_sec_org;
			exit when c1%notfound;
			dbms_output.put_line('Inserting Additional Sec Org for Admin: ' || v_sec_org);
			INSERT INTO openffs.MF_PRNC_ROLE_JN (UIDY, OPLK, SCTY_ORGN_ID, SCTY_PRNC_ID, SCTY_ROLE_ID) 
			VALUES ('&7806&ADMIN&admin&' || v_sec_org, sysdate, '&7802&' || v_sec_org, '&7800&admin', '&7804&ADMIN');
			COMMIT;
		end loop;
END;
/

spool off;
exit;


