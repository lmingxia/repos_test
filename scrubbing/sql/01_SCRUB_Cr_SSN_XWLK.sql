set timing on;
set define off;
set echo on;
set serveroutput on;

spool /mnt/cgi_tech_team/scripts/DB/Dev/scrubbing/logs/01_SCRUB_Cr_SSN_XWLK.log;

--PJB-- drop the crosswalk table if it still exists 
create or replace procedure openffs.DROP_TABLE (table_name IN varchar2) as
	BEGIN
	    execute immediate 'DROP TABLE OPENFFS.' || table_name;
	    dbms_output.put_line('Table ' || table_name || ' was dropped successfully.');
	EXCEPTION
	    when OTHERS then
	        if sqlcode = -942 then
	            dbms_output.put_line('Table ' || table_name || ' does not exist as expected. Not an error.');
	        else
	            raise;
	        end if;
END DROP_TABLE;
/

execute openffs.DROP_TABLE('SSN_XWLK');

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
create index openffs.VA_I1_VEND on openffs.MF_VEND(SSN);

--PJB -- This script will add a new column to MF_VEND that will then be used to update all other tables
alter table openffs.MF_VEND add NEWNUM varchar2(9);


--PJB -- The first PLSQL will pull the records w/ an SSN_IN of 'S' which are those that use an SSN
set timing on;
set define off;
set echo on;
set serveroutput on;
declare
   counter INTEGER := 0;
   seedval NUMBER(9,0) := 123400000;
   oldnum varCHAR2(9);
   v_newnum varCHAR2(9);
   
   cursor allnums is select distinct trim(v.ssn) SSN
   									from openffs.mf_vend v 
   									where v.ssn_in = 'S' 
   										union 
   									select distinct e.socl_scty_num
   							 		from openffs.mf_empl e 
   							 		where not exists (select 1 from openffs.mf_vend v where v.ssn_in = 'S' and trim(e.socl_scty_num) = trim(v.ssn)) and trim(e.socl_scty_num) is not null;

   pointer allnums%ROWTYPE;
begin
   for pointer in allnums
      loop
        counter := counter+1;
        oldnum  := SUBSTR(pointer.ssn,1,9);
        v_newnum  := LTRIM(TO_CHAR(seedval + counter, '999999999'));
				
				--There are multiple 999999999 records and NULL so we want to make sure that they are all the same
				if oldnum = '999999999' or oldnum is null then 
					update openffs.MF_VEND set newnum = '99999999' where ssn = oldnum;
        else 
        	update openffs.MF_VEND set newnum = v_newnum where ssn = oldnum;
        end if;
				commit;
   end loop;
end;
/

commit;
select SSN from openffs.mf_vend where SSN is not null and newnum is null;

update openffs.mf_vend set newnum = '99999999' where SSN is not null and newnum is null;
commit;

create table openffs.SSN_XWLK as select distinct SSN, NEWNUM from openffs.MF_VEND where SSN is not null;

select count(1) from openffs.SSN_XWLK;
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------


--PJB -- The second PLSQL will pull the records w/ an SSN_IN of 'T' which are those that use an TAX_IDNT_NUM
--Merge in records that use teh TAX_IDNT_NUM and not the SSN

create table openffs.copy_SSN_XWLK as select * from openffs.SSN_XWLK;
create table openffs.copy_mf_vend as select * from openffs.MF_VEND;

create index openffs.TAX_IDNT_NUM on openffs.mf_vend(trim(TAX_IDNT_NUM));

declare
   counter INTEGER := 0;
   seedval NUMBER(9,0) := 234500000;
   oldnum varCHAR2(9);
   v_newnum varCHAR2(9);
   v_date TIMESTAMP;

		--Now we want to add the 'T' records but some of them may already have an SSN that has been updated so we'll plan on using that value, if the ninus is not present 2 records will be on XWLK table
   cursor allnums is select distinct trim(v.tax_idnt_num) SSN 
   									from openffs.mf_vend v 
   									where v.ssn_in = 'T' 
   									and trim(tax_idnt_num) is not null 
   									minus 
   									select trim(SSN) from openffs.SSN_XWLK;

   pointer allnums%ROWTYPE;
begin
   counter := 0;
   for pointer in allnums
      loop
        counter := counter+1;
        oldnum  := SUBSTR(pointer.ssn,1,9);
        v_newnum  := LTRIM(TO_CHAR(seedval + counter, '999999999'));
        v_date := SYSTIMESTAMP;
				
				--There are multiple 999999999 records and NULL so we want to make sure that they are all the same
				if oldnum = '999999999' or oldnum is null or oldnum = '' then 
					update openffs.MF_VEND set newnum = '999999999' where ssn = oldnum;
					dbms_output.put_line('first');
				else 
        	update /*+ index(MF_VEND TAX_IDNT_NUM) */ openffs.MF_VEND set newnum = v_newnum where trim(tax_idnt_num) = oldnum;
					dbms_output.put_line('second');
        end if;
				commit;
				dbms_output.put_line('count ' || counter);
   			dbms_output.put_line('time  ' || v_date);
   end loop;
end;
/
commit;

drop table openffs.SSN_XWLK;


--PJB -- recreate the XWLK table by merging the values from both PLSQL togeter
create table openffs.SSN_XWLK as 
select distinct SSN                   , NEWNUM from openffs.MF_VEND where SSN is not null and newnum is not null
union
select distinct trim(TAX_IDNT_NUM) SSN, NEWNUM from openffs.MF_VEND where trim(TAX_IDNT_NUM) is not null and newnum is not null;

--PJB -- one record shows up 2x so we'll just manually delete that for now
delete from openffs.SSN_XWLK where SSN = '000000000' and NEWNUM like '2345%';
commit;
select count(1) from openffs.SSN_XWLK;


--update openffs.mf_vend set newnum = '999999999' where TAX_IDNT_NUM is not null and newnum is null;
--commit;

drop index openffs.TAX_IDNT_NUM;
drop index openffs.VA_I1_VEND;

------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------

create index openffs.SSN_XWLK on openffs.SSN_XWLK (SSN);

Begin
dbms_stats.gather_table_stats(
tabname => 'SSN_XWLK',
ownname => 'OPENFFS',
estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE,
cascade => TRUE,
degree => 20
);
end;
/


spool off;

exit;
