set linesize 3000 pagesize 3000 trimspool on timing on  feedback on;
spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_Create_&1..log;

--If we ty to use db_create_file_dest it'll go into OMF mode which creates files in a format we don't want
alter system reset db_create_file_dest scope=both;


CREATE PLUGGABLE DATABASE &1 FROM &2 PARALLEL file_name_convert=('/d00/oradata/&2/','/d00/oradata/&1/');


ALTER PLUGGABLE DATABASE &1 OPEN;
ALTER PLUGGABLE DATABASE ALL SAVE STATE;

select name from v$datafile;


spool off;

exit;

