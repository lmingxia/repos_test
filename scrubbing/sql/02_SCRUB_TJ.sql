set timing on;
set define off;
set echo on;

spool /mnt/cgi_tech_team/scripts/DB/Dev/scrubbing/logs/02_SCRUB_TJ.log;

alter session force parallel ddl parallel 10;
alter session force parallel dml parallel 10;
alter session force parallel query parallel 10;

--PJB -- 1/6/2016 -- breaking down to use a temp table -- declare
--PJB -- 1/6/2016 -- breaking down to use a temp table --    counter INTEGER := 0;
--PJB -- 1/6/2016 -- breaking down to use a temp table --    seedval NUMBER(9,0) := 123400000;
--PJB -- 1/6/2016 -- breaking down to use a temp table --    oldnum CHAR(9);
--PJB -- 1/6/2016 -- breaking down to use a temp table --    newnum CHAR(9);
--PJB -- 1/6/2016 -- breaking down to use a temp table --    cursor allnums is select distinct ssn from openffs.mf_vend where ssn_in = 'S' union select distinct e.socl_scty_num from openffs.mf_empl e where not exists (select 1 from openffs.ssn_xwlk v where trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null;
--PJB -- 1/6/2016 -- breaking down to use a temp table -- 
--PJB -- 1/6/2016 -- breaking down to use a temp table --    pointer allnums%ROWTYPE;
--PJB -- 1/6/2016 -- breaking down to use a temp table -- begin
--PJB -- 1/6/2016 -- breaking down to use a temp table --    for pointer in allnums
--PJB -- 1/6/2016 -- breaking down to use a temp table --       loop
--PJB -- 1/6/2016 -- breaking down to use a temp table --         counter := counter+1;
--PJB -- 1/6/2016 -- breaking down to use a temp table --         oldnum  := SUBSTR(pointer.ssn,1,9);
--PJB -- 1/6/2016 -- breaking down to use a temp table --         newnum  := LTRIM(TO_CHAR(seedval + counter, '999999999'));
--PJB -- 1/6/2016 -- breaking down to use a temp table -- 
--PJB -- 1/6/2016 -- breaking down to use a temp table -- --PJB -- moving to #4 -- update openffs.MF_SV_LN                             set VEND_SSN                      = newnum where VEND_SSN               = oldnum;
--PJB -- 1/6/2016 -- breaking down to use a temp table -- --PJB -- moving to #4 -- commit;
--PJB -- 1/6/2016 -- breaking down to use a temp table -- update openffs.MF_TJ                                set VEND_SSN                      = newnum where VEND_SSN               = oldnum;
--PJB -- 1/6/2016 -- breaking down to use a temp table -- commit;
--PJB -- 1/6/2016 -- breaking down to use a temp table -- 
--PJB -- 1/6/2016 -- breaking down to use a temp table --    end loop;
--PJB -- 1/6/2016 -- breaking down to use a temp table -- end;
--PJB -- 1/6/2016 -- breaking down to use a temp table -- /

create table openffs.TJ_UPDATES (
OLDNUM varchar2(9),
VEND_SSN varchar2(9),
UID_LO varchar2(30),
NEWNUM varchar2(9));

set timing on;
set define off;
set echo on;
set serveroutput on;
declare
   counter INTEGER := 0;
   --seedval NUMBER(9,0) := 123400000;
   oldnum varCHAR2(9);
   v_newnum  varCHAR2(9);
   tj_ssn varCHAR2(9);
   tj_uid varCHAR2(30);
   
   --PJB -- rather than cycle through all of the records returned by this query we can pull only records that match and update those on MF_TJ
   --PJB -- cursor allnums is select distinct ssn from openffs.mf_vend where ssn_in = 'S' union select distinct e.socl_scty_num from openffs.mf_empl e where not exists (select 1 from openffs.ssn_xwlk v where trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null;
   cursor allnums is select distinct trim(v.ssn) SSN, NEWNUM, trim(tj.vend_ssn) VEND_SSN, tj.uid_lo 
   										from openffs.ssn_xwlk v, openffs.mf_tj tj 
   										where trim(v.ssn) = trim(tj.vend_ssn) 
   										and newnum is not null
   											union 
   									 	select distinct e.socl_scty_num, null, null, null 
   									 	from openffs.mf_empl e 
   									 	where not exists (select 1 from openffs.ssn_xwlk v where trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null;

   pointer allnums%ROWTYPE;
begin
   for pointer in allnums
      loop
        counter := counter+1;
        oldnum  := SUBSTR(pointer.ssn,1,9);
        --newnum  := LTRIM(TO_CHAR(seedval + counter, '999999999'));
        v_newnum  := pointer.newnum;
        tj_ssn  := SUBSTR(pointer.vend_ssn,1,9);
        tj_uid  := pointer.UID_LO;

				insert into openffs.TJ_UPDATES values (oldnum,tj_ssn,tj_uid,v_newnum);

				--PJB -- update openffs.MF_TJ                                set VEND_SSN                      = newnum where VEND_SSN               = oldnum;
				--PJB -- commit;
   end loop;
end;
/
commit;

MERGE INTO openffs.MF_TJ T
USING (SELECT DISTINCT UID_LO, NEWNUM FROM openffs.TJ_UPDATES) N
ON (T.UID_LO = N.UID_LO)
WHEN MATCHED THEN UPDATE
SET T.VEND_SSN = N.NEWNUM;

commit;
--PJB -- for any records that are not on Vendor table and are not 999 we'll just update to be 888888888
update openffs.MF_TJ set VEND_SSN = '888888888' where VEND_SSN is not null and substr(VEND_SSN,1,3) not in ('123','234','999');
commit;

drop table openffs.TJ_UPDATES;


commit;
spool off;
exit;
