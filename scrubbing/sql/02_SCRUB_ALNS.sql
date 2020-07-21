set timing on;
set define off;
set echo on;
set serveroutput on;

spool /mnt/cgi_tech_team/scripts/DB/Dev/scrubbing/logs/02_SCRUB_ALNS.log;

alter session force parallel ddl parallel 10;
alter session force parallel dml parallel 10;
alter session force parallel query parallel 10;

--create index openffs.LINE_VEND_SSN_28	on openffs.MF_ALNS                            	(	LINE_VEND_SSN                 	);

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
--PJB -- 1/6/2016 -- breaking down to use a temp table -- 				update openffs.MF_ALNS                              set LINE_VEND_SSN                 = newnum where LINE_VEND_SSN          = oldnum;
--PJB -- 1/6/2016 -- breaking down to use a temp table -- 				commit;
--PJB -- 1/6/2016 -- breaking down to use a temp table -- 				update openffs.MF_DOCS                              set VEND_SSN                      = newnum where VEND_SSN               = oldnum;
--PJB -- 1/6/2016 -- breaking down to use a temp table -- 				commit;
--PJB -- 1/6/2016 -- breaking down to use a temp table --    end loop;
--PJB -- 1/6/2016 -- breaking down to use a temp table -- end;
--PJB -- 1/6/2016 -- breaking down to use a temp table -- /

create table openffs.ALNS_UPDATES (
OLDNUM varchar2(9),
LINE_VEND_SSN varchar2(9),
UIDY varchar2(100),
NEWNUM varchar2(9));

declare
   counter INTEGER := 0;
   --seedval NUMBER(9,0) := 123400000;
   oldnum varCHAR2(9);
   v_newnum varCHAR2(9);
   alns_LINE_VEND_SSN varCHAR2(9);
   alns_uidy varCHAR2(100);
   --PJB -- rather than cycle through all of the records returned by this query we can pull only records that match and update those on MF_ALNS
   --PJB -- cursor allnums is select distinct ssn from openffs.mf_vend where ssn_in = 'S' union select distinct e.socl_scty_num from openffs.mf_empl e where not exists (select 1 from openffs.ssn_xwlk v where trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null;
   cursor allnums is select distinct trim(v.ssn) SSN, NEWNUM, trim(alns.LINE_VEND_SSN) LINE_VEND_SSN, alns.uidy 
   										from openffs.ssn_xwlk v, openffs.mf_alns alns 
   										where trim(v.ssn) = trim(alns.LINE_VEND_SSN) 
   										and newnum is not null
										  	union 
										 	select distinct e.socl_scty_num, null, null, null 
										 	from openffs.mf_empl e 
										 	where not exists (select 1 from openffs.ssn_xwlk v where trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null										 	;

   pointer allnums%ROWTYPE;
begin
   for pointer in allnums
      loop
        counter := counter+1;
        oldnum  := SUBSTR(pointer.ssn,1,9);
        --newnum  := LTRIM(TO_CHAR(seedval + counter, '999999999'));
        v_newnum  := pointer.newnum;
        alns_LINE_VEND_SSN  := SUBSTR(pointer.LINE_VEND_SSN,1,9);
        alns_uidy  := pointer.UIDY;

				insert into openffs.ALNS_UPDATES values (oldnum,alns_LINE_VEND_SSN,alns_uidy,v_newnum);

   end loop;
end;
/
commit;


MERGE INTO openffs.MF_ALNS A
USING (SELECT DISTINCT UIDY, NEWNUM FROM openffs.ALNS_UPDATES) N
ON (A.UIDY = N.UIDY)
WHEN MATCHED THEN UPDATE
SET A.LINE_VEND_SSN = N.NEWNUM;

commit;
--PJB -- for any records that are not on Vendor table and are not 999 we'll just update to be 888888888
update openffs.mf_alns set LINE_VEND_SSN = '888888888' where LINE_VEND_SSN is not null and substr(LINE_VEND_SSN,1,3) not in ('123','234','999');
commit;

--drop index openffs.LINE_VEND_SSN_28        ;

drop table openffs.ALNS_UPDATES;

commit;
spool off;
exit;
