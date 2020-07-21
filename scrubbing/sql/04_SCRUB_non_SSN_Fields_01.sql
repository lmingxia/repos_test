set timing on;
set define off;
set echo on;

spool /mnt/cgi_tech_team/scripts/DB/Dev/scrubbing/logs/04_SCRUB_non_SSN_Fields_01.log;

alter session force parallel ddl parallel 16;
alter session force parallel dml parallel 16;


--CRCD_ID -- nothing to update
select distinct crcd_id from MF_PRNC_CRCD_JN  ;
select distinct crcd_id from MF_EMAL_CRCD_JN  ;
select distinct crcd_id from MF_CRCD_RCON     ;
--PJB -- column does not exist anymore -- select distinct crcd_id from MF_CRCD_TRAN     ;
select distinct crcd_id from MF_CRCD_BLCY     ;
select distinct crcd_id from MF_CRCD_DSPT     ;
select distinct crcd_id from MF_CRCD_LOG      ;
select distinct crcd_id from MF_CRSL          ;

--CRCD_NUM
update openffs.MF_ADDR_LEVL_VEND set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_ARCH_TJ        set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_BD          set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_BD_AMD      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_BD_FORM      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_BILL_SCHG_TYPE      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_BILL_STMT      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_CCSOB_XWLK_DTAL      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_CCS_STG_REC      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_CIR_INBD_XWLK_DTAL set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_CIR_STGN      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_CR_FRM_LN      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_DTBL_REC          set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_DTBL_REC_FRM      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_EA_LN          set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_EA_FRM_LN      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_EA_DOC_LN      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_ED_LN          set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_ED_FRM_LN      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_ED_DOC_LN      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_IC_FRM         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_IO_FRM         set crcd_num = null where crcd_num is not null;
commit;
update openffs.MF_IP_ACTG_LN         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_IP_FRM_ACTG_LN         set crcd_num = null where crcd_num is not null;
commit;
update openffs.MF_IQ_FRM         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_IV_FRM         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_PAY_GOV_HIST         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_PAY_GOV_TRAN         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_PGIB_STGN         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_PGIB_XWLK_DTAL         set crcd_num = null where crcd_num is not null;
commit; 
--PJB -- table no longer exists -- update openffs.MF_PYFT_ACTG_LN         set crcd_num = null where crcd_num is not null;
--PJB -- table no longer exists -- commit; 
update openffs.MF_PYT_FRM_ACTG_LN         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_QS_FRM         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_RS_FRM         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_TA_FRM_LN      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_TA_FRM         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_TC_FRM_LN      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_TC_FRM         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_TG_FRM         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_TI_FRM         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_TJ             set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_TN_FRM_LN      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_TR_FRM         set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_TV_FRM_LN      set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_VEND_DOC_LN    set crcd_num = null where crcd_num is not null;
commit; 
update openffs.MF_VEND_FRM_LN    set crcd_num = null where crcd_num is not null;
commit; 



--CRCD_NUM_ID
update openffs.MF_IC    set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_IO_AMD    set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_IQ_AMD    set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_IV    set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_MULT_CRCD_DOC_JN    set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_MULT_CRCD_TRAN_JN    set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_QA_AMD    set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_QO_AMD    set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_QS        set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_QS_AMD    set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_RS        set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_TA_AMD        set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_TA_LN     set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_TA_LN_AMD set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_TC        set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_TC_AMD    set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_TC_LN     set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_TC_LN_AMD     set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_TG        set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_TC_AMD set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_TI        set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_TN_LN     set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_TR        set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_TR_AMD    set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 
update openffs.MF_TV_LN     set CRCD_NUM_ID = null where crcd_num_id is not null;
commit; 




--SOCL_SCTY_NUM
select column_name, table_name from all_tab_cols where column_name like '%SOCL_SCTY_NUM%' and table_name not like '%PRE%';

--TAX_IDNT
--update MF_TN99R_QRY        set TAX_IDNT_NUM_IN = '999999' where TAX_IDNT_NUM_IN  is not null;
--update MF_TN99R_QRY        set TAX_IDNT_NUM    = '999999' where TAX_IDNT_NUM     is not null;
--update MF_TN99R_M_DTL      set TAX_IDNT_NUM_IN = '999999' where TAX_IDNT_NUM_IN  is not null;
commit; 


select to_char(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') from dual;

create index 	 OPENFFS.TAX_IDNT_NUM_1 on OPENFFS.MF_ADDR_LEVL_VEND                       	(	TAX_IDNT_NUM                      	);
create index 	 OPENFFS.TAX_IDNT_NUM_2 on OPENFFS.MF_DISB_IN_PRCS                         	(	TAX_IDNT_NUM                      	);
--PJB -- index not allowed on this table/column -- create index 	 OPENFFS.TAX_IDNT_NUM_3 on OPENFFS.MF_DOCS_SOLR_INDEX                         	(	TAX_IDNT_NUM                      	);
create index 	 OPENFFS.TAX_IDNT_NUM_4 on OPENFFS.MF_TN99D                                	(	TAX_IDNT_NUM                      	);
create index 	 OPENFFS.TAX_IDNT_NUM_5 on OPENFFS.MF_TN99E_ACTY_LOG                       	(	TAX_IDNT_NUM                      	);
create index 	 OPENFFS.TAX_IDNT_NUM_6 on OPENFFS.MF_TN99E_DTL                            	(	TAX_IDNT_NUM                      	);
create index 	 OPENFFS.TAX_IDNT_NUM_7 on OPENFFS.MF_TN99R_C_DTL                          	(	TAX_IDNT_NUM                      	);
create index 	 OPENFFS.TAX_IDNT_NUM_8 on OPENFFS.MF_TN99R_G_DTL                          	(	TAX_IDNT_NUM                      	);
create index 	 OPENFFS.TAX_IDNT_NUM_9 on OPENFFS.MF_TN99R_I_DTL                          	(	TAX_IDNT_NUM                      	);
create index 	 OPENFFS.TAX_IDNT_NUM_10 on OPENFFS.MF_TN99R_M_DTL                          	(	TAX_IDNT_NUM                      	);
--PJB -- index not allowed on this table/column -- create index 	 OPENFFS.TAX_IDNT_NUM_11 on OPENFFS.MF_TN99R_QRY                          	(	TAX_IDNT_NUM                      	);
--create index 	 openffs.TAX_IDNT_NUM_12 on openffs.MF_VEND                                 	(	TAX_IDNT_NUM                      	);
create index 	 OPENFFS.TAX_IDNT_NUM_13 on OPENFFS.MF_VEND_DOC                             	(	TAX_IDNT_NUM                      	);
create index 	 OPENFFS.TAX_IDNT_NUM_14 on OPENFFS.MF_VEND_DOC_LN                          	(	TAX_IDNT_NUM                      	);
create index 	 OPENFFS.TAX_IDNT_NUM_15 on OPENFFS.MF_VEND_FRM                             	(	TAX_IDNT_NUM                      	);
create index 	 OPENFFS.TAX_IDNT_NUM_16 on OPENFFS.MF_VEND_FRM_LN                          	(	TAX_IDNT_NUM                      	);


Begin
dbms_stats.gather_table_stats(
tabname => 'MF_TN99R_M_DTL',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_TN99R_I_DTL',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_TN99R_G_DTL',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_TN99R_C_DTL',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_TN99E_ACTY_LOG',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_TN99E_DTL',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_TN99D',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_VEND_DOC_LN',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_VEND_DOC',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_VEND_DOC_LN',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_VEND_DOC',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_VEND',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_VEND_FRM',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_ADDR_LEVL_VEND',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_DISB_IN_PRCS',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/

Begin
dbms_stats.gather_table_stats(
tabname => 'MF_VEND_FRM_LN',
ownname => 'OPENFFS',
estimate_percent => 20,
cascade => TRUE,
degree => 16
);
end;
/




select to_char(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') from dual;

create table OPENFFS.temp_tax_idnt_num (
oldnum varchar2(100),
newnum varchar2(100)
);

set serveroutput on;

declare
   counter INTEGER := 0;
   seedval NUMBER(9,0) := 123400000;
   oldnum CHAR(9);
   newnum CHAR(9);
   cursor allnums is select distinct tax_idnt_num from openffs.mf_vend where ssn_in = 'T' and tax_idnt_num is not null order by tax_idnt_num desc;

   pointer allnums%ROWTYPE;
begin
   for pointer in allnums
      loop
        counter := counter+1;
        oldnum  := SUBSTR(pointer.tax_idnt_num,1,9);
        newnum  := LTRIM(TO_CHAR(seedval + counter, '999999999'));

				--dbms_output.put_line('new num - ' || newnum);

				insert into OPENFFS.temp_tax_idnt_num values (oldnum, newnum);
				commit;
   end loop;
end;
/

-- JV 12/9/13 -- Comparison failed on some tables that had tax_idnt_num as a varchar(11), substr() guarantees same string length.
update OPENFFS.MF_ADDR_LEVL_VEND set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_ADDR_LEVL_VEND where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
commit;
update OPENFFS.MF_DISB_IN_PRCS   set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_DISB_IN_PRCS where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
commit;
--PJB -- update not allowed on this table/column -- update OPENFFS.MF_DOCS_SOLR_INDEX   set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_DISB_IN_PRCS where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
--PJB -- update not allowed on this table/column -- commit;
update OPENFFS.MF_TN99D          set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_TN99D where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
commit;
update OPENFFS.MF_TN99E_ACTY_LOG set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_TN99E_ACTY_LOG where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
commit;
update OPENFFS.MF_TN99E_DTL      set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_TN99E_DTL where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
commit;
update OPENFFS.MF_TN99R_C_DTL    set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_TN99R_C_DTL where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
commit;
update OPENFFS.MF_TN99R_G_DTL    set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_TN99R_G_DTL where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
commit;
update OPENFFS.MF_TN99R_I_DTL    set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_TN99R_I_DTL where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
commit;
update OPENFFS.MF_TN99R_M_DTL    set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_TN99R_M_DTL where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
commit;
--PJB -- cannot update a view -- update OPENFFS.MF_TN99R_QRY    set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_TN99R_M_DTL where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
--PJB -- cannot update a view -- commit;
update OPENFFS.MF_VEND           set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_VEND where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
commit;
update OPENFFS.MF_VEND_DOC       set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_VEND_DOC where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
commit;
update OPENFFS.MF_VEND_DOC_LN    set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_VEND_DOC_LN where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
commit;
update OPENFFS.MF_VEND_FRM       set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_VEND_FRM where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
commit;
update OPENFFS.MF_VEND_FRM_LN    set tax_idnt_num = (select newnum from OPENFFS.temp_tax_idnt_num where substr(tax_idnt_num, 1, 9) = substr(oldnum, 1, 9) and rownum <= 1) where  substr(tax_idnt_num,1,9) in (select substr(oldnum,1,9) from OPENFFS.temp_tax_idnt_num, OPENFFS.MF_VEND_FRM_LN where substr(tax_idnt_num,1,9) = substr(oldnum,1,9));       
commit;


drop table openffs.temp_tax_idnt_num;

commit;

update OPENFFS.MF_TN99R_M_DTL    set tax_idnt_num = '888888888' where substr(tax_idnt_num,1,3) <> '123';
commit;
update OPENFFS.MF_TN99R_I_DTL    set tax_idnt_num = '888888888' where substr(tax_idnt_num,1,3) <> '123';
commit;
update OPENFFS.MF_TN99R_G_DTL    set tax_idnt_num = '888888888' where substr(tax_idnt_num,1,3) <> '123';
commit;
update OPENFFS.MF_TN99R_C_DTL    set tax_idnt_num = '888888888' where substr(tax_idnt_num,1,3) <> '123';
commit;
update OPENFFS.MF_TN99E_ACTY_LOG set tax_idnt_num = '888888888' where substr(tax_idnt_num,1,3) <> '123';
commit;
update OPENFFS.MF_TN99E_DTL      set tax_idnt_num = '888888888' where substr(tax_idnt_num,1,3) <> '123';
commit;
update OPENFFS.MF_TN99D          set tax_idnt_num = '888888888' where substr(tax_idnt_num,1,3) <> '123';
commit;
update OPENFFS.MF_VEND_DOC_LN    set tax_idnt_num = '888888888' where substr(tax_idnt_num,1,3) <> '123';
commit;
update OPENFFS.MF_VEND_DOC       set tax_idnt_num = '888888888' where substr(tax_idnt_num,1,3) <> '123';
commit;
update OPENFFS.MF_VEND           set tax_idnt_num = '888888888' where substr(tax_idnt_num,1,3) <> '123';
commit;
update OPENFFS.MF_VEND_FRM       set tax_idnt_num = '888888888' where substr(tax_idnt_num,1,3) <> '123';
commit;
update OPENFFS.MF_ADDR_LEVL_VEND set tax_idnt_num = '888888888' where substr(tax_idnt_num,1,3) <> '123';
commit;
update OPENFFS.MF_DISB_IN_PRCS   set tax_idnt_num = '888888888' where substr(tax_idnt_num,1,3) <> '123';
commit;
update OPENFFS.MF_VEND_FRM_LN    set tax_idnt_num = '888888888' where substr(tax_idnt_num,1,3) <> '123';
commit;

select to_char(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') from dual;


drop index OPENFFS.TAX_IDNT_NUM_1	 ;
drop index OPENFFS.TAX_IDNT_NUM_2	 ;
--PJB -- index not allowed on this table/column -- drop index OPENFFS.TAX_IDNT_NUM_3	 ;
drop index OPENFFS.TAX_IDNT_NUM_4	 ;
drop index OPENFFS.TAX_IDNT_NUM_5	 ;
drop index OPENFFS.TAX_IDNT_NUM_6	 ;
drop index OPENFFS.TAX_IDNT_NUM_7	 ;
drop index OPENFFS.TAX_IDNT_NUM_8	 ;
drop index OPENFFS.TAX_IDNT_NUM_9	 ;
--drop index TAX_IDNT_NUM_10 ; 
--PJB -- index not allowed on this table/column -- drop index OPENFFS.TAX_IDNT_NUM_11 ; 
--drop index OPENFFS.TAX_IDNT_NUM_12 ; 
drop index OPENFFS.TAX_IDNT_NUM_13 ; 
drop index OPENFFS.TAX_IDNT_NUM_14 ;                  
drop index OPENFFS.TAX_IDNT_NUM_15 ;                  
drop index OPENFFS.TAX_IDNT_NUM_16 ;                  

select to_char(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') from dual;

set define off;


--  ***************************************************************************
--  Truncate Bank Tables
--  ***************************************************************************
TRUNCATE TABLE openffs.MF_BANK;
commit;
TRUNCATE TABLE openffs.MF_BANK_CRCY_JN;
commit;
TRUNCATE TABLE openffs.MF_PYTP_BANK_JN;
commit;
---------------------------------------------
----------------------------------


--  ***************************************************************************
--  Create Fake Bank
--  ***************************************************************************
insert into mf_bank (ACPS_EFT_PYMS,ADDR_FRMT,CD,NM,RSTR_CRCY_FL,UIDY,USDO_BANK_FL,ADDR_CITY,ADDR_CNTC,ADDR_CNTY,ADDR_CTRY,ADDR_EMAL,ADDR_FAX,ADDR_L1
,ADDR_L2,ADDR_L3,ADDR_L4,ADDR_L5,ADDR_NM,ADDR_PHON,ADDR_STAE,ADDR_TITL,ADDR_ZPCD,BANK_NUM,CRRS_BANK_ID,DSCR,OPLK,OVRS_RTNG_NUM,SWIF_BIC,SCTY_ORGN_ID
,ACPT_WIRE_TSFR_FL,ACTV_FL,AGCY_BANK_FL,EFCT_ENDT,EFCT_STDT,SHRT_NM)
values ('T','U','999999999','VAVAVAVA','F','&1248&999999999','F','Austin','','','US','','','1234 VA AVE','','','','','VAVAVAVA',''
,'TX','','99999','999999999','','',SYSDATE,'','999999999','&7802&FINVAA','F','T','','','','');
commit;

-------------------------------------------------------------------------------


--  ***************************************************************************
--  Add all Currencies to Fake Bank
--  ***************************************************************************
DECLARE

  --  *************************************************************************
  --  Varying Array type to hold currencies
  --  *************************************************************************
  TYPE crcy_arr_type IS TABLE OF VARCHAR2(3);
  -----------------------------------------------------------------------------

  crcy_arr crcy_arr_type;
  crcy VARCHAR2(3);
  ins_str VARCHAR2(32767);
BEGIN

  --  *************************************************************************
  --  Initialize currency array with currencies
  --  *************************************************************************
  crcy_arr := crcy_arr_type('001', '002', '003', '004', '005', '006', '007',
                            '008', '009', '010', '011', '013', '014', '022',
                            '023', '024', '037', '040', '044', '054', '055',
                            '058', '068', '074', '075', '082', '084', '102',
                            '103', '104', '105', '106', '107', '108', '109',
                            '110', '111', '112', '114', '116', '118', '120',
                            '122', '123', '124', '126', '127', '128', '129',
                            '130', '132', '134', '136', '137', '138', '139',
                            '140', '142', '202', '203', '204', '206', '207',
                            '212', '214', '215', '216', '217', '218', '221',
                            '225', '226', '227', '228', '230', '231', '232',
                            '234', '236', '240', '242', '244', '246', '248',
                            '249', '250', '252', '254', '255', '256', '259',
                            '260', '261', '262', '264', '265', '266', '267',
                            '268', '270', '274', '276', '278', '282', '284',
                            '286', '289', '290', '292', '293', '296', '302',
                            '303', '304', '305', '306', '307', '308', '310',
                            '311', '312', '313', '314', '315', '316', '318',
                            '319', '320', '324', '325', '326', '331', '334',
                            '347', '350', '354', '355', '395', '404', '405',
                            '408', '409', '410', '412', '416', '428', '432',
                            '435', '438', '440', '441', '445', '446', '450',
                            '456', '460', '462', '463', '464', '470', '476',
                            '480', '483', '504', '506', '507', '508', '509',
                            '510', '511', '512', '514', '515', '516', '518',
                            '519', '520', '521', '522', '523', '524', '525',
                            '527', '528', '530', '542', '543', '544', '548',
                            '554', '555', '557', '558', '559', '560', '561',
                            '562', '563', '564', '566', '567', '568', '569',
                            '574', '575', '576', '577', '578', '582', '584',
                            '585', '607', '614', '690', '856', '903', '906',
                            '912', '916', '917', '918', '934', '936', '940',
                            '947', '948', '950', '951', '952', '956', '965',
                            '966', '967', '970', '990');
  -----------------------------------------------------------------------------

  FOR crcy_idx IN crcy_arr.FIRST .. crcy_arr.LAST
  LOOP
    crcy := crcy_arr(crcy_idx);

    --  ***********************************************************************
    --  Insert currency data into MF_BANK_CRCY_JN
    --  ***********************************************************************
    ins_str := 'INSERT INTO openffs.MF_BANK_CRCY_JN' || CHR(13) || CHR(10) ||
               '  (OPLK,' || CHR(13) || CHR(10) ||
               '   UIDY,' || CHR(13) || CHR(10) ||
               '   BANK_ID,' || CHR(13) || CHR(10) ||
               '   CRCY_ID)' || CHR(13) || CHR(10) ||
               'VALUES' || CHR(13) || CHR(10) ||
               '  (SYSDATE,' || CHR(13) || CHR(10) ||
               '   ''&5010&999999999&' || crcy || ''',' || CHR(13) || CHR(10) ||
               '   ''&1248&999999999'',' || CHR(13) || CHR(10) ||
               '   ''&8001&' || crcy || ''')';
    EXECUTE IMMEDIATE ins_str;
    ---------------------------------------------------------------------------
    commit;
  END LOOP;
END;
/
-------------------------------------------------------------------------------
commit;

--  ***************************************************************************
--  Add all Payment Types to Fake Bank
--  ***************************************************************************

  --  *************************************************************************
  --  Add Payment Type ACH
  --  *************************************************************************
  INSERT INTO openffs.MF_PYTP_BANK_JN
    (UIDY,
     LEFT_ID,
     OPLK,
     RIHT_ID)
  VALUES
    ('&1260&1256&ACH&1248&999999999',
     '&1248&999999999',
     SYSDATE,
     '&1256&ACH');
  -----------------------------------------------------------------------------

commit;
  --  *************************************************************************
  --  Add Payment Type ACH-CCD
  --  *************************************************************************
  INSERT INTO openffs.MF_PYTP_BANK_JN
    (UIDY,
     LEFT_ID,
     OPLK,
     RIHT_ID)
  VALUES
    ('&1260&1256&ACH-CCD&1248&999999999',
     '&1248&999999999',
     SYSDATE,
     '&1256&ACH-CCD');
  -----------------------------------------------------------------------------
commit;

  --  *************************************************************************
  --  Add Payment Type ACH-CTX
  --  *************************************************************************
  INSERT INTO openffs.MF_PYTP_BANK_JN
    (UIDY,
     LEFT_ID,
     OPLK,
     RIHT_ID)
  VALUES
    ('&1260&1256&ACH-CTX&1248&999999999',
     '&1248&999999999',
     SYSDATE,
     '&1256&ACH-CTX');
  -----------------------------------------------------------------------------
commit;

  --  *************************************************************************
  --  Add Payment Type ACH-PPD
  --  *************************************************************************
  INSERT INTO openffs.MF_PYTP_BANK_JN
    (UIDY,
     LEFT_ID,
     OPLK,
     RIHT_ID)
  VALUES
    ('&1260&1256&ACH-PPD&1248&999999999',
     '&1248&999999999',
     SYSDATE,
     '&1256&ACH-PPD');
  -----------------------------------------------------------------------------
commit;

  --  *************************************************************************
  --  Add Payment Type CCDPPD
  --  *************************************************************************
  INSERT INTO openffs.MF_PYTP_BANK_JN
    (UIDY,
     LEFT_ID,
     OPLK,
     RIHT_ID)
  VALUES
    ('&1260&1256&CCDPPD&1248&999999999',
     '&1248&999999999',
     SYSDATE,
     '&1256&CCDPPD');
  -----------------------------------------------------------------------------
commit;

  --  *************************************************************************
  --  Add Payment Type EFT
  --  *************************************************************************
  INSERT INTO openffs.MF_PYTP_BANK_JN
    (UIDY,
     LEFT_ID,
     OPLK,
     RIHT_ID)
  VALUES
    ('&1260&1256&EFT&1248&999999999',
     '&1248&999999999',
     SYSDATE,
     '&1256&EFT');
  -----------------------------------------------------------------------------

commit;
  --  *************************************************************************
  --  Add Payment Type TFCS
  --  *************************************************************************
  INSERT INTO openffs.MF_PYTP_BANK_JN
    (UIDY,
     LEFT_ID,
     OPLK,
     RIHT_ID)
  VALUES
    ('&1260&1256&TFCS&1248&999999999',
     '&1248&999999999',
     SYSDATE,
     '&1256&TFCS');
  -----------------------------------------------------------------------------
commit;
  --  *************************************************************************
  --  Add Payment Type E
  --  *************************************************************************
  INSERT INTO openffs.MF_PYTP_BANK_JN
    (UIDY,
     LEFT_ID,
     OPLK,
     RIHT_ID)
  VALUES
    ('&1260&1256&E&1248&999999999',
     '&1248&999999999',
     SYSDATE,
     '&1256&E');
  -----------------------------------------------------------------------------
commit;
  --  *************************************************************************
  --  Add Payment Type F
  --  *************************************************************************
  INSERT INTO openffs.MF_PYTP_BANK_JN
    (UIDY,
     LEFT_ID,
     OPLK,
     RIHT_ID)
  VALUES
    ('&1260&1256&F&1248&999999999',
     '&1248&999999999',
     SYSDATE,
     '&1256&F');
  -----------------------------------------------------------------------------
commit;

  --  *************************************************************************
  --  Add Payment Type C
  --  *************************************************************************
  INSERT INTO openffs.MF_PYTP_BANK_JN
    (UIDY,
     LEFT_ID,
     OPLK,
     RIHT_ID)
  VALUES
    ('&1260&1256&C&1248&999999999',
     '&1248&999999999',
     SYSDATE,
     '&1256&C');
  -----------------------------------------------------------------------------
-------------------------------------------------------------------------------
commit;

--  ***************************************************************************
--  Make Vendors reference Fake Bank
--  ***************************************************************************
update openffs.MF_ADDR_LEVL_VEND              set INTM_BANK_ID          = '&1248&999999999' where          INTM_BANK_ID							is not null;
commit; 
update openffs.MF_ADDR_LEVL_VEND              set BANK_INFO_BANK_ID     = '&1248&999999999' where         BANK_INFO_BANK_ID        is not null;
commit; 
update openffs.MF_AGBK_CNTC_JN                set AGCY_BANK_ID          = '&1248&999999999' where         AGCY_BANK_ID             is not null;
commit; 
update openffs.MF_AGCY_BANK                   set PARN_BANK_ID          = '&1248&999999999' where         PARN_BANK_ID             is not null;
commit; 
update openffs.MF_BACT                        set AGCY_BANK_ID          = '&1248&999999999' where         AGCY_BANK_ID             is not null;
commit; 
update openffs.MF_BACT_DOC                    set AGCY_BANK_ID          = '&1248&999999999' where         AGCY_BANK_ID             is not null;
commit; 
update openffs.MF_BACT_FRM                    set AGCY_BANK_ID          = '&1248&999999999' where         AGCY_BANK_ID             is not null;
commit; 
update openffs.MF_BANK                        set CRRS_BANK_ID          = '&1248&999999999' where         CRRS_BANK_ID             is not null;
commit; 
update openffs.MF_BANK_CRCY_JN                set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_BANK_PYMS_PRNT              set INTM_BANK_ID          = '&1248&999999999' where         INTM_BANK_ID             is not null;
commit; 
update openffs.MF_BANK_PYMS_PRNT              set BANK_INFO_BANK_ID     = '&1248&999999999' where         BANK_INFO_BANK_ID        is not null;
commit; 
update openffs.MF_BNK_DISB_SUMR               set INTM_BANK_ID          = '&1248&999999999' where         INTM_BANK_ID             is not null;
commit; 
update openffs.MF_BNK_DISB_SUMR               set BANK_INFO_BANK_ID     = '&1248&999999999' where         BANK_INFO_BANK_ID        is not null;
commit; 
update openffs.MF_BW_LN                       set BANK_INFO_BANK_ID     = '&1248&999999999' where         BANK_INFO_BANK_ID        is not null;
commit; 
update openffs.MF_BW_LN                       set INTM_BANK_ID          = '&1248&999999999' where         INTM_BANK_ID             is not null;
commit; 
update openffs.MF_CHEK_SUMR                   set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_CSHR_NATG                   set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_CX_LINE                     set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_DA_DPOS                     set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_DA_DPOS_AMD                 set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_DEBT_ACCT_DPOS              set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_DSBG_OFFC                   set FRB_OGTR_BANK_ID      = '&1248&999999999' where         FRB_OGTR_BANK_ID         is not null;
commit; 
update openffs.MF_DSBG_OFFC                   set FRB_DEST_BANK_ID      = '&1248&999999999' where         FRB_DEST_BANK_ID         is not null;
commit; 
update openffs.MF_EFT_PYMT_SUMR               set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_EFT_PYMT_SUMR               set PAYE_BANK_ID          = '&1248&999999999' where         PAYE_BANK_ID             is not null;
commit; 
update openffs.MF_EMPL                        set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_IF                          set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_IF                          set BANK_INFO_BANK_ID     = '&1248&999999999' where         BANK_INFO_BANK_ID        is not null;
commit; 
update openffs.MF_II                          set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_II                          set BANK_INFO_BANK_ID     = '&1248&999999999' where         BANK_INFO_BANK_ID        is not null;
commit; 
update openffs.MF_IP                          set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_IP                          set BANK_INFO_BANK_ID     = '&1248&999999999' where         BANK_INFO_BANK_ID        is not null;
commit; 
update openffs.MF_PARN_BANK               set PARN_BANK_CLAS_ID               = '&1248&999999999' where         PARN_BANK_CLAS_ID                  is not null;
commit; 
update openffs.MF_PARN_BANK               set PARN_BANK_CAT_ID               = '&1248&999999999' where         PARN_BANK_CAT_ID                  is not null;
commit; 
update openffs.MF_PARN_BANK               set PARN_BANK_GRP_ID               = '&1248&999999999' where         PARN_BANK_GRP_ID                  is not null;
commit; 
update openffs.MF_PARN_BANK               set PARN_BANK_TYP_ID               = '&1248&999999999' where         PARN_BANK_TYP_ID                  is not null;
commit; 
update openffs.MF_PIR_SUMR               set DEST_BANK_ID               = '&1248&999999999' where         DEST_BANK_ID                  is not null;
commit; 
update openffs.MF_PIR_SUMR               set OGTR_BANK_ID               = '&1248&999999999' where         OGTR_BANK_ID                  is not null;
commit; 
update openffs.MF_PYMT_QRY_HIST               set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_RCON_LNK               set BANK_ACTY_ID               = '&1248&999999999' where         BANK_ACTY_ID                  is not null;
commit; 
update openffs.MF_SCHD_DTAL               set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_TN                          set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_TN                          set BANK_INFO_BANK_ID     = '&1248&999999999' where         BANK_INFO_BANK_ID        is not null;
commit; 
update openffs.MF_TP_LN                       set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_TP_LN                       set BANK_INFO_BANK_ID     = '&1248&999999999' where         BANK_INFO_BANK_ID        is not null;
commit; 
update openffs.MF_TRAN_STUS                   set USDO_BANK_ID          = '&1248&999999999' where         USDO_BANK_ID             is not null;
commit; 
update openffs.MF_TRAN_STUS_DTAL              set USDO_BANK_ID          = '&1248&999999999' where         USDO_BANK_ID             is not null;
commit; 
update openffs.MF_TV                          set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_TV                          set BANK_INFO_BANK_ID     = '&1248&999999999' where         BANK_INFO_BANK_ID        is not null;
commit; 
update openffs.MF_UDSB_PYMT                   set BANK_ID               = '&1248&999999999' where         BANK_ID                  is not null;
commit; 
update openffs.MF_VEND_DOC_LN                 set BANK_INFO_BANK_ID     = '&1248&999999999' where         BANK_INFO_BANK_ID        is not null;
commit; 
update openffs.MF_VEND_DOC_LN                 set INTM_BANK_ID          = '&1248&999999999' where         INTM_BANK_ID             is not null;
commit;



update openffs.MF_ADDR_LEVL_VEND          set INTM_BANK_ACCT_NUM    = '999999999' where INTM_BANK_ACCT_NUM     is not null;
commit; 
update openffs.MF_ADDR_LEVL_VEND          set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_ADDR_LEVL_VEND          set INTM_BANK_ACCT_NUM    = '999999999' where INTM_BANK_ACCT_NUM     is not null;
commit; 
update openffs.MF_ARCH_TJ          set BANK_REF_NUM    = '999999999' where BANK_REF_NUM     is not null;
commit; 
update openffs.MF_BACT_TRAN          set BANK_REF_NUM    = '999999999' where BANK_REF_NUM     is not null;
commit; 
update openffs.MF_BANK_DTL_HST          set BANK_REF_NUM    = '999999999' where BANK_REF_NUM     is not null;
commit; 
update openffs.MF_BANK_PYMS_PRNT          set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_BANK_PYMS_PRNT          set BANK_REF_NUM         = '999999999' where BANK_REF_NUM          is not null;
commit; 
update openffs.MF_BANK_PYMS_PRNT          set INTM_BANK_ACCT_NUM         = '999999999' where INTM_BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_BF_ACTG_DTL_HST          set TO_BANK_REF_NUM         = '999999999' where TO_BANK_REF_NUM          is not null;
commit; 
update openffs.MF_BF_ACTG_DTL_HST          set BANK_REF_NUM         = '999999999' where BANK_REF_NUM          is not null;
commit; 
update openffs.MF_BF_FRM_LN          set TO_BANK_REF_NUM         = '999999999' where TO_BANK_REF_NUM          is not null;
commit; 
update openffs.MF_BF_FRM_LN          set BANK_REF_NUM         = '999999999' where BANK_REF_NUM          is not null;
commit; 
update openffs.MF_BF_LN          set TO_BANK_REF_NUM         = '999999999' where TO_BANK_REF_NUM          is not null;
commit; 
update openffs.MF_BF_LN          set BANK_REF_NUM         = '999999999' where BANK_REF_NUM          is not null;
commit; 
update openffs.MF_BNK_DISB_DTL         set BANK_REF_NUM         = '999999999' where BANK_REF_NUM          is not null;
commit; 
update openffs.MF_BNK_DISB_SUMR           set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_BNK_DISB_SUMR           set INTM_BANK_ACCT_NUM    = '999999999' where INTM_BANK_ACCT_NUM     is not null;
commit; 
update openffs.MF_BW_FRM_LN               set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_BW_FRM_LN               set BANK_REF_NUM    = '999999999' where BANK_REF_NUM     is not null;
commit; 
update openffs.MF_BW_FRM_LN               set INTM_BANK_ACCT_NUM    = '999999999' where INTM_BANK_ACCT_NUM     is not null;
commit; 
update openffs.MF_BW_LN                   set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_BW_LN                   set BANK_REF_NUM         = '999999999' where BANK_REF_NUM          is not null;
commit; 
update openffs.MF_BW_LN                   set INTM_BANK_ACCT_NUM    = '999999999' where INTM_BANK_ACCT_NUM     is not null;
commit; 
update openffs.MF_BZ_FRM_LN	        set BANK_REF_NUM           = '999999999' where BANK_REF_NUM          is not null;
commit;
update openffs.MF_BZ_LN	            set BANK_REF_NUM           = '999999999' where BANK_REF_NUM          is not null;
commit;
update openffs.MF_CIR_COLL_SUMM set BANK_RT_NUM            = '999999999' where BANK_RT_NUM           is not null;
commit;
--PJB -- column update is not necessary -- update openffs.MF_CIR_INBD_XWLK set BANK_ABA_NUM_IN        = '999999999' where BANK_ABA_NUM_IN       is not null;
--PJB -- column update is not necessary -- commit;
--PJB -- column update is not necessary -- update openffs.MF_CIR_INBD_XWLK set BANK_ACCT_ACCT_NUM_IN  = '999999999' where BANK_ACCT_ACCT_NUM_IN is not null;
--PJB -- column update is not necessary -- commit;
--PJB -- column update is not necessary -- update openffs.MF_CIR_INBD_XWLK set BANK_ACCT_NUM_IN       = '999999999' where BANK_ACCT_NUM_IN      is not null;
--PJB -- column update is not necessary -- commit;
update openffs.MF_CIR_INBD_XWLK_DTAL set BANK_ABA_NUM           = '999999999' where BANK_ABA_NUM          is not null;
commit;
update openffs.MF_CIR_INBD_XWLK_DTAL set BANK_ACCT_ACCT_NUM     = '999999999' where BANK_ACCT_ACCT_NUM    is not null;
commit;
update openffs.MF_CIR_INBD_XWLK_DTAL set BANK_ACCT_NUM          = '999999999' where BANK_ACCT_NUM         is not null;
commit;
update openffs.MF_CIR_STGN	            set BANK_ABA_NUM           = '999999999' where BANK_ABA_NUM          is not null;
commit;
update openffs.MF_CIR_STGN	            set BANK_ACCT_ACCT_NUM     = '999999999' where BANK_ACCT_ACCT_NUM    is not null;
commit;
update openffs.MF_CIR_STGN	            set BANK_ACCT_NUM          = '999999999' where BANK_ACCT_NUM         is not null;
commit;
update openffs.MF_CR_FRM_LN	        set BANK_REF_NUM           = '999999999' where BANK_REF_NUM          is not null;
commit;
update openffs.MF_CR_LN	            set BANK_REF_NUM           = '999999999' where BANK_REF_NUM          is not null;
commit;
update openffs.MF_CR_LN_AMD	        set BANK_REF_NUM           = '999999999' where BANK_REF_NUM          is not null;
commit;
update openffs.MF_CX_FRM_LN	        set NEW_BANK_REF_NUM       = '999999999' where NEW_BANK_REF_NUM      is not null;
commit;
update openffs.MF_CX_FRM_LN	        set BANK_REF_NUM           = '999999999' where BANK_REF_NUM          is not null;
commit;
update openffs.MF_CX_LINE	            set NEW_BANK_REF_NUM       = '999999999' where NEW_BANK_REF_NUM      is not null;
commit;
update openffs.MF_CX_LINE	            set BANK_REF_NUM           = '999999999' where BANK_REF_NUM          is not null;
commit;
update openffs.MF_DA_DPOS                 set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_DA_DPOS_AMD             set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_DA_DPOS_FRM             set BANK_ACCT_NUM_CH      = '999999999' where BANK_ACCT_NUM_CH       is not null;
commit; 
update openffs.MF_DEBT_ACCT_DPOS          set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_DISB_IN_PRCS            set BANK_NUM         = '999999999' where BANK_NUM          is not null;
commit; 
update openffs.MF_DISB_IN_PRCS            set BANK_REF_NUM         = '999999999' where BANK_REF_NUM          is not null;
commit; 
update openffs.MF_DISB_IN_PRCS            set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_EFT_PYMT_SUMR           set PAYE_BANK_ACCT_NUM    = '999999999' where PAYE_BANK_ACCT_NUM     is not null;
commit; 
update openffs.MF_EMPL                    set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_IF                      set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_IF                      set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_IF_FRM                  set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_IF_FRM                  set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_IF_FRM_LN               set BANK_REF_NUM     = '999999999' where BANK_REF_NUM      is not null;
commit; 
update openffs.MF_IF_LN               set BANK_REF_NUM     = '999999999' where BANK_REF_NUM      is not null;
commit; 
update openffs.MF_II                      set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_II                      set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_II_FRM                  set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_II_FRM                  set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_IP                      set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_IP                      set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_IP_ACTG_LN               set BANK_REF_NUM     = '999999999' where BANK_REF_NUM      is not null;
commit; 
update openffs.MF_IP_FRM                  set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_IP_FRM                  set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
--PJB -- column does not exist anymore -- update openffs.MF_IP_FRM_ACTG_LN                 set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
--PJB -- column does not exist anymore -- commit; 
update openffs.MF_NTBK_TRAN_LNK                 set ORIG_BANK_REF_NUM     = '999999999' where ORIG_BANK_REF_NUM      is not null;
commit; 
update openffs.MF_PIR_SUMR                 set BANK_ACCT_NUM     = '999999999' where BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_PYFD_ACTG_LN                 set BANK_REF_NUM     = '999999999' where BANK_REF_NUM      is not null;
commit; 
update openffs.MF_PYMT_QRY_HIST           set BANK_ACCT_NUM    = '999999999' where BANK_ACCT_NUM     is not null;
commit; 
update openffs.MF_PYMT_QRY_HIST           set BANK_NUM    = '999999999' where BANK_NUM     is not null;
commit; 
update openffs.MF_PYMT_QRY_HIST           set INTM_BANK_ACCT_NUM    = '999999999' where INTM_BANK_ACCT_NUM     is not null;
commit; 
update openffs.MF_PYMT_QRY_HIST           set INTM_BANK_NUM         = '999999999' where INTM_BANK_NUM          is not null;
commit; 
update openffs.MF_PYMT_QRY_HIST           set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_PYT_FRM_ACTG_LN           set BANK_REF_NUM     = '999999999' where BANK_REF_NUM      is not null;
commit; 
update openffs.MF_RCON_LNK	set BANK_REF_NUM  = '999999999' where BANK_REF_NUM  is not null;
commit;                        
update openffs.MF_SCHD_DTAL	set BANK_ACCT_NUM = '999999999' where BANK_ACCT_NUM is not null;
commit;                        
update openffs.MF_SV_FRM_LN	set BANK_REF_NUM  = '999999999' where BANK_REF_NUM  is not null;
commit;                        
update openffs.MF_SV_LN	    set BANK_REF_NUM  = '999999999' where BANK_REF_NUM  is not null;
commit;                        
update openffs.MF_TJ	    set BANK_REF_NUM  = '999999999' where BANK_REF_NUM  is not null;
commit; 
update openffs.MF_TN                      set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_TN                      set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_TN_FRM                  set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_TN_FRM                  set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_TN_FRM_LN                  set BANK_REF_NUM     = '999999999' where BANK_REF_NUM      is not null;
commit; 
update openffs.MF_TN_LN                  set BANK_REF_NUM     = '999999999' where BANK_REF_NUM      is not null;
commit; 
update openffs.MF_TP_FRM_LN               set BANK_REF_NUM     = '999999999' where BANK_REF_NUM      is not null;
commit; 
update openffs.MF_TP_FRM_LN               set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_TP_FRM_LN               set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_TP_LN                   set BANK_REF_NUM     = '999999999' where BANK_REF_NUM      is not null;
commit; 
update openffs.MF_TP_LN                   set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_TP_LN                   set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
--PJB -- can't update a view -- update openffs.MF_TRAN_ACTY                  set BANK_REF_NUM         = '999999999' where BANK_REF_NUM          is not null;
--PJB -- can't update a view -- commit; 
update openffs.MF_TV                      set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_TV                      set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_TV_FRM                  set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_TV_FRM                  set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_TV_FRM_LN                  set BANK_REF_NUM     = '999999999' where BANK_REF_NUM      is not null;
commit; 
update openffs.MF_TV_LN                  set BANK_REF_NUM     = '999999999' where BANK_REF_NUM      is not null;
commit; 
update openffs.MF_UDSB_PYMT               set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_UDSB_PYMT               set INTM_BANK_NUM    = '999999999' where INTM_BANK_NUM     is not null;
commit; 
update openffs.MF_UDSB_PYMT               set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_UDSB_PYMT               set INTM_BANK_ACCT_NUM         = '999999999' where INTM_BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_UDSB_PYMT               set BANK_NUM         = '999999999' where BANK_NUM          is not null;
commit; 
update openffs.MF_VEND_DOC_LN             set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_VEND_DOC_LN             set INTM_BANK_ACCT_NUM    = '999999999' where INTM_BANK_ACCT_NUM     is not null;
commit; 
update openffs.MF_VEND_DOC_LN             set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_VEND_FRM_LN             set BANK_ACCT_NUM         = '999999999' where BANK_ACCT_NUM          is not null;
commit; 
update openffs.MF_VEND_FRM_LN             set SUB_BANK_ACCT_NUM     = '999999999' where SUB_BANK_ACCT_NUM      is not null;
commit; 
update openffs.MF_VEND_FRM_LN             set INTM_BANK_ACCT_NUM    = '999999999' where INTM_BANK_ACCT_NUM     is not null;
commit;
update openffs.MF_ZERO_PYMT             set BANK_REF_NUM    = '999999999' where BANK_REF_NUM     is not null;
commit;


--other fields
-- JCY -- doesn't exist -- select count(1) from openffs.MF_BANK where RTNG_NUM is not null;
select count(1) from openffs.MF_BANK where OVRS_RTNG_NUM is not null;
select count(1) from openffs.MF_VEND where COMN_PARN_TIN is not null;
select count(1) from openffs.MF_VEND_FRM where COMN_PARN_TIN is not null;
select count(1) from openffs.MF_VEND_DOC where COMN_PARN_TIN is not null;

commit;
spool off;
exit;
