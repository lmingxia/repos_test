#!/bin/bash
##############################################################################
#                         RMAN BACKUPS
# Description: This script create a RMAN backup based on parameter passed
# Created by Mingxia Luo on Nov 1, 2018
##############################################################################

export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/18.0.0/db_1
export ORACLE_SID=vaprod

 
usage () {
echo "Usage : SID BACKUP_TYPE COMPRESSION PARALLELISM
        SID : SID, comma separated list of databases or ALL for all databases (running)
        BACKUP_TYPE : INCR, FULL, COLD or ARCH
        COMPRESS : COMPRESS or NOCOMPRESS to compress or not the backup
        PARALLEL : defines the number of channel to use
 
        exemple backup full : rman_backup.sh vaprod FULL COMPRESS 4
        exemple backup arch : rman_backup.sh vaprod ARCH NOCOMPRESS 2
"
}
 
BACKUP_BASE=/backup/
DEST_EMAIL=mingxia.luo@va.gov
 
# Create directorires of not exist

mkdir -p $BACKUP_BASE/
mkdir -p $BACKUP_BASE/log
mkdir -p $BACKUP_BASE/autobackup
 
# Validating du number of parameters passed
if [ $# -lt 4 ]; then
    usage
    exit 1
fi
 
# Parameters provided
DB_LIST=$1
BACKUP_TYPE=$2
PARALLEL=$4
 
# Backup type validation
case $BACKUP_TYPE in
    FULL)
        LEVEL="incremental level 0"
    ;;
    INCR)
        LEVEL="incremental level 1"
    ;;
    ARCH)
        LEVEL=""
    ;;
    COLD)
        LEVEL=""
    ;;
    *)
        usage
    exit 1
    ;;
esac
 
# Compression validation
if [ $3 = 'COMPRESS' ]; then
    COMPRESS='AS COMPRESSED BACKUPSET'
else
    if [ $3 = 'NOCOMPRESS' ]; then
        COMPRESS=''
    else
        usage
        exit 1
    fi
fi
 
##Variables definition
export NLS_DATE_FORMAT='dd/mm/yyyy hh24:mi:ss'
DATE=`date +"%Y%m%d%H%M%S"`
BASEDIR=$(dirname "$0")
LOGDIR=$BASEDIR/log
PATH=$PATH:/usr/local/bin



##backup function
function backup_database() {
    # Set Oracle Environment for database
    ORACLE_SID=$1
    ORAENV_ASK=NO

    . oraenv
 
    OUTPUT_SID=${ORACLE_SID}
    BACKUP_DIR=$BACKUP_BASE/${ORACLE_SID}
    LOGFILE=$LOGDIR/rman_backup_${ORACLE_SID}_${BACKUP_TYPE}_${DATE}.log
    # Create directorires of not exist
    mkdir -p $BACKUP_DIR
    mkdir -p $BACKUP_DIR/log
    mkdir -p $BACKUP_DIR/autobackup
 
    # Controlfile backup directory
    CF_BACKUP="'$BACKUP_DIR/autobackup/cf_sp_%F'"
    FORMAT_DATA="format '${BACKUP_DIR}/data_%d_${BACKUP_TYPE}_bks%s_%T_%U.bck'"
    FORMAT_ARCHIVE="format '${BACKUP_DIR}/arch_%d_${BACKUP_TYPE}_bks%s_%T_%U.bck'"
 
    if [ $BACKUP_TYPE = 'COLD' ]; then
        $ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF
            shutdown immediate;
            startup mount;
            exit
EOF
        $ORACLE_HOME/bin/rman target /  << EOF >> $LOGFILE 2>&1
            CONFIGURE CONTROLFILE AUTOBACKUP ON;
	    CONFIGURE RETENTION POLICY TO REDUNDANCY 14;	
            CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO ${CF_BACKUP};
            CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO BACKUPSET PARALLELISM ${PARALLEL};
            run {
                backup ${COMPRESS} database section size 50G $FORMAT_DATA;
		delete noprompt obsolete;
                }
            exit
EOF
 
        $ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF
            alter database open;
            exit
EOF
 
    else
        if [  $BACKUP_TYPE = 'ARCH' ]; then
            $ORACLE_HOME/bin/rman target /  << EOF >> $LOGFILE
                CONFIGURE CONTROLFILE AUTOBACKUP ON;
		CONFIGURE RETENTION POLICY TO REDUNDANCY 14;
                CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO ${CF_BACKUP};
                CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO BACKUPSET PARALLELISM ${PARALLEL};
                run {
                    backup ${COMPRESS} archivelog all $FORMAT_ARCHIVE delete input filesperset 10;
                    delete noprompt obsolete;
                    }
                exit
EOF
        else
            $ORACLE_HOME/bin/rman target /  << EOF >> $LOGFILE 2>&1
                CONFIGURE CONTROLFILE AUTOBACKUP ON;
		CONFIGURE RETENTION POLICY TO REDUNDANCY 14;
                CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO ${CF_BACKUP};
                CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO BACKUPSET PARALLELISM ${PARALLEL};
                run {
                    backup ${COMPRESS} archivelog all $FORMAT_ARCHIVE delete input filesperset 10;
                    backup ${COMPRESS} ${LEVEL} database section size 50G $FORMAT_DATA include current controlfile;
                    backup ${COMPRESS} archivelog all $FORMAT_ARCHIVE delete input filesperset 10;
                    delete noprompt obsolete;
                    }
                exit
EOF
        fi
    fi
 
    # Validate Errors in the log.
    ERRORLIST=$(egrep "^RMAN-[0-9]*:|^ORA-[0-9]*:" $LOGFILE)
    ERRORLIST=$(echo $ERRORLIST)
    if [ -n "$ERRORLIST" ]
    then
        SUBJECT="$(date +%y)/$(date +%m)/$(date +%d) $(date +%H).$(date +%M).$(date +%S) - `hostname` - Backup Report ${OUTPUT_SID} - ERROR"
    else
        SUBJECT="$(date +%y)/$(date +%m)/$(date +%d) $(date +%H).$(date +%M).$(date +%S) - `hostname` - Backup Report ${OUTPUT_SID}"
    fi
    cat -v $LOGFILE | mail -s "$SUBJECT" "$DEST_EMAIL"
}
 
if [ $1 = 'ALL' ]; then
    for database in `ps -ef | grep pmon | egrep -v 'ASM|grep' | awk '{print $8}' | cut -d_ -f3`
    do
        backup_database $database
    done
else
    for database in $(echo $1 | sed "s/,/ /g")
    do
        backup_database $database
    done
fi


