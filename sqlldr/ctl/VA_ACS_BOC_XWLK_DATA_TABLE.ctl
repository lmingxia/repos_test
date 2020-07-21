OPTIONS (SKIP=1)
Load DATA  
INFILE '/mnt/cgi_tech_team/scripts/DB/Dev/sqlldr/csv/VA_ACS_BOC_XWLK_DATA_TABLE.csv'
BADFILE '/mnt/cgi_tech_team/scripts/DB/Dev/sqlldr/logs/VA_ACS_BOC_XWLK_DATA_TABLE.bad'
DISCARDFILE '/mnt/cgi_tech_team/scripts/DB/Dev/sqlldr/logs/VA_ACS_BOC_XWLK_DATA_TABLE_discard.csv'
TRUNCATE 
INTO TABLE VA_ACS_BOC_XWLK
fields terminated by ',' optionally enclosed by '"'
(
FMS_BOC TERMINATED BY ',',
FMS_SUB_BOC TERMINATED BY ',',
FMS_BOC_NAME TERMINATED BY ',',
IFAMS_BOC TERMINATED BY ',',
IFAMS_BOC_NAME
)

