set timing on;
set define off;
set echo on;
set serveroutput on;

spool /mnt/cgi_tech_team/scripts/DB/Dev/scrubbing/logs/05_SCRUB_Dr_SSN_XWLK.log;

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

alter table openffs.MF_VEND drop column NEWNUM;

spool off;

exit;
