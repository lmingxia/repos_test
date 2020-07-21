set linesize 3000 pagesize 3000 trimspool on heading off feedback off echo off verify off serveroutput on;

spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_Drop_DB_Users_&1..log;

declare
	cursor c_user_cursor is select username from dba_users where username not in ('DBSNMP','OUTLN','SYS','SYSTEM','OPENFFS','CCR','JRREP','PB','PEGIDP','VSIDP','VSS','WMINTEGRATION','WMWORKFLOW_ARCHIVE',
'WMWORKFLOW_AUDIT','WMWORKFLOW_MWS','WMWORKFLOW_PROCESS_AUDIT','WMWORKFLOW_PROCESS_AUDIT','WMWORKFLOW_PROCESS_ENG',
'ANONYMOUS','APPQOSSYS','AUDSYS','C##MLUO','CTXSYS','DBSFWUSER','DIP','DVF','DVSYS','GGSYS','GSMADMIN_INTERNAL','GSMCATUSER','GSMUSER',
'LBACSYS','MDDATA','MDSYS','OJVMSYS','OLAPSYS','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','PDBADMIN','REMOTE_SCHEDULER_AGENT','SI_INFORMTN_SCHEMA',
'SPATIAL_CSW_ADMIN_USR','SYS$UMF','SYSBACKUP','SYSDG','SYSKM','SYSRAC','WMSYS','WMWORKFLOW','XDB','XS$NULL','CGIADM','DATAPUMPDB','OPENFFS_RO','IFAMSESB');

c_user_name 	c_user_cursor%ROWTYPE;
v_user_name 	varchar2(64);

begin
	open c_user_cursor;
	loop
		fetch c_user_cursor into c_user_name;
		exit when c_user_cursor%NOTFOUND;
		
		v_user_name := c_user_name.username;
		
		dbms_output.put_line('Dropping user  ' || v_user_name);
		execute immediate 'DROP USER ' || v_user_name || ' cascade';
		
	end loop;
	dbms_output.put_line(c_user_cursor%rowcount || ' synonyms created.');
	close c_user_cursor;
end;
/



spool off;

exit;

