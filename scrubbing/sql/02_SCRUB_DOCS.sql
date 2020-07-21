set timing on;
set define off;
set echo on;
set serveroutput on;

spool /mnt/cgi_tech_team/scripts/DB/Dev/scrubbing/logs/02_SCRUB_DOCS.log;

alter session force parallel ddl parallel 1;
alter session force parallel dml parallel 1;
alter session force parallel query parallel 1;

--create index openffs.VEND_SSN_118	on openffs.MF_DOCS                            	(	VEND_SSN                      	);

create table openffs.DOCS_UPDATES (
OLDNUM varchar2(9),
VEND_SSN varchar2(9),
UIDY varchar2(50),
NEWNUM varchar2(9));

declare
   counter INTEGER := 0;
   --seedval NUMBER(9,0) := 123400000;
   oldnum varCHAR2(9);
   v_newnum varCHAR2(9);
   docs_VEND_SSN varCHAR2(9);
   docs_uidy varCHAR2(50);
   --PJB -- rather than cycle through all of the records returned by this query we can pull only records that match and update those on MF_DOCS
   --PJB -- cursor allnums is select distinct ssn from openffs.mf_vend where ssn_in = 'S' union select distinct e.socl_scty_num from openffs.mf_empl e where not exists (select 1 from openffs.ssn_xwlk v where trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null;
   cursor allnums is select distinct trim(v.ssn) SSN, NEWNUM, trim(docs.VEND_SSN) VEND_SSN, docs.uidy 
   										from openffs.ssn_xwlk v, openffs.mf_docs docs 
   										where trim(v.ssn) = trim(docs.VEND_SSN) 
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
        docs_VEND_SSN  := SUBSTR(pointer.VEND_SSN,1,9);
        docs_uidy  := pointer.UIDY;

				insert into openffs.DOCS_UPDATES values (oldnum,docs_VEND_SSN,docs_uidy,v_newnum);

   end loop;
end;
/
commit;


--disable trigger --
alter trigger OPENFFS.DOCS_SOLR_TRIGGER disable;

MERGE INTO openffs.MF_DOCS A
USING (SELECT DISTINCT UIDY, NEWNUM FROM openffs.DOCS_UPDATES) N
ON (A.UIDY = N.UIDY)
WHEN MATCHED THEN UPDATE
SET A.VEND_SSN = N.NEWNUM;
commit;
--PJB -- for any records that are not on Vendor table and are not 999 we'll just update to be 888888888
update openffs.MF_DOCS set VEND_SSN = '888888888' where VEND_SSN is not null and substr(VEND_SSN,1,3) not in ('123','234','999');
commit;

--enable trigger --
alter trigger OPENFFS.DOCS_SOLR_TRIGGER enable;



--drop index openffs.VEND_SSN_118            ;

drop table openffs.DOCS_UPDATES;
commit;
spool off;
exit;
