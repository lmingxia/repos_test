--ADDED logic that if the Momentum security admin just reset the user password within the last 5 days, it wouldnt deactivate that user for inactivity even if they hadnt logged in yet.
--Creates less of a headache for the security admins to have to redo password resets each day.

set serveroutput on linesize 3000 pagesize 3000 trimspool on heading off feedback off term off verify off;

column spoolname new_value spoolname;
select '/mnt/cgi_tech_team/scripts/DB/Dev/logs/EMR_12074' ||'_'|| '&1' || '_' || '&2' || '.sh' spoolname from dual;
spool '&spoolname'

DECLARE
	cursor prod_or_dev is SELECT ora_database_name from dual;

	cursor sec_prnc is SELECT a.email_addr , a.user_id, ROUND(SYSDATE - b.last_lgn_time) AS INACTIVITY
		FROM &2..ams_scty_user_dir a, &2..ams_scty_user2 b, &2..ams_scty_user_dir c, &2..ams_scty_user2 d
		WHERE a.user_id = b.user_id
		AND a.user_id = c.user_id AND a.user_id = d.user_id
		AND a.actv_fl = 1;
		--see comment above, this can be added back if desired -- AND ROUND(SYSDATE - c.pswd_cret_dt) >= 5
		--see comment above, this can be added back if desired -- AND ROUND(SYSDATE - nvl2(a.actv_dt, a.actv_dt, sysdate - 20)) >= 5;
		--and a.user_id in ('student1','student2','student3','student4','student5');
	
	email_addr varchar(100);
	user_id varchar(100);
	inactivity number(4);
	dbname varchar(30);
	
BEGIN
    open prod_or_dev;
	loop 
		fetch prod_or_dev into dbname;
		
		--first check is to determine if we're in DevTest, the value only stores the 1st 8 characters in VAPROD/VAPREPROD
	 	if dbname NOT in ('VAPROD','VAPROD_S','VAPREPRO') then 
			open sec_prnc;
			loop
				fetch sec_prnc into email_addr, user_id, inactivity;
					exit when sec_prnc%notfound;
					--dbms_output.put_line('user ' || user_id || ' inactivity ' || inactivity);
					If inactivity = 65 then
							dbms_output.put_line('echo -e "Subject: iFAMS Account Inactivity\n\nDear iFAMS User,\nYour user id '|| user_id ||' has not accessed '|| dbname || ' in 65 days and your account expires in 25 days.\n\nPlease access '|| dbname || ' to reset.\n\n***Please do not reply to this email***\n\nThanks,\nVA FMBT iFAMS Support (VAFMBTsandbox@va.gov)" | /usr/sbin/sendmail ' || '-f VAFMBTsandbox@va.gov ' || email_addr);
					elsif inactivity = 75 then
							dbms_output.put_line('echo -e "Subject: iFAMS Account Inactivity\n\nDear iFAMS User,\nYour user id '|| user_id ||' has not accessed '|| dbname || ' in 75 days and your account expires in 15 days.\n\nPlease access '|| dbname || ' to reset.\n\n***Please do not reply to this email***\n\nThanks,\nVA FMBT iFAMS Support (VAFMBTsandbox@va.gov)" | /usr/sbin/sendmail ' || '-f VAFMBTsandbox@va.gov ' || email_addr);
					elsif inactivity = 85 then
							dbms_output.put_line('echo -e "Subject: iFAMS Account Inactivity\n\nDear iFAMS User,\nYour user id '|| user_id ||' has not accessed '|| dbname || ' in 85 days and your account expires in 5 days.\n\nPlease access '|| dbname || ' to reset.\n\n***Please do not reply to this email***\n\nThanks,\nVA FMBT iFAMS Support (VAFMBTsandbox@va.gov)" | /usr/sbin/sendmail ' || '-f VAFMBTsandbox@va.gov ' || email_addr);
					elsif inactivity = 89 then
							dbms_output.put_line('echo -e "Subject: iFAMS Account Inactivity\n\nDear iFAMS User,\nYour user id '|| user_id ||' has not accessed '|| dbname || ' in 89 days and your account expires in 1 day.\n\nPlease access '|| dbname || ' to reset.\n\n***Please do not reply to this email***\n\nThanks,\nVA FMBT iFAMS Support (VAFMBTsandbox@va.gov)" | /usr/sbin/sendmail ' || '-f VAFMBTsandbox@va.gov ' || email_addr);
					elsif inactivity >= 90 then
							dbms_output.put_line('echo -e "Subject: iFAMS Account Inactivity\n\nDear iFAMS User,\nYour user id '|| user_id ||' in '|| dbname || ' has expired and you need to contact iFAMS Support to reactivate.\n\n***Please do not reply to this email***\n\nThanks,\nVA FMBT iFAMS Support (VAFMBTsandbox@va.gov)" | /usr/sbin/sendmail ' || '-f VAFMBTsandbox@va.gov ' || email_addr);
					end if;
			end loop;
                        exit;

		else
			open sec_prnc;
			loop
				fetch sec_prnc into email_addr, user_id, inactivity;
					exit when sec_prnc%notfound;
					--dbms_output.put_line('user ' || user_id || ' inactivity ' || inactivity);
					If inactivity = 65 then
							dbms_output.put_line('echo -e "Subject: iFAMS Account Inactivity\n\nDear iFAMS User,\nYour user id '|| user_id ||' has not accessed iFAMS in 65 days and with continued inactivity your account will expire in 25 days, access https://ifams.va.gov to avoid expiration.  Please reach out to the FSC service desk if you have questions, https://vaww.cpm.fsc.va.gov/.\n\n***Please do not reply to this email***\n\nThanks,\nVA FMBT iFAMS Support" | /usr/sbin/sendmail ' || '-f DoNotReply@va.gov ' || email_addr);
					elsif inactivity = 75 then
							dbms_output.put_line('echo -e "Subject: iFAMS Account Inactivity\n\nDear iFAMS User,\nYour user id '|| user_id ||' has not accessed iFAMS in 75 days and with continued inactivity your account will expire in 15 days, access https://ifams.va.gov to avoid expiration. Please reach out to the FSC service desk if you have questions, https://vaww.cpm.fsc.va.gov/.\n\n***Please do not reply to this email***\n\nThanks,\nVA FMBT iFAMS Support" | /usr/sbin/sendmail ' || '-f DoNotReply@va.gov ' || email_addr);
					elsif inactivity = 85 then
							dbms_output.put_line('echo -e "Subject: iFAMS Account Inactivity\n\nDear iFAMS User,\nYour user id '|| user_id ||' has not accessed iFAMS in 85 days and with continued inactivity your account will expire in 5 days, access https://ifams.va.gov to avoid expiration. Please reach out to the FSC service desk if you have questions, https://vaww.cpm.fsc.va.gov/.\n\n***Please do not reply to this email***\n\nThanks,\nVA FMBT iFAMS Support" | /usr/sbin/sendmail ' || '-f DoNotReply@va.gov ' || email_addr);
					elsif inactivity = 89 then
							dbms_output.put_line('echo -e "Subject: iFAMS Account Inactivity\n\nDear iFAMS User,\nYour user id '|| user_id ||' has not accessed iFAMS in 89 days and with continued inactivity your account will expire in 1 day, access https://ifams.va.gov to avoid expiration. Please reach out to the FSC service desk if you have questions, https://vaww.cpm.fsc.va.gov/.\n\n***Please do not reply to this email***\n\nThanks,\nVA FMBT iFAMS Support" | /usr/sbin/sendmail ' || '-f DoNotReply@va.gov ' || email_addr);
					elsif inactivity >= 90 then
							dbms_output.put_line('echo -e "Subject: iFAMS Account Inactivity\n\nDear iFAMS User,\nYour user id '|| user_id ||' in iFAMS has expired and you need to contact the FSC service desk to get it reset, https://vaww.cpm.fsc.va.gov/.\n\n***Please do not reply to this email***\n\nThanks,\n VA FMBT iFAMS Support" | /usr/sbin/sendmail ' || '-f DoNotReply@va.gov ' || email_addr);
					end if;
			end loop;
			exit;
		end if;
	end loop;
EXCEPTION
   when others then --trap all errors and rollback
   rollback;
   raise_application_error(-20001, sqlerrm);
END;
/


spool off;
exit;


