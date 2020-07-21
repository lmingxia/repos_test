
export SCRIPT_NAME=Gather_Stats

echo $ORACLE_HOME

export DB_SERVICE=$1
echo ${DB_SERVICE}

export DB_USER=cgiadm
export DB_PASS=cgiadm_123

export DATE_STRING=$(date +"%Y-%m-%d")


CUR_TIME=$(date)
echo "Start Time: ${CUR_TIME}"


export log_file_name=Gather_Stats.log
CMD="${ORACLE_HOME}/bin/sqlplus ${DB_USER}/'"$DB_PASS"'@${DB_SERVICE} @/mnt/cgi_tech_team/scripts/DB/Dev/sql/${SCRIPT_NAME}.sql ${DB_SERVICE}"

echo "Running: "
echo $CMD
eval "$CMD"
retVal=$?

echo "Entering ORA- Check..."
cd /mnt/cgi_tech_team/scripts/DB/Dev/scrubbing/logs
oracount=$(grep -c ORA- $log_file_name)
if [ ! ${oracount} -eq 0 ]; then
	echo "Error running:"
	echo $CMD
	echo "Check the ORA- Errors"
	echo "Subject: ${SCRIPT_NAME} Failed -- ${DB_SERVICE}" | /usr/sbin/sendmail patrick.burns2@va.gov
	retVal=55
	exit $retVal
fi

CUR_TIME=$(date)
echo "End Time: ${CUR_TIME}"

exit 0

