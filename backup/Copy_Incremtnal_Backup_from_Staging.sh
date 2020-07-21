echo $Source_DB
echo $RMAN_Tag

# scp /backup/rman/nightly_preprod_refresh/* oracle@10.245.205.81:/backup/rman/nightly_preprod_refresh

scp /mnt/azureTempFiles/Archive* /backup/rman/nightly_preprod_refresh
scp /mnt/azureTempFiles/Data* /backup/rman/nightly_preprod_refresh

cd /mnt/azureTempFiles
rm Archive*
rm Data*