#! /bin/sh 
# description: Oracle auto start-stop script.
#
# Set ORACLE_HOME to be equivalent to the $ORACLE_HOME
# from which you wish to execute dbstart and dbshut;
#
# Set ORA_OWNER to the user id of the owner of the
# Oracle database in ORACLE_HOME.

ORA_HOME=/u01/app/oracle/product/18.0.0/db_1
ORA_OWNER=oracle
CUR_TIME=$(date)
echo "Time: ${CUR_TIME}"
$ORA_HOME/bin/dbshut $ORA_HOME &
#$ORA_HOME/bin/lsnrctl stop

