
set linesize 3000 pagesize 3000 trimspool on serveroutput on define off;
spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_Individual_PDB_Post_Refresh_SQL_Sandbox15.log;

--DROP PUBLIC DATABASE LINK "VACONV_RO";
create public database link "VACONV_RO" connect to VACONV_RO identified by "vaconv_ro_123" using 'VACONV';




DECLARE
	cursor sec_prnc is select distinct substr(user_guid,7), substr(scty_orgn_id,7) from openffs.ams_scty_user_dir where upper(dscr) like '%CGI%';  
	--substr(user_guid,7) in --('benjamin.roark','christopher.allen','joyce.gough','stephen.langworthy','luis.maldonado','sean.martin','stephen.robinson','janeifer.smith','nathaniel.wheeler','david.schoenfield'); 
	--cursor sec_prnc is select distinct substr(user_guid,7), substr(scty_orgn_id,7) from openffs.ams_scty_user_dir where substr(user_guid,7) = 'mherd'; 
	
	C1_RECORDS sec_prnc%ROWTYPE;	

	sec_org varchar(100);
	user_id varchar(100);
  
BEGIN
	open sec_prnc;
	loop
		fetch sec_prnc into user_id, sec_org;
		exit when sec_prnc%notfound;
	
		dbms_output.put_line('Deleting all Roles assigned to user > ' || user_id );
		delete from openffs.mf_prnc_role_jn where scty_prnc_id = '&7800&' || user_id and scty_role_id = '&7804&SYSADMIN';
		delete from openffs.mf_prnc_role_jn where scty_prnc_id = '&7800&' || user_id and scty_role_id = '&7804&ADMIN';
		commit;
		
	end loop;
	--commit;
EXCEPTION
   when others then --trap all errors and rollback
   rollback;
   raise_application_error(-20001, sqlerrm);
END;
/



---spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_Individual_PDB_Post_Refresh_SQL_Sandbox15_CACI_Super_Role_All_SecOrgs.log;
---
---
-----MF_SCTY_ROLE
-------To generate insert values -- select '(''' || uidy || ''',''' || cd || ''',''' || efct_endt || ''',''' || efct_stdt || ''',''' || nm || ''',' || 'sysdate' || ',''' || scty_orgn_id || ''',''' || dscr || ''');'  from openffs.mf_scty_role where cd = 'SUPER';
---insert into openffs.mf_scty_role (uidy, cd, efct_endt, efct_stdt, nm, oplk, scty_orgn_id, dscr) values ('&7804&SUPER','SUPER',null,null,'Super Role',sysdate,'&7802&FINVAA','Ability to do all things');
---
-----MF_ROLE_CAT_JN
-------To generate insert values -- select '(''' || uidy_lo || ''',''' || acts ||''',' || sysdate || ',''' || scty_cat_id || ''',''' || scty_role_id || ''');' from openffs.mf_role_cat_jn where scty_role_id = '&7804&SUPER';
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Document/Travel Accounting/TME','!+-1234578BCEFHNPSTWYZbcdfghmnopsvwxyz',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Document/Travel Accounting/TME','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Document/General Ledger/JAE','!+-1234578BCEFHNPSTWYZbcdfghmnopsvwxyz',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Document/General Ledger/JAE','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Document/Accounts Receivable','!+-1234578BCEFHNPSTWYZbcdfghmnopsvwxyz',to_date('07-FEB-19','DD-MON-RR'),'&7801&/.:/Document/Accounts Receivable','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Document/Accounts Receivable/BME','!+-1234578BCEFHNPSTWYZbcdfghmnopsvwxyz',to_date('07-FEB-19','DD-MON-RR'),'&7801&/.:/Document/Accounts Receivable/BME','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Document/Project Cost Accounting','!+-1234578BCEFHNPSTWYZbcdfghmnopsvwxyz',to_date('07-FEB-19','DD-MON-RR'),'&7801&/.:/Document/Project Cost Accounting','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Document/Project Cost Accounting/EDE','!+-1234578BCEFHNPSTWYZbcdfghmnopsvwxyz',to_date('07-FEB-19','DD-MON-RR'),'&7801&/.:/Document/Project Cost Accounting/EDE','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Document Type','PSYaduvy',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Document Type','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Dimension/Fund','OSVadiuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Dimension/Fund','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Dimension/Fund/Code','OSVadiuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Dimension/Fund/Code','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Dimension','OSVadiuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Dimension','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Secured Fields/Vendor Address','Suv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Secured Fields/Vendor Address','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Secured Fields/Vendor Contact','Suv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Secured Fields/Vendor Contact','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Secured Fields/Vendor DUNS','Suv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Secured Fields/Vendor DUNS','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Secured Fields/Vendor DUNS+4','Suv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Secured Fields/Vendor DUNS+4','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Address 1','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Address 1','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Address 2','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Address 2','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Address 3','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Address 3','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Address 4','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Address 4','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Address 5','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Address 5','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Category','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Category','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Class','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Class','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Code','69OSVadfiuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Code','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Group','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Group','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Header 1','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Header 1','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Header 2','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Header 2','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Header 3','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Header 3','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Header 4','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Header 4','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Header 5','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Header 5','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor/Type','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor/Type','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Secured Fields','Suv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Secured Fields','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Evaluations/Vendor Evaluation','MPSYZadefuvy',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Evaluations/Vendor Evaluation','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Evaluations/Vendor Offer','MPSYZadefuvy',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Evaluations/Vendor Offer','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Evaluations/Vendor Offer Workspace','MPSYZadefuvy',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Evaluations/Vendor Offer Workspace','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Security/Approval Template','Saduvy',to_date('28-MAY-19','DD-MON-RR'),'&7801&/.:/Security/Approval Template','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Batch Execution/Batch Job','Sadruv',to_date('31-MAY-19','DD-MON-RR'),'&7801&/.:/Batch Execution/Batch Job','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Batch Execution/Batch Job/BECTRLUPDT','Sadruv',to_date('31-MAY-19','DD-MON-RR'),'&7801&/.:/Batch Execution/Batch Job/BECTRLUPDT','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Layout Manager/Segment Definition','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Layout Manager/Segment Definition','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Project Cost Accounting','BCDHMNPQSTUWYZabcdehlmnoprstuvwxy',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Project Cost Accounting','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acctg Strip Component','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acctg Strip Component','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Clause Details','v',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Clause Details','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Evaluations','MSZadefuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Evaluations','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Evaluations/Offer Evaluation','12347MPSYZadefuvy',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Evaluations/Offer Evaluation','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Rule Maintenance','Sadfuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Rule Maintenance','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Rule Maintenance/Constant','Sadfuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Rule Maintenance/Constant','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Rule Maintenance/Criteria','Sadfuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Rule Maintenance/Criteria','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Rule Maintenance/Field','Sadfuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Rule Maintenance/Field','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Rule Maintenance/Rule Definition','Sadfuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Rule Maintenance/Rule Definition','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Terms and Conditions Maintenance','Sadfuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Terms and Conditions Maintenance','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Terms and Conditions Maintenance/All Clause','Sadfuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Terms and Conditions Maintenance/All Clause','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Terms and Conditions Maintenance/Regulation Level','Sadfuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Terms and Conditions Maintenance/Regulation Level','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Terms and Conditions Maintenance/Terms and Conditions','Sadfuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Terms and Conditions Maintenance/Terms and Conditions','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Acquisitions/Terms and Conditions Maintenance/Terms and Conditions Type','Sadfuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Acquisitions/Terms and Conditions Maintenance/Terms and Conditions Type','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Batch Execution','Sadruv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Batch Execution','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Batch Setup','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Batch Setup','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Budget Maintenance','Sv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Budget Maintenance','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Document','!+-1234578BCEFHNPSTWYZ^bcdfghmnopsvwxyz',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Document','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Dynamic Extension','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Dynamic Extension','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Dynamic Extension/Tenant Dynamic Extension','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Dynamic Extension/Tenant Dynamic Extension','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Dynamic Message Editor','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Dynamic Message Editor','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Dynamic Text Editor','Sv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Dynamic Text Editor','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/External Reports','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/External Reports','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Forms In Process','Sdv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Forms In Process','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Problem Definitions','BCDHMNPSTUWabcdehlmnoprstuvwx',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Problem Definitions','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Query','PSaduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Query','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object','12347SZadfuv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Acquisitions/Procurement Method','Sadu',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Acquisitions/Procurement Method','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Acquisitions/Procurement Type','Sadu',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Acquisitions/Procurement Type','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Attachment Type','aduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Attachment Type','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Vendor','69OPSVYadiuvy',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Vendor','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Referential Integrity/Referenced','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Referential Integrity/Referenced','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Referential Integrity/Referencing','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Referential Integrity/Referencing','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Relationship Edits','BCDHMNPQSTUWYabcdehlmnoprstuvwxy',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Relationship Edits','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Report','Saruv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Report','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Report Definition','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Report Definition','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Report/Acquisitions/Lead Time','Saruv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Report/Acquisitions/Lead Time','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Report/Acquisitions/Workload Assignment Manager','Saruv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Report/Acquisitions/Workload Assignment Manager','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Report/Acquisitions/Workload History','Saruv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Report/Acquisitions/Workload History','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Report/Acquisitions/Workload Summary','Saruv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Report/Acquisitions/Workload Summary','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Report/Desktop/Lead Time','Saruv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Report/Desktop/Lead Time','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Report/Desktop/Workload Assignment','Saruv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Report/Desktop/Workload Assignment','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Report/Desktop/Workload History','Saruv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Report/Desktop/Workload History','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Report/Desktop/Workload Summary','Saruv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Report/Desktop/Workload Summary','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Secured Fields/Vendor Name','Suv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Secured Fields/Vendor Name','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Subsystem','Sv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Subsystem','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Subsystem/General System','@',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Subsystem/General System','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Subsystem/Purchasing','Sv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Subsystem/Purchasing','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Subsystem/System Administration','v',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Subsystem/System Administration','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Subsystem/Workflow','MSuv',to_date('23-MAY-19','DD-MON-RR'),'&7801&/.:/Subsystem/Workflow','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/System Lock','u',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/System Lock','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/System Settings','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/System Settings','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Workflow','AXav',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Workflow','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Workflow/Groups','Suv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Workflow/Groups','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Reference Object/Budget Controls','Saduv',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Reference Object/Budget Controls','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Document/Acquisitions','!+-1234578BCEFGHNPSTWYZ^bcdfghmnopsvwxyz{}',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Document/Acquisitions','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Document/Acquisitions/QAE','!+-1234578BCEFGHNPSTWYZ^bcdfghmnopsvwxyz{}',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Document/Acquisitions/QAE','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Document/Travel Accounting','!+-1234578BCEFHNPSTWYZbcdfghmnopsvwxyz',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Document/Travel Accounting','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Document/Travel Accounting/TAI','!+-1234578BCEFHNPSTWYZbcdfghmnopsvwxyz',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Document/Travel Accounting/TAI','&7804&SUPER');
---Insert into openffs.MF_ROLE_CAT_JN (UIDY_LO,ACTS,OPLK,SCTY_CAT_ID,SCTY_ROLE_ID) values ('&7805&SUPER&/.:/Document/Travel Accounting/TSI','!+-1234578BCEFHNPSTWYZbcdfghmnopsvwxyz',to_date('16-MAY-19','DD-MON-RR'),'&7801&/.:/Document/Travel Accounting/TSI','&7804&SUPER');
---
---
-----MF_SCTY_CAT
-------To generate insert values -- select '(''' || uidy_lo || ''',''' || nm || ''',' || 'sysdate' || ',''' || parn_scty_cat_id || ''',''' || scty_orgn_id || ''');' from openffs.mf_scty_cat where uidy_lo like '%SUPER%';
---Insert into openffs.MF_SCTY_CAT (UIDY_LO,NM,OPLK,PARN_SCTY_CAT_ID,SCTY_ORGN_ID) values ('&7801&/.:/Security/Role/SUPER','/.:/Security/Role/SUPER',sysdate,'&7801&/.:/Security/Role','&7802&FINVAA');
---commit;
---
---
---
-----MF_PRNC_ROLE_JN -- this will insert for all the Sec Orgs
---   ----->>>>>>>>>  Refer to EMR_12173.sql if we need to add in 2nd cursor to be more dynamic on the sec org list
---DECLARE
---
---	cursor sec_orgs is select cd from openffs.mf_scty_orgn where cd not in ('UNUSED','HIDE','ALL','BASE','DEFAULTORG'); 
---	
---	cursor sec_prnc is select distinct substr(user_guid,7) from openffs.ams_scty_user_dir where upper(dscr)like '%CACI%'; 
---	
---	sec_org varchar(100);
---	user_id varchar(100);
---  
---BEGIN
---open sec_orgs;
---loop
---    fetch sec_orgs into sec_org;
---	exit when sec_orgs%notfound;
---	
---	open sec_prnc;
---	loop
---		fetch sec_prnc into user_id;
---		exit when sec_prnc%notfound;
---	
---		dbms_output.put_line('Inserting SUPER role into MF_PRNC_ROLE_JN for USER_ID > ' || user_id || ' and SEC_ORG > ' || sec_org );
---		delete from openffs.mf_prnc_role_jn where uidy = '&7806&SUPER&' || user_id ||'&'|| sec_org;
---		commit;
---		INSERT INTO openffs.mf_prnc_role_jn (uidy, oplk, scty_orgn_id, scty_prnc_id, scty_role_id ) 
---		values
---		('&7806&SUPER&' || user_id ||'&'|| sec_org,
---		SYSDATE, 
---		'&7802&' || sec_org,
---		'&7800&' || user_id, 
---		'&7804&SUPER');
---	end loop;
---	close sec_prnc;
---end loop;
---close sec_orgs;
---
---EXCEPTION
---when others then --trap all errors and rollback
---rollback;
---raise_application_error(-20001, sqlerrm);
---END;
---/
---
---
---commit;
---	
--- 
---spool off;

spool off;

exit;

