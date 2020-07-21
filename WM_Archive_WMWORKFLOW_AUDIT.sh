cd /home/oracle
. ./setDB-Passwords.sh > /dev/null 2>&1
#Possible Login Accounts
#---All Envs
#IDP_DB_USER=pegidp
#MOM_DB_USER=openffs
#PB_DB_USER=pb
#WKFL_DB_USER=wmworkflow_audit
#WKFL_ARCHIVE_DB_USER=wmworkflow_archive
#INTG_DB_USER=wmintegration
#CCR_DB_USER=pb
#BI_DB_USER=bi
#BIRPTUSER_DB_USER=bi
#---Dev Only
#VACONV_DB_USER=vaconv
#GOECONV_DB_USER=goeconv
#GOECONV_DB_USER=wv2conv
#CGIADM_DB_USER=cgiadm

export SCRIPT_NAME=WM_Archive_WMWORKFLOW_AUDIT


export DB_NODE1_IP=$(hostname -I)
#export ORACLE_HOME=/u01/app/oracle/product/18.0.0/db_1

export DB_SERVICE=$1
echo ${DB_SERVICE}

export DATE_STRING=$(date +"%Y-%m-%d")
CUR_TIME=$(date)
echo "Start Time: ${CUR_TIME}"

cd /mnt/cgi_tech_team/scripts/DB/sql

export log_file_name=${SCRIPT_NAME}_${DB_SERVICE}.log
echo $log_file_name



CMD="${ORACLE_HOME}/bin/sqlplus ${WKFL_ARCHIVE_DB_USER}/'"${WKFL_ARCHIVE_DB_PSWD}"'@${DB_SERVICE} @${SCRIPT_NAME}.sql ${DB_SERVICE}"
echo "Running: "
echo $CMD
eval "$CMD"
retVal=$?

cd /mnt/cgi_tech_team/scripts/DB/logs
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



