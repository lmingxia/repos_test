#!/bin/bash

echo $Source_DB
echo $RMAN_Tag

export ORACLE_SID=$Source_DB

rman target / << EOF

RUN
{
  ALLOCATE CHANNEL ch11 TYPE DISK MAXPIECESIZE 10G;
  BACKUP INCREMENTAL LEVEL 1 FORMAT '/backup/rman/nightly_preprod_refresh/Data_%T_%u_s%s_p%p' DATABASE tag 'FORPRERPOD'
  PLUS ARCHIVELOG FORMAT '/backup/rman/nightly_preprod_refresh/Archive_%T_%u_s%s_p%p'  tag 'FORPRERPOD';
  RELEASE CHANNEL ch11;
}

exit
EOF

cd /backup/rman/nightly_preprod_refresh/
ls -ltr

exit;