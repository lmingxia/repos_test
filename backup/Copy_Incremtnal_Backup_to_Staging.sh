echo $Source_DB
echo $RMAN_Tag

# scp /backup/rman/nightly_preprod_refresh/* oracle@10.245.205.81:/backup/rman/nightly_preprod_refresh

scp /backup/rman/nightly_preprod_refresh/Archive* /mnt/azureTempFiles
scp /backup/rman/nightly_preprod_refresh/Data* /mnt/azureTempFiles
