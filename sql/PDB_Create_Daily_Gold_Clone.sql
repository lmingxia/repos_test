set linesize 3000 pagesize 3000 trimspool on echo on feedback on ;
spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_Create_Daily_Gold_Clone_&1..log;



--If we ty to use db_create_file_dest it'll go into OMF mode which creates files in a format we don't want
alter system reset db_create_file_dest scope=both;
CREATE PLUGGABLE DATABASE &1 FROM &2 file_name_convert=('/d00/oradata/&2/','/d00/oradata/&1/');

--Currently we can not create an instance from a SNAPSHOT that does not use OMF (db_create_file_dest), maybe in a future release.  SR 3-21874666761 : Creating PDBs from snapshots 
	--alter system set db_create_file_dest='/d00/oradata/&1/' scope=both;
	--CREATE PLUGGABLE DATABASE &1 FROM &2 using snapshot Sandbox6_&3;


ALTER PLUGGABLE DATABASE &1 OPEN;
ALTER PLUGGABLE DATABASE ALL SAVE STATE;


select name from v$datafile;

alter system reset db_create_file_dest scope=both;
show parameter db_create_file_dest;

spool off;

exit;

