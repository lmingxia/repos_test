#!/bin/bash

# PJB -- DEV ONLY if [ "$1" -lt 1 || "$1" -gt 17 ]; then
# PJB -- DEV ONLY --   echo "Parameter must be between 6 and 17."
# PJB -- DEV ONLY --   exit 1
# PJB -- DEV ONLY -- fi

export DB_NODE_IP=$(hostname -I)

# PJB -- DEV ONLY -- SRC_SERVICE_NAME=sandbox$1
DB_SERVICE=vaprod
# PJB -- Just running exports -- export DST_SERVICE_NAME=vademo

echo ${SRC_SERVICE_NAME}

export SRC_USER=PB
export SRC_PW=geP1_88Bh


# PJB -- Just running exports, this is only needed if we run the import portion -- export DST_USR=openffs9
# PJB -- Just running exports, this is only needed if we run the import portion -- export DST_PW='openffs3_123'

# PJB -- Just running exports, this is only needed if we run the import portion -- export REMAP_SCHEMA=${SRC_USR}:${DST_USR}

export ORACLE_HOME=/u01/app/oracle/product/12.2/db_1
echo $ORACLE_HOME

# Use this if running at 1a and want to name the day of the export -- EXPORTED_DATA_DAY=$(date '+%a' --date="1 days ago")
EXPORTED_DATA_DAY=$(date '+%a')
echo "Exported Data from : ${EXPORTED_DATA_DAY}"

export DATE_STRING=$(date +"%Y-%m-%d")
CUR_TIME=$(date)
echo "Start Time: ${CUR_TIME}"

cd /tmp
# PJB -- has all schemas -- CMD="${ORACLE_HOME}/bin/expdp $SRC_USER/$SRC_PW@//${DB_NODE_IP//[[:blank:]]/}:1521/${SRC_SERVICE_NAME} directory=VA_DMP_DIR dumpfile=${SRC_SERVICE_NAME}_${EXPORTED_DATA_DAY}_Nightly_Backup_%u.dmp logfile=${SRC_SERVICE_NAME}_${EXPORTED_DATA_DAY}_Nightly_Backup.log schemas=openffs,vss,pb,pegidp,vsidp,ccr,wmworkflow,jrrep,wmvss,wmccrc,openffs_ro parallel=2 exclude=statistics reuse_dumpfiles=Y compression=DATA_ONLY exclude=COMMENT"

CMD="${ORACLE_HOME}/bin/expdp $SRC_USER/$SRC_PW@//${DB_NODE_IP//[[:blank:]]/}:1521/${DB_SERVICE} directory=PROD_PREPROD_DIR dumpfile=Prod_to_PreProd_Nightly_Backup_%u.dmp logfile=${DB_SERVICE}_${EXPORTED_DATA_DAY}_Nightly_Backup.log schemas=pb,pegidp parallel=2 exclude=statistics reuse_dumpfiles=Y compression=DATA_ONLY exclude=COMMENT"


echo "Running: "
echo $CMD
eval "$CMD"

retVal=$?
if [ ! $retVal -eq 0 ]; then
  echo "Error running:"
  echo $CMD
  echo "Subject: ${DB_SERVICE} - Backup Failed" | /usr/sbin/sendmail patrick.burns2@va.gov
  exit $retVal
fi


CUR_TIME=$(date)
echo "End Time: ${CUR_TIME}"


