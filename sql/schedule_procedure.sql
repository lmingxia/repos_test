Set define on;
set echo on;

spool /mnt/cgi_tech_team/scripts/DB/Dev/logs/schedule_procedure_${DB_SERVICE}.log
Set define off;
execute sp_reload_table_850_851('BI_RECON_OPEN_DOC_GNRL');
 
spool off;
exit;
