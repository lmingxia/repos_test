#!/bin/bash

echo $Source_DB
echo $Dest_DB

cd /backup/rman/nightly_preprod_refresh
ls -ltr

export ORACLE_SID=${Dest_DB}
rman target / << EOF
catalog start with '/backup/rman/nightly_preprod_refresh' NOPROMPT;
recover database;

exit
EOF

cd  /backup/rman/nightly_preprod_refresh
ls -ltr

exit;