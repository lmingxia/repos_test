
set linesize 3000 pagesize 3000 trimspool on serveroutput on define off;
spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_Individual_PDB_Post_Refresh_SQL_Sandbox16.log;

--DROP PUBLIC DATABASE LINK "VACONV_RO";
create public database link "VACONV_RO" connect to VACONV_RO identified by "vaconv_ro_123" using 'VACONV';




DECLARE

	cursor sec_orgs is select cd from openffs.mf_scty_orgn where cd not in ('UNUSED','HIDE','ALL','BASE','DEFAULTORG'); 

	cursor sec_prnc is select distinct substr(user_guid,7) from openffs.ams_scty_user_dir where upper(dscr) like '%CGI%';  
	--substr(user_guid,7) in --('benjamin.roark','christopher.allen','joyce.gough','stephen.langworthy','luis.maldonado','sean.martin','stephen.robinson','janeifer.smith','nathaniel.wheeler','david.schoenfield'); 
	--cursor sec_prnc is select distinct substr(user_guid,7), substr(scty_orgn_id,7) from openffs.ams_scty_user_dir where substr(user_guid,7) = 'mherd'; 
	
	sec_org varchar(100);
	v_user_id varchar(100);
  
BEGIN
open sec_orgs;
loop
    fetch sec_orgs into sec_org;
	exit when sec_orgs%notfound;
	
	open sec_prnc;
	loop
		fetch sec_prnc into v_user_id;
		exit when sec_prnc%notfound;
	
		dbms_output.put_line('Deleting all Roles assigned to user > ' || v_user_id );
		delete from openffs.mf_prnc_role_jn where scty_role_id = '&7804&ADMIN' and scty_prnc_id = '&7800&' || v_user_id and scty_role_id= '&7804&ADMIN' and scty_orgn_id = '&7802&' || sec_org;
		commit;
		
		dbms_output.put_line('Inserting ADMIN role into MF_PRNC_ROLE_JN for v_user_id > ' || v_user_id || ' and SEC_ORG > ' || sec_org );
		INSERT INTO openffs.mf_prnc_role_jn (uidy, oplk, scty_orgn_id, scty_prnc_id, scty_role_id ) 
		values
		('&7806&ADMIN&' || v_user_id ||'&'|| sec_org,
		SYSDATE, 
		'&7802&' || sec_org,
		'&7800&' || v_user_id, 
		'&7804&ADMIN');
		commit;
		update openffs.ams_scty_user_dir set actv_fl = 1 where user_id = v_user_id;
		update pegidp.ams_scty_user_dir set actv_fl = 1 where user_id = v_user_id;
		commit;
	end loop;
	close sec_prnc;
end loop;
close sec_orgs;


EXCEPTION
   when others then --trap all errors and rollback
   rollback;
   raise_application_error(-20001, sqlerrm);
END;
/
 





DECLARE
	cursor sec_prnc is select distinct substr(user_guid,7), substr(scty_orgn_id,7) from openffs.ams_scty_user_dir where upper(dscr) like '%CACI%'; 
	--cursor sec_prnc is select distinct substr(user_guid,7), substr(scty_orgn_id,7) from openffs.ams_scty_user_dir where substr(user_guid,7) = 'mherd'; 
	
	C1_RECORDS sec_prnc%ROWTYPE;	

	sec_org varchar(100);
	v_user_id varchar(100);
  
BEGIN
	open sec_prnc;
	loop
		fetch sec_prnc into v_user_id, sec_org;
		exit when sec_prnc%notfound;
	
		dbms_output.put_line('Deleting all Roles assigned to user > ' || v_user_id );
		delete from openffs.mf_prnc_role_jn where scty_prnc_id = '&7800&' || v_user_id and scty_role_id= '&7804&VIEW' and scty_orgn_id = '&7802&' || sec_org;
		commit;
		
		dbms_output.put_line('Inserting VIEW role into MF_PRNC_ROLE_JN for v_user_id > ' || v_user_id || ' and SEC_ORG > ' || sec_org );
		INSERT INTO openffs.mf_prnc_role_jn (uidy, oplk, scty_orgn_id, scty_prnc_id, scty_role_id ) 
		values
		('&7806&VIEW&' || v_user_id ||'&'|| sec_org,
		SYSDATE, 
		'&7802&' || sec_org,
		'&7800&' || v_user_id, 
		'&7804&VIEW');
		update openffs.ams_scty_user_dir set actv_fl = 1 where user_id = v_user_id;
		update pegidp.ams_scty_user_dir set actv_fl = 1 where user_id = v_user_id;
	end loop;
	--commit;
EXCEPTION
   when others then --trap all errors and rollback
   rollback;
   raise_application_error(-20001, sqlerrm);
END;
/







DECLARE
	cursor sec_prnc is select distinct substr(user_guid,7), substr(scty_orgn_id,7) from openffs.ams_scty_user_dir where upper(dscr) like '%CACI%'; 
	--cursor sec_prnc is select distinct substr(user_guid,7), substr(scty_orgn_id,7) from openffs.ams_scty_user_dir where substr(user_guid,7) = 'mherd'; 
	
	C1_RECORDS sec_prnc%ROWTYPE;	

	sec_org varchar(100);
	v_user_id varchar(100);
  
BEGIN
	open sec_prnc;
	loop
		fetch sec_prnc into v_user_id, sec_org;
		exit when sec_prnc%notfound;
	
		dbms_output.put_line('Deleting all Roles assigned to user > ' || v_user_id );
		delete from openffs.mf_prnc_role_jn where scty_role_id = '&7804&ADMIN' and scty_prnc_id = '&7800&' || v_user_id and scty_role_id= '&7804&ADMIN' and scty_orgn_id = '&7802&' || sec_org;
		commit;
		
		dbms_output.put_line('Inserting Admin role into MF_PRNC_ROLE_JN for v_user_id > ' || v_user_id || ' and SEC_ORG > ' || sec_org );
		INSERT INTO openffs.mf_prnc_role_jn (uidy, oplk, scty_orgn_id, scty_prnc_id, scty_role_id ) 
		values
		('&7806&ADMIN&' || v_user_id ||'&'|| sec_org,
		SYSDATE, 
		'&7802&' || sec_org,
		'&7800&' || v_user_id, 
		'&7804&ADMIN');
		update openffs.ams_scty_user_dir set actv_fl = 1 where user_id = v_user_id;
		update pegidp.ams_scty_user_dir set actv_fl = 1 where user_id = v_user_id;
	end loop;
	--commit;
EXCEPTION
   when others then --trap all errors and rollback
   rollback;
   raise_application_error(-20001, sqlerrm);
END;
/

 
spool off;

exit;

