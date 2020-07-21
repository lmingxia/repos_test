SET LONG 20000 LONGCHUNKSIZE 20000 PAGESIZE 0 LINESIZE 3000 FEEDBACK OFF VERIFY OFF TRIMSPOOL ON serveroutput on heading off feedback off echo off verify off;

spool /mnt/cgi_tech_team/scripts/DB/Dev/sql/PDB_Drop_DB_Users_Roles_&1..sql;

select 'set linesize 3000 pagesize 3000 trimspool on echo on heading on feedback on;' from dual;
select 'spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_Drop_DB_Users_Roles_&1..log;' from dual;


DECLARE
	Cursor c0 is select username from dba_users where username not in ('DBSNMP','OUTLN','SYS','SYSTEM','OPENFFS','CCR','JRREP','PB','PEGIDP','VSIDP','VSS','WMINTEGRATION','WMWORKFLOW_ARCHIVE',
'WMWORKFLOW_AUDIT','WMWORKFLOW_MWS','WMWORKFLOW_PROCESS_AUDIT','WMWORKFLOW_PROCESS_AUDIT','WMWORKFLOW_PROCESS_ENG',
'ANONYMOUS','APPQOSSYS','AUDSYS','C##MLUO','CTXSYS','DBSFWUSER','DIP','DVF','DVSYS','GGSYS','GSMADMIN_INTERNAL','GSMCATUSER','GSMUSER',
'LBACSYS','MDDATA','MDSYS','OJVMSYS','OLAPSYS','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','PDBADMIN','REMOTE_SCHEDULER_AGENT','SI_INFORMTN_SCHEMA',
'SPATIAL_CSW_ADMIN_USR','SYS$UMF','SYSBACKUP','SYSDG','SYSKM','SYSRAC','WMSYS','WMWORKFLOW','XDB','XS$NULL','CGIADM','DATAPUMPDB','OPENFFS_RO','IFAMSESB','JBOSS','IESB')
and PROFILE <> 'DEFAULT';
	
	USERNAME c0%ROWTYPE;
	v_user_name 		varchar2(64);
	sql_stmt_user    	VARCHAR2(9999);
	sql_system_grant    VARCHAR2(9999);
	sql_role_grant    	VARCHAR2(9999);
	sql_object_grant    VARCHAR2(9999);

Begin
	Open c0;
	LOOP
	    	Fetch c0 into USERNAME;
	    	EXIT WHEN c0%NOTFOUND;
				
				v_user_name := USERNAME.username;
				
				--dbms_output.put_line('user - ' || v_user_name);
				--execute immediate 'Drop user '||v_user_name||' cascade;' into sql_stmt_user ;
				--dbms_output.put_line(sql_stmt_user);
				dbms_output.put_line('Drop user '||v_user_name||' cascade;');
				
	END LOOP;
	Close c0;
End;
/

select 'commit;' from dual;
select 'spool off;' from dual;
select 'exit;' from dual;

spool off;







spool /mnt/cgi_tech_team/scripts/DB/Dev/sql/PDB_Recreate_DB_Users_Roles_n_Permissions_&1..sql;

--Set all users to inactive
select 'set linesize 3000 pagesize 3000 trimspool on echo on heading on feedback on;' from dual;
select 'spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/PDB_Recreate_DB_Users_Roles_n_Permissions_&1..log;' from dual;


BEGIN
   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'SQLTERMINATOR', true);
   DBMS_METADATA.set_transform_param (DBMS_METADATA.session_transform, 'PRETTY', true);
END;
/

DECLARE
	Cursor c0 is select username from dba_users where username not in ('DBSNMP','OUTLN','SYS','SYSTEM','OPENFFS','CCR','JRREP','PB','PEGIDP','VSIDP','VSS','WMINTEGRATION','WMWORKFLOW_ARCHIVE',
'WMWORKFLOW_AUDIT','WMWORKFLOW_MWS','WMWORKFLOW_PROCESS_AUDIT','WMWORKFLOW_PROCESS_AUDIT','WMWORKFLOW_PROCESS_ENG',
'ANONYMOUS','APPQOSSYS','AUDSYS','C##MLUO','CTXSYS','DBSFWUSER','DIP','DVF','DVSYS','GGSYS','GSMADMIN_INTERNAL','GSMCATUSER','GSMUSER',
'LBACSYS','MDDATA','MDSYS','OJVMSYS','OLAPSYS','ORACLE_OCM','ORDDATA','ORDPLUGINS','ORDSYS','PDBADMIN','REMOTE_SCHEDULER_AGENT','SI_INFORMTN_SCHEMA',
'SPATIAL_CSW_ADMIN_USR','SYS$UMF','SYSBACKUP','SYSDG','SYSKM','SYSRAC','WMSYS','WMWORKFLOW','XDB','XS$NULL','CGIADM','DATAPUMPDB','OPENFFS_RO','IFAMSESB','JBOSS','IESB')
and PROFILE <> 'DEFAULT';
	
	USERNAME c0%ROWTYPE;
	v_user_name 		varchar2(64);
	sql_stmt_user    	VARCHAR2(9999);
	sql_system_grant    VARCHAR2(9999);
	sql_role_grant    	VARCHAR2(9999);
	sql_object_grant    VARCHAR2(9999);

Begin
	Open c0;
	LOOP
	    	Fetch c0 into USERNAME;
	    	EXIT WHEN c0%NOTFOUND;
				
				v_user_name := USERNAME.username;
				
				--dbms_output.put_line('user - ' || v_user_name);
				execute immediate 'SELECT dbms_metadata.get_ddl(''USER'','''||v_user_name||''') FROM dual' into sql_stmt_user ;
				--NOT NEEDED FOR THE CUSTOM USERS WE CREATE, WILL FAIL IF WE TRY TO USE -- execute immediate 'SELECT DBMS_METADATA.GET_GRANTED_DDL(''SYSTEM_GRANT'','''||v_user_name||''') from dual' into sql_system_grant;
				execute immediate 'SELECT DBMS_METADATA.GET_GRANTED_DDL(''ROLE_GRANT'','''||v_user_name||''') from dual' into sql_role_grant;
				--NOT NEEDED FOR THE CUSTOM USERS WE CREATE, WILL FAIL IF WE TRY TO USE -- execute immediate 'SELECT DBMS_METADATA.GET_GRANTED_DDL(''OBJECT_GRANT'','''||v_user_name||''') from dual' into sql_object_grant;

				dbms_output.put_line(sql_stmt_user);
				--NOT NEEDED FOR THE CUSTOM USERS WE CREATE, WILL FAIL IF WE TRY TO USE -- dbms_output.put_line(sql_system_grant);
				dbms_output.put_line(sql_role_grant);
				--NOT NEEDED FOR THE CUSTOM USERS WE CREATE, WILL FAIL IF WE TRY TO USE -- dbms_output.put_line(sql_object_grant);
				
	END LOOP;
	Close c0;
End;
/

select 'commit;' from dual;
select 'spool off;' from dual;
select 'exit;' from dual;

spool off;

exit;

