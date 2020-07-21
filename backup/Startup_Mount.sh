export SCRIPT_NAME=Startup_Mount

echo $Source_DB
echo $Dest_DB

export DB_USER=sys
export DB_PASS=OraSys_123

export log_file_name=${SCRIPT_NAME}.log

export ORACLE_SID=${Dest_DB}
#-- CMD="${ORACLE_HOME}/bin/sqlplus ${DB_USER}/'"$DB_PASS"'@${Dest_DB} as sysdba @/mnt/cgi_tech_team/scripts/DB/Dev/backup/sql/${SCRIPT_NAME}.sql"
CMD="${ORACLE_HOME}/bin/sqlplus ${DB_USER}/'"$DB_PASS"' as sysdba @/mnt/cgi_tech_team/scripts/DB/Dev/backup/sql/${SCRIPT_NAME}.sql"
echo "Running: "
echo $CMD
eval "$CMD"
retVal=$?


echo "Entering ORA- Check..."
cd /mnt/cgi_tech_team/scripts/DB/Dev/backup/logs
oracount=$(grep -c ORA- $log_file_name)
if [ ! ${oracount} -eq 0 ]; then
	echo "Error running:"
	echo $CMD
	echo "Check the ORA- Errors"
	echo "Subject: ${SCRIPT_NAME} Failed -- ${DB_SERVICE}" | /usr/sbin/sendmail patrick.burns2@va.gov
	retVal=55
	exit $retVal
fi

exit;
