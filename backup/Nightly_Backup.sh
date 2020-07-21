#!/bin/bash

# if [ "$1" -lt 1 || "$1" -gt 17 ]; then
#   echo "Parameter must be between 6 and 17."
#   exit 1
# fi

export DB_NODE_IP=$(hostname -I)
export DB_SERVICE=$1
# PJB -- Just running exports -- export DST_SERVICE_NAME=vademo

echo ${DB_SERVICE}

export SRC_USER=datapumpdb
export SRC_PW=datapumpDB_123


# PJB -- Just running exports, this is only needed if we run the import portion -- export DST_USR=openffs9
# PJB -- Just running exports, this is only needed if we run the import portion -- export DST_PW='openffs3_123'

# PJB -- Just running exports, this is only needed if we run the import portion -- export REMAP_SCHEMA=${SRC_USR}:${DST_USR}

export ORACLE_HOME=/u01/app/oracle/product/18.0.0/db_1
echo $ORACLE_HOME

# Use this if running at 1a and want to name the day of the export -- EXPORTED_DATA_DAY=$(date '+%a' --date="1 days ago")
EXPORTED_DATA_DAY=$(date '+%a')
echo "Exported Data from : ${EXPORTED_DATA_DAY}"

export DATE_STRING=$(date +"%Y-%m-%d")
CUR_TIME=$(date)
echo "Start Time: ${CUR_TIME}"

cd /tmp
CMD="${ORACLE_HOME}/bin/expdp $SRC_USER/$SRC_PW@//${DB_NODE_IP//[[:blank:]]/}:1521/${DB_SERVICE} directory=VA_DMP_DIR dumpfile=${DB_SERVICE}_${EXPORTED_DATA_DAY}_Nightly_Backup_%u.dmp logfile=${DB_SERVICE}_${EXPORTED_DATA_DAY}_Nightly_Backup.log FULL=Y parallel=2 exclude=statistics reuse_dumpfiles=Y compression=DATA_ONLY exclude=COMMENT FILESIZE=10GB"

echo "Running: "
echo $CMD
eval "$CMD"

retVal=$?

if [ ! $retVal -eq 0 ]; then
  echo "Error running:"
  echo $CMD
  echo "Subject: ${DB_SERVICE} - Backup Failed" | /usr/sbin/sendmail "patrick.burns2@va.gov;mingxia.luo@va.gov"
  exit $retVal
fi


CUR_TIME=$(date)
echo "End Time: ${CUR_TIME}"


