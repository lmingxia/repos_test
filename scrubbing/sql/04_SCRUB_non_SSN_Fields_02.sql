set timing on;
set define off;
set echo on;

spool /mnt/cgi_tech_team/scripts/DB/Dev/scrubbing/logs/04_SCRUB_non_SSN_Fields_02.log;
alter session force parallel ddl parallel 20;
alter session force parallel dml parallel 20;
--CRCD_NUM
update openffs.MF_CR_LN_AMD      set crcd_num = null where crcd_num is not null;
update openffs.MF_CR_LN          set crcd_num = null where crcd_num is not null;

commit;
spool off;
exit;
