set timing on;
set define off;
set echo on;
set serveroutput on;

spool /mnt/cgi_tech_team/scripts/DB/Dev/scrubbing/logs/02_SCRUB_IP.log;
alter session force parallel ddl parallel 10;
alter session force parallel dml parallel 10;
alter session force parallel query parallel 10;

--create index openffs.DGGT_SSN_194	on openffs.MF_IP                              	(	DGGT_SSN                      	);
--create index openffs.VEND_SSN_196	on openffs.MF_IP                              	(	VEND_SSN                      	);

--PJB -- 1/6/2017 -- breaking down to use a TEMP table --- select to_char(SYSDATE, 'MM/DD/YYYY HH24:MI:SS') from dual;
--PJB -- 1/6/2017 -- breaking down to use a TEMP table --- declare
--PJB -- 1/6/2017 -- breaking down to use a TEMP table ---    counter INTEGER := 0;
--PJB -- 1/6/2017 -- breaking down to use a TEMP table ---    seedval NUMBER(9,0) := 123400000;
--PJB -- 1/6/2017 -- breaking down to use a TEMP table ---    oldnum CHAR(9);
--PJB -- 1/6/2017 -- breaking down to use a TEMP table ---    newnum CHAR(9);
--PJB -- 1/6/2017 -- breaking down to use a TEMP table ---    cursor allnums is select distinct ssn from openffs.mf_vend where ssn_in = 'S' union select distinct e.socl_scty_num from openffs.mf_empl e where not exists (select 1 from openffs.ssn_xwlk v where trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null;
--PJB -- 1/6/2017 -- breaking down to use a TEMP table --- 
--PJB -- 1/6/2017 -- breaking down to use a TEMP table ---    pointer allnums%ROWTYPE;
--PJB -- 1/6/2017 -- breaking down to use a TEMP table --- begin
--PJB -- 1/6/2017 -- breaking down to use a TEMP table ---    for pointer in allnums
--PJB -- 1/6/2017 -- breaking down to use a TEMP table ---       loop
--PJB -- 1/6/2017 -- breaking down to use a TEMP table ---         counter := counter+1;
--PJB -- 1/6/2017 -- breaking down to use a TEMP table ---         oldnum  := SUBSTR(pointer.ssn,1,9);
--PJB -- 1/6/2017 -- breaking down to use a TEMP table ---         newnum  := LTRIM(TO_CHAR(seedval + counter, '999999999'));
--PJB -- 1/6/2017 -- breaking down to use a TEMP table --- update openffs.MF_IP                                set DGGT_SSN                      = newnum where DGGT_SSN               = oldnum;
--PJB -- 1/6/2017 -- breaking down to use a TEMP table --- commit;
--PJB -- 1/6/2017 -- breaking down to use a TEMP table --- update openffs.MF_IP                                set VEND_SSN                      = newnum where VEND_SSN               = oldnum;
--PJB -- 1/6/2017 -- breaking down to use a TEMP table --- commit;
--PJB -- 1/6/2017 -- breaking down to use a TEMP table ---    end loop;
--PJB -- 1/6/2017 -- breaking down to use a TEMP table --- end;
--PJB -- 1/6/2017 -- breaking down to use a TEMP table --- /


create table openffs.IP_UPDATES (
OLDNUM varchar2(9),
VEND_SSN varchar2(9),
UIDY varchar2(50),
NEWNUM varchar2(9));

declare
   counter INTEGER := 0;
   --seedval NUMBER(9,0) := 123400000;
   oldnum varCHAR2(9);
   v_newnum varCHAR2(9);
   ip_vend_ssn varCHAR2(9);
   ip_uidy varCHAR2(50);
   --PJB -- rather than cycle through all of the records returned by this query we can pull only records that match and update those on MF_IP
   --PJB -- cursor allnums is select distinct ssn from openffs.mf_vend where ssn_in = 'S' union select distinct e.socl_scty_num from openffs.mf_empl e where not exists (select 1 from openffs.ssn_xwlk v where trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null;
   cursor allnums is select distinct trim(v.ssn) SSN, NEWNUM, trim(ip.vend_ssn) VEND_SSN, ip.uidy 
   										from openffs.ssn_xwlk v, openffs.mf_ip ip 
   										where trim(ssn) = trim(vend_ssn) 
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
        ip_vend_ssn  := SUBSTR(pointer.vend_ssn,1,9);
        ip_uidy  := pointer.UIDY;

				insert into openffs.IP_UPDATES values (oldnum,ip_vend_ssn,ip_uidy,v_newnum);

				--PJB -- update openffs.MF_IP                                set DGGT_SSN                      = newnum where DGGT_SSN               = oldnum;
				--PJB -- commit;
				--PJB -- update openffs.MF_IP                                set VEND_SSN                      = newnum where VEND_SSN               = oldnum;
				--PJB -- commit;
   end loop;
end;
/
commit;

MERGE INTO openffs.MF_IP IP
USING (SELECT DISTINCT UIDY, NEWNUM FROM openffs.IP_UPDATES) N
ON (IP.UIDY = N.UIDY)
WHEN MATCHED THEN UPDATE
SET IP.VEND_SSN = N.NEWNUM;
commit;

--PJB -- for any records that are not on Vendor table and are not 999 we'll just update to be 888888888
update openffs.MF_IP set VEND_SSN = '888888888' where  VEND_SSN is not null and substr(VEND_SSN,1,3) not in ('123','234','999');
commit;

drop table openffs.IP_UPDATES;

----////////////////////////////////////////////////////////////////////////////////////////////////////////////////

create table openffs.IP_UPDATES (
OLDNUM varchar2(9),
DGGT_SSN varchar2(9),
UIDY varchar2(50),
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
   ip_dggt_ssn varCHAR2(9);
   ip_uidy varCHAR2(50);
   --PJB -- rather than cycle through all of the records returned by this query we can pull only records that match and update those on MF_IP
   --PJB -- cursor allnums is select distinct ssn from openffs.mf_vend where ssn_in = 'S' union select distinct e.socl_scty_num from openffs.mf_empl e where not exists (select 1 from openffs.ssn_xwlk v where trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null;
   cursor allnums is select distinct trim(v.ssn) SSN, NEWNUM, trim(ip.dggt_ssn) VEND_SSN, ip.uidy 
   										from openffs.ssn_xwlk v, openffs.mf_ip ip 
   										where trim(ssn) = trim(dggt_ssn) 
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
        ip_dggt_ssn  := SUBSTR(pointer.vend_ssn,1,9);
        ip_uidy  := pointer.UIDY;

				insert into openffs.IP_UPDATES values (oldnum,ip_dggt_ssn,ip_uidy,v_newnum);

				--PJB -- update openffs.MF_IP                                set DGGT_SSN                      = newnum where DGGT_SSN               = oldnum;
				--PJB -- commit;
				--PJB -- update openffs.MF_IP                                set VEND_SSN                      = newnum where VEND_SSN               = oldnum;
				--PJB -- commit;
   end loop;
end;
/
commit;

MERGE INTO openffs.MF_IP IP
USING (SELECT DISTINCT UIDY, NEWNUM FROM openffs.IP_UPDATES) N
ON (IP.UIDY = N.UIDY)
WHEN MATCHED THEN UPDATE
SET IP.DGGT_SSN = N.NEWNUM;

commit;
update openffs.MF_IP set DGGT_SSN = '888888888' where DGGT_SSN is not null and substr(DGGT_SSN,1,3) not in ('123','234','999');
commit;

drop table openffs.IP_UPDATES;
--drop index openffs.DGGT_SSN_194            ;
--drop index openffs.VEND_SSN_196            ;

commit;
spool off;
exit;
