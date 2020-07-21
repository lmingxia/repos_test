export SCRIPT_NAME=02_SCRUB_TJ

export DB_NODE1_IP=$(hostname -I)
#export ORACLE_HOME=/u01/app/oracle/product/18.0.0/db_1

export DB_SERVICE=$1
echo $DB_SERVICE

export DB_USER=openffs
export DB_PASS=openffs_123

export DATE_STRING=$(date +"%Y-%m-%d")


CUR_TIME=$(date)
echo "Start Time: ${CUR_TIME}"

cd /mnt/cgi_tech_team/scripts/DB/Dev/scrubbing/sql

export log_file_name=${SCRIPT_NAME}.log
echo $log_file_name

CMD="${ORACLE_HOME}/bin/sqlplus ${DB_USER}/'"$DB_PASS"'@${DB_SERVICE} @${SCRIPT_NAME}.sql $DB_SERVICE $DB_USER"
echo "Running: "
echo $CMD
eval "$CMD"
retVal=$?

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



