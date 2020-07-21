OPTIONS (SKIP=1)
Load DATA  
INFILE '/mnt/cgi_tech_team/scripts/DB/Dev/sqlldr/csv/VA_ACS_RSC_XWLK_DATA_TABLE.csv'
BADFILE '/mnt/cgi_tech_team/scripts/DB/Dev/sqlldr/logs/VA_ACS_RSC_XWLK_DATA_TABLE.bad'
DISCARDFILE '/mnt/cgi_tech_team/scripts/DB/Dev/sqlldr/logs/VA_ACS_RSC_XWLK_DATA_TABLE_discard.csv'
TRUNCATE 
INTO TABLE VA_ACS_RSC_XWLK
fields terminated by ',' optionally enclosed by '"'
(
FMS_RSC TERMINATED BY ',',
FMS_RSC_NAME TERMINATED BY ',',
IFAMS_REVENUE_SOURCE_CODE TERMINATED BY ',',
IFAMS_REVENUE_SOURCE_CODE_NAME
)

