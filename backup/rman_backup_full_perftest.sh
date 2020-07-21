#!/bin/bash
# Description: This script create a RMAN backup based on parameter passed
source  /home/oracle/.bash_profile 
export ORACLE_SID=perftest
/mnt/cgi_tech_team/scripts/DB/Dev/backup/rman_backup.sh perftest FULL COMPRESS 4 &

