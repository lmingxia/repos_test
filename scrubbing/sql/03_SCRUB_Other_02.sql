set timing on;
set define off;
set echo on;

spool /mnt/cgi_tech_team/scripts/DB/Dev/scrubbing/logs/03_SCRUB_Other_02.log;
-- TEMPORARY COUNTS FOR ANALYSIS - AJR 7/15
select distinct count(ssn) from openffs.mf_vend where ssn_in = 'S' 
	union 
select distinct count(e.socl_scty_num) from openffs.mf_empl e where not exists (select 1 from openffs.mf_vend v where v.ssn_in = 'S' and trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null;


alter session force parallel ddl parallel 20;

create index openffs.DGGT_SSN_399 on openffs.MF_TI_FRM                          	(	VEND_SSN                      	);
create index openffs.SSN_427 on openffs.MF_VEND_DOC                        	(	SSN                           	);
create index openffs.SSN_429 on openffs.MF_VEND_DOC_LN                     	(	SSN                           	);
create index openffs.SSN_433 on openffs.MF_VEND_FRM                        	(	SSN                           	);
create index openffs.SSN_435 on openffs.MF_VEND_FRM_LN                     	(	SSN                           	);
create index openffs.SSN_VENDCD	  on openffs.MF_VEND_RORG                         (	substr(FROM_VEND_CD,1,9)        );
create index openffs.VEND_SSN_403 on openffs.MF_TN                              	(	VEND_SSN                      	);
create index openffs.VEND_SSN_404 on openffs.MF_TN99E_ACTY_LOG                              	(	VEND_SSN                      	);
create index openffs.VEND_SSN_405 on openffs.MF_TN_FRM                          	(	VEND_SSN                      	);
create index openffs.VEND_SSN_407 on openffs.MF_TP                              	(	VEND_SSN                      	);
create index openffs.VEND_SSN_409 on openffs.MF_TP_FRM                          	(	VEND_SSN                      	);
create index openffs.VEND_SSN_411 on openffs.MF_TP_FRM_LN                       	(	VEND_SSN                      	);
create index openffs.VEND_SSN_413 on openffs.MF_TP_LN                           	(	VEND_SSN                      	);
create index openffs.VEND_SSN_415 on openffs.MF_TR                              	(	VEND_SSN                      	);
create index openffs.VEND_SSN_417 on openffs.MF_TR_AMD                          	(	VEND_SSN                      	);
create index openffs.VEND_SSN_419 on openffs.MF_TR_FRM                          	(	VEND_SSN                      	);
create index openffs.VEND_SSN_421 on openffs.MF_TV                              	(	VEND_SSN                      	);
create index openffs.VEND_SSN_423 on openffs.MF_TV_FRM                          	(	VEND_SSN                      	);
create index openffs.MF_VEND_SSN on openffs.MF_VEND                          	(	SSN                      	);
create index openffs.VEND_SSN_431 on openffs.MF_VEND_EVAL                       	(	VEND_SSN                      	);
create index openffs.VEND_SSN_437 on openffs.MF_VEND_OFFR                       	(	VEND_SSN                      	);
create index openffs.VEND_SSN_439 on openffs.MF_VEND_WKSP                       	(	VEND_SSN                      	);
create index openffs.VEND_SSN_443 on openffs.MF_VI_LOG_SUMR                              	(	SSN                      	);
create index openffs.VEND_SSN_447 on openffs.MF_WKLD_ASGT                          	(	VEND_SSN                      	);

create index openffs.DGGT_SSN_176 on openffs.MF_IO                              	(	DGGT_SSN                      	);
create index openffs.ALTP_SSN_178 on openffs.MF_IO                              	(	ALTP_SSN                      	);
create index openffs.VEND_SSN_180 on openffs.MF_IO                              	(	VEND_SSN                      	);
create index openffs.VEND_SSN_182 on openffs.MF_IO_AMD                          	(	VEND_SSN                      	);
create index openffs.ALTP_SSN_184 on openffs.MF_IO_AMD                          	(	ALTP_SSN                      	);
create index openffs.DGGT_SSN_186 on openffs.MF_IO_AMD                          	(	DGGT_SSN                      	);

create index openffs.DFLT_VEND_SSN_78 on openffs.MF_CRCD_TYPE                       	(	DFLT_VEND_SSN                 	);
create index openffs.DGGT_SSN_82 on openffs.MF_CR_FRM_LN                       	(	DGGT_SSN                      	);
create index openffs.DGGT_SSN_84 on openffs.MF_CR_LN                           	(	DGGT_SSN                      	);
create index openffs.DGGT_SSN_88 on openffs.MF_CR_LN_AMD                       	(	DGGT_SSN                      	);
create index openffs.NON_VEND_SSN_76 on openffs.MF_CRCD_TYPE                       	(	NON_VEND_SSN                  	);
create index openffs.PAYE_SSN_68 on openffs.MF_CHEK_SUMR                       	(	PAYE_SSN                      	);
create index openffs.PAYE_VEND_SSN_102 on openffs.MF_DA_PAYE                         	(	PAYE_VEND_SSN                 	);
create index openffs.PAYE_VEND_SSN_104 on openffs.MF_DA_PAYE_AMD                     	(	PAYE_VEND_SSN                 	);
create index openffs.PAYE_VEND_SSN_106 on openffs.MF_DA_PAYE_FRM                     	(	PAYE_VEND_SSN                 	);
create index openffs.PAYE_VEND_SSN_114 on openffs.MF_DEBT_ACCT_PAYE                  	(	PAYE_VEND_SSN                 	);
create index openffs.SSN_91 on openffs.MF_CR_PY_FRM_LN                    	      (	SSN                           	);
create index openffs.SSN_92 on openffs.MF_CR_PY_LN                        	      (	SSN                           	);
create index openffs.SSN_97 on openffs.MF_CSTD                            	      (	SSN                           	);
create index openffs.VEND_SSN_100 on openffs.MF_CTRC_FILE                       	(	VEND_SSN                      	);
create index openffs.VEND_SSN_108 on openffs.MF_DA_VEND                         	(	VEND_SSN                      	);
create index openffs.VEND_SSN_110 on openffs.MF_DA_VEND_AMD                     	(	VEND_SSN                      	);
create index openffs.VEND_SSN_112 on openffs.MF_DA_VEND_FRM                     	(	VEND_SSN                      	);
create index openffs.VEND_SSN_116 on openffs.MF_DISB_IN_PRCS                    	(	VEND_SSN                      	);
create index openffs.VEND_SSN_119 on openffs.MF_EI                              	(	VEND_SSN                      	);
create index openffs.VEND_SSN_120A on openffs.MF_ER_JRNL_JN                              	(	TJ_VEND_SSN                      	);
create index openffs.VEND_SSN_120B on openffs.MF_ER_JRNL_JN                              	(	TJ_DGGT_SSN                      	);
create index openffs.VEND_SSN_121 on openffs.MF_FA                              	(	VEND_SSN                      	);
create index openffs.VEND_SSN_123 on openffs.MF_FA_FRM                          	(	VEND_SSN                      	);
create index openffs.VEND_SSN_125 on openffs.MF_FB                              	(	VEND_SSN                      	);
create index openffs.VEND_SSN_127 on openffs.MF_FB_FRM                          	(	VEND_SSN                      	);
create index openffs.VEND_SSN_129 on openffs.MF_FC                              	(	VEND_SSN                      	);
create index openffs.VEND_SSN_131 on openffs.MF_FC_FRM                          	(	VEND_SSN                      	);
create index openffs.VEND_SSN_132 on openffs.MF_GREX_STG                        	(	VEND_SSN                      	);
create index openffs.VEND_SSN_138 on openffs.MF_GRIN_STG                        	(	VEND_SSN                      	);
create index openffs.VEND_SSN_140 on openffs.MF_GRIN_XWLK_DTAL                  	(	VEND_SSN                      	);
create index openffs.VEND_SSN_141 on openffs.MF_GR_OBLG_LN                      	(	VEND_SSN                      	);
create index openffs.VEND_SSN_58 on openffs.MF_BLNK_AGRE                       	(	VEND_SSN                      	);
create index openffs.VEND_SSN_60 on openffs.MF_BW_FRM_LN                       	(	VEND_SSN                      	);
create index openffs.VEND_SSN_62 on openffs.MF_BW_LN                           	(	VEND_SSN                      	);
create index openffs.VEND_SSN_64 on openffs.MF_BZ_FRM_LN                       	(	VEND_SSN                      	);
create index openffs.VEND_SSN_66 on openffs.MF_BZ_LN                           	(	VEND_SSN                      	);
create index openffs.VEND_SSN_67 on openffs.MF_CCS_STG_REC                           	(	VEND_SSN                      	);
create index openffs.VEND_SSN_68 on openffs.MF_CIR_INBD_XWLK_DTAL                           	(	VEND_SSN                      	);
create index openffs.VEND_SSN_69 on openffs.MF_CIR_STGN                           	(	VEND_SSN                      	);
create index openffs.VEND_SSN_70 on openffs.MF_CRCD_LOG                        	(	VEND_SSN                      	);
create index openffs.VEND_SSN_72 on openffs.MF_CRCD_RCON                       	(	VEND_SSN                      	);
create index openffs.VEND_SSN_74 on openffs.MF_CRCD_TRAN                       	(	VEND_SSN                      	);
create index openffs.VEND_SSN_80 on openffs.MF_CR_FRM_LN                       	(	VEND_SSN                      	);
create index openffs.VEND_SSN_86 on openffs.MF_CR_LN                           	(	VEND_SSN                      	);
create index openffs.VEND_SSN_90 on openffs.MF_CR_LN_AMD                       	(	VEND_SSN                      	);
create index openffs.VEND_SSN_94 on openffs.MF_CSHR_NATG                       	(	VEND_SSN                      	);
create index openffs.VEND_SSN_96 on openffs.MF_CSHR_NATG_FRM                   	(	VEND_SSN                      	);
create index openffs.VEND_SSN_99 on openffs.MF_CTRC                            	(	VEND_SSN                      	);
create index openffs.VEND_SSN_FL_133 on openffs.MF_GREX_XWLK                       	(	VEND_SSN_FL                   	);
create index openffs.VEND_SSN_FR_136 on openffs.MF_GREX_XWLK_DTAL                  	(	VEND_SSN_FR                   	);
create index openffs.VEND_SSN_OP_135 on openffs.MF_GREX_XWLK_DTAL                  	(	VEND_SSN_OP                   	);
create index openffs.VEND_SSN_REF_137 on openffs.MF_GRIN_STG                        	(	VEND_SSN_REF                  	);
create index openffs.VEND_SSN_TO_134 on openffs.MF_GREX_XWLK_DTAL                  	(	VEND_SSN_TO                   	);

create index openffs.ALTP_SSN_190 on openffs.MF_IO_FRM                          	(	ALTP_SSN                      	);
create index openffs.DGGT_SSN_188 on openffs.MF_IO_FRM                          	(	DGGT_SSN                      	);
create index openffs.DGGT_SSN_212 on openffs.MF_IV_FRM                          	(	DGGT_SSN                      	);
create index openffs.VEND_SSN_152 on openffs.MF_IC_FRM                          	(	VEND_SSN                      	);
create index openffs.DGGT_SSN_153 on openffs.MF_IC_FRM                          	(	DGGT_SSN                      	);
create index openffs.VEND_SSN_192 on openffs.MF_IO_FRM                          	(	VEND_SSN                      	);
create index openffs.VEND_SSN_204 on openffs.MF_IQ_AMD                          	(	VEND_SSN                      	);
create index openffs.VEND_SSN_206 on openffs.MF_IQ_FRM                          	(	VEND_SSN                      	);
create index openffs.VEND_SSN_214 on openffs.MF_IV_FRM                          	(	VEND_SSN                      	);

create index openffs.VEND_SSN_347 on openffs.MF_SV_LN                           	(	VEND_SSN                      	);    

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

declare
   counter INTEGER := 0;
   --seedval NUMBER(9,0) := 123400000;
   oldnum CHAR(9);
   v_newnum varCHAR(9);
   cursor allnums is select distinct ssn, newnum from openffs.SSN_XWLK where newnum is not null 
   										union 
   									select distinct e.socl_scty_num, null from openffs.mf_empl e where not exists (select 1 from openffs.ssn_xwlk v where trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null;
   pointer allnums%ROWTYPE;
begin
   for pointer in allnums
      loop
        counter := counter+1;
        oldnum  := SUBSTR(pointer.ssn,1,9);
        --newnum  := LTRIM(TO_CHAR(seedval + counter, '999999999'));
        v_newnum  := pointer.newnum;

update openffs.MF_TI_FRM                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_TN                                set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_TN99E_ACTY_LOG                                set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_TN_FRM                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_TP                                set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_TP_FRM                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_TP_FRM_LN                         set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_TP_LN                             set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_TR                                set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_TR_AMD                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_TR_FRM                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_TV                                set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_TV_FRM                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_VEND                              set SSN                           = v_newnum where SSN                    = oldnum;
commit;
update openffs.MF_VEND_DOC                          set SSN                           = v_newnum where SSN                    = oldnum;
commit;
update openffs.MF_VEND_DOC_LN                       set SSN                           = v_newnum where SSN                    = oldnum;
commit;
update openffs.MF_VEND_EVAL                         set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_VEND_FRM                          set SSN                           = v_newnum where SSN                    = oldnum;
commit;
update openffs.MF_VEND_FRM_LN                       set SSN                           = v_newnum where SSN                    = oldnum;
commit;
update openffs.MF_VEND_OFFR                         set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_VEND_WKSP                         set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_VI_LOG_SUMR                                set SSN                      = v_newnum where SSN               = oldnum;
commit;
update openffs.MF_WKLD_ASGT                                set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
   end loop;
end;
/



declare
   counter INTEGER := 0;
   --seedval NUMBER(9,0) := 123400000;
   oldnum CHAR(9);
   v_newnum varCHAR(9);
   cursor allnums is select distinct ssn, newnum from openffs.SSN_XWLK where newnum is not null 
   										union 
   									select distinct e.socl_scty_num, null from openffs.mf_empl e where not exists (select 1 from openffs.ssn_xwlk v where trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null;
   pointer allnums%ROWTYPE;
begin
   for pointer in allnums
      loop
        counter := counter+1;
        oldnum  := SUBSTR(pointer.ssn,1,9);
        --newnum  := LTRIM(TO_CHAR(seedval + counter, '999999999'));
        v_newnum  := pointer.newnum;

update openffs.MF_IO                                set DGGT_SSN                      = v_newnum where DGGT_SSN               = oldnum;
commit;
update openffs.MF_IO                                set ALTP_SSN                      = v_newnum where ALTP_SSN               = oldnum;
commit;
update openffs.MF_IO                                set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_IO_AMD                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_IO_AMD                            set ALTP_SSN                      = v_newnum where ALTP_SSN               = oldnum;
commit;
update openffs.MF_IO_AMD                            set DGGT_SSN                      = v_newnum where DGGT_SSN               = oldnum;
commit;

   end loop;
end;
/



declare
   counter INTEGER := 0;
   --seedval NUMBER(9,0) := 123400000;
   oldnum CHAR(9);
   v_newnum varCHAR(9);
   cursor allnums is select distinct ssn, newnum from openffs.SSN_XWLK where newnum is not null 
   										union 
   									select distinct e.socl_scty_num, null from openffs.mf_empl e where not exists (select 1 from openffs.ssn_xwlk v where trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null;
   pointer allnums%ROWTYPE;
begin
   for pointer in allnums
      loop
        counter := counter+1;
        oldnum  := SUBSTR(pointer.ssn,1,9);
        --newnum  := LTRIM(TO_CHAR(seedval + counter, '999999999'));
        v_newnum  := pointer.newnum;

update openffs.MF_BLNK_AGRE                         set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_BW_FRM_LN                         set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_BW_LN                             set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_BZ_FRM_LN                         set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_BZ_LN                             set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_CCS_STG_REC                             set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_CIR_INBD_XWLK_DTAL                             set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_CIR_STGN                             set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_CHEK_SUMR                         set PAYE_SSN                      = v_newnum where PAYE_SSN               = oldnum;
commit;
update openffs.MF_CRCD_LOG                          set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_CRCD_RCON                         set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_CRCD_TRAN                         set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_CRCD_TYPE                         set NON_VEND_SSN                  = v_newnum where NON_VEND_SSN           = oldnum;
commit;
update openffs.MF_CRCD_TYPE                         set DFLT_VEND_SSN                 = v_newnum where DFLT_VEND_SSN          = oldnum;
commit;
update openffs.MF_CR_FRM_LN                         set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_CR_FRM_LN                         set DGGT_SSN                      = v_newnum where DGGT_SSN               = oldnum;
commit;
update openffs.MF_CR_LN                             set DGGT_SSN                      = v_newnum where DGGT_SSN               = oldnum;
commit;
update openffs.MF_CR_LN                             set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_CR_LN_AMD                         set DGGT_SSN                      = v_newnum where DGGT_SSN               = oldnum;
commit;
update openffs.MF_CR_LN_AMD                         set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_CR_PY_FRM_LN                      set SSN                           = v_newnum where SSN                    = oldnum;
commit;
update openffs.MF_CR_PY_LN                          set SSN                           = v_newnum where SSN                    = oldnum;
commit;
update openffs.MF_CSHR_NATG                         set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_CSHR_NATG_FRM                     set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_CSTD                              set SSN                           = v_newnum where SSN                    = oldnum;
commit;
update openffs.MF_CTRC                              set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_CTRC_FILE                         set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_DA_PAYE                           set PAYE_VEND_SSN                 = v_newnum where PAYE_VEND_SSN          = oldnum;
commit;
update openffs.MF_DA_PAYE_AMD                       set PAYE_VEND_SSN                 = v_newnum where PAYE_VEND_SSN          = oldnum;
commit;
update openffs.MF_DA_PAYE_FRM                       set PAYE_VEND_SSN                 = v_newnum where PAYE_VEND_SSN          = oldnum;
commit;
update openffs.MF_DA_VEND                           set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_DA_VEND_AMD                       set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_DA_VEND_FRM                       set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_DEBT_ACCT_PAYE                    set PAYE_VEND_SSN                 = v_newnum where PAYE_VEND_SSN          = oldnum;
commit;
update openffs.MF_DISB_IN_PRCS                      set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_EI                                set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_ER_JRNL_JN                                set TJ_VEND_SSN                      = v_newnum where TJ_VEND_SSN               = oldnum;
commit;
update openffs.MF_ER_JRNL_JN                                set TJ_DGGT_SSN                      = v_newnum where TJ_DGGT_SSN               = oldnum;
commit;
update openffs.MF_FA                                set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_FA_FRM                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_FB                                set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_FB_FRM                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_FC                                set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_FC_FRM                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_GREX_STG                          set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_GREX_XWLK                         set VEND_SSN_FL                   = v_newnum where VEND_SSN_FL            = oldnum;
commit;
update openffs.MF_GREX_XWLK_DTAL                    set VEND_SSN_TO                   = v_newnum where VEND_SSN_TO            = oldnum;
commit;
update openffs.MF_GREX_XWLK_DTAL                    set VEND_SSN_OP                   = v_newnum where VEND_SSN_OP            = oldnum;
commit;
update openffs.MF_GREX_XWLK_DTAL                    set VEND_SSN_FR                   = v_newnum where VEND_SSN_FR            = oldnum;
commit;
update openffs.MF_GRIN_STG                          set VEND_SSN_REF                  = v_newnum where VEND_SSN_REF           = oldnum;
commit;
update openffs.MF_GRIN_STG                          set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_GRIN_XWLK_DTAL                    set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_GR_OBLG_LN                        set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
        commit;
   end loop;
end;
/



declare
   counter INTEGER := 0;
   --seedval NUMBER(9,0) := 123400000;
   oldnum CHAR(9);
   v_newnum varCHAR(9);
   cursor allnums is select distinct ssn, newnum from openffs.SSN_XWLK where newnum is not null 
   										union 
   									select distinct e.socl_scty_num, null from openffs.mf_empl e where not exists (select 1 from openffs.ssn_xwlk v where trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null;
   pointer allnums%ROWTYPE;
begin
   for pointer in allnums
      loop
        counter := counter+1;
        oldnum  := SUBSTR(pointer.ssn,1,9);
        --newnum  := LTRIM(TO_CHAR(seedval + counter, '999999999'));
        v_newnum  := pointer.newnum;

update openffs.MF_IC_FRM                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_IC_FRM                            set DGGT_SSN                      = v_newnum where DGGT_SSN               = oldnum;
commit;
update openffs.MF_IO_FRM                            set DGGT_SSN                      = v_newnum where DGGT_SSN               = oldnum;
commit;
update openffs.MF_IO_FRM                            set ALTP_SSN                      = v_newnum where ALTP_SSN               = oldnum;
commit;
update openffs.MF_IO_FRM                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_IQ_AMD                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_IQ_FRM                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
update openffs.MF_IV_FRM                            set DGGT_SSN                      = v_newnum where DGGT_SSN               = oldnum;
commit;
update openffs.MF_IV_FRM                            set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
commit;
   end loop;
end;
/



declare
   counter INTEGER := 0;
   --seedval NUMBER(9,0) := 123400000;
   oldnum CHAR(9);
   v_newnum varCHAR(9);
   cursor allnums is select distinct ssn, newnum from openffs.SSN_XWLK where newnum is not null 
   										union 
   									select distinct e.socl_scty_num, null from openffs.mf_empl e where not exists (select 1 from openffs.ssn_xwlk v where trim(e.socl_scty_num) = trim(v.ssn))	and trim(e.socl_scty_num) is not null;
   pointer allnums%ROWTYPE;
begin
   for pointer in allnums
      loop
        counter := counter+1;
        oldnum  := SUBSTR(pointer.ssn,1,9);
        --newnum  := LTRIM(TO_CHAR(seedval + counter, '999999999'));
        v_newnum  := pointer.newnum;

update openffs.MF_SV_LN                             set VEND_SSN                      = v_newnum where VEND_SSN               = oldnum;
				commit;
   end loop;
end;
/

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

--PJB -- for any records that are not on Vendor table and are not 999 we'll just update to be 888888888
update openffs.MF_TI_FRM                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
--PJB -- column does not exist -- update openffs.MF_TI_FRM                            set DGGT_SSN                      = '888888888' where DGGT_SSN                              is not null and substr(DGGT_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_TN                                set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_TN99E_ACTY_LOG                                set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_TN_FRM                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_TP                                set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_TP_FRM                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_TP_FRM_LN                         set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_TP_LN                             set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_TR                                set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_TR_AMD                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_TR_FRM                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_TV                                set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_TV_FRM                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_VEND                              set SSN                           = '888888888' where SSN                                   is not null and substr(SSN                 ,1,3) not in ('123','234','999');
update openffs.MF_VEND_DOC                          set SSN                           = '888888888' where SSN                                   is not null and substr(SSN                 ,1,3) not in ('123','234','999');
update openffs.MF_VEND_DOC_LN                       set SSN                           = '888888888' where SSN                                   is not null and substr(SSN                 ,1,3) not in ('123','234','999');
update openffs.MF_VEND_EVAL                         set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_VEND_FRM                          set SSN                           = '888888888' where SSN                                   is not null and substr(SSN                 ,1,3) not in ('123','234','999');
update openffs.MF_VEND_FRM_LN                       set SSN                           = '888888888' where SSN                                   is not null and substr(SSN                 ,1,3) not in ('123','234','999');
update openffs.MF_VEND_OFFR                         set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_VEND_WKSP                         set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_VI_LOG_SUMR                                set SSN                      = '888888888' where SSN                              is not null and substr(SSN            ,1,3) not in ('123','234','999');
update openffs.MF_WKLD_ASGT                                set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_VEND_RORG                         set FROM_VEND_CD                  = '888888888' where length(MF_VEND_RORG.FROM_VEND_CD)     = 9         and substr(FROM_VEND_CD        ,1,3) not in ('123','234','999');
update openffs.MF_IO                                set DGGT_SSN                      = '888888888' where DGGT_SSN                              is not null and substr(DGGT_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_IO                                set ALTP_SSN                      = '888888888' where ALTP_SSN                              is not null and substr(ALTP_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_IO                                set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_IO_AMD                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_IO_AMD                            set ALTP_SSN                      = '888888888' where ALTP_SSN                              is not null and substr(ALTP_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_IO_AMD                            set DGGT_SSN                      = '888888888' where DGGT_SSN                              is not null and substr(DGGT_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_BLNK_AGRE                         set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_BW_FRM_LN                         set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_BW_LN                             set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_BZ_FRM_LN                         set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_BZ_LN                             set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CCS_STG_REC                             set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CIR_INBD_XWLK_DTAL                             set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CIR_STGN                             set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CHEK_SUMR                         set PAYE_SSN                      = '888888888' where PAYE_SSN                              is not null and substr(PAYE_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CRCD_LOG                          set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CRCD_RCON                         set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CRCD_TRAN                         set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CRCD_TYPE                         set NON_VEND_SSN                  = '888888888' where NON_VEND_SSN                          is not null and substr(NON_VEND_SSN        ,1,3) not in ('123','234','999');
update openffs.MF_CRCD_TYPE                         set DFLT_VEND_SSN                 = '888888888' where DFLT_VEND_SSN                         is not null and substr(DFLT_VEND_SSN       ,1,3) not in ('123','234','999');
update openffs.MF_CR_FRM_LN                         set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CR_FRM_LN                         set DGGT_SSN                      = '888888888' where DGGT_SSN                              is not null and substr(DGGT_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CR_LN                             set DGGT_SSN                      = '888888888' where DGGT_SSN                              is not null and substr(DGGT_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CR_LN                             set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CR_LN_AMD                         set DGGT_SSN                      = '888888888' where DGGT_SSN                              is not null and substr(DGGT_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CR_LN_AMD                         set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CR_PY_FRM_LN                      set SSN                           = '888888888' where SSN                                   is not null and substr(SSN                 ,1,3) not in ('123','234','999');
update openffs.MF_CR_PY_LN                          set SSN                           = '888888888' where SSN                                   is not null and substr(SSN                 ,1,3) not in ('123','234','999');
update openffs.MF_CSHR_NATG                         set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CSHR_NATG_FRM                     set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CSTD                              set SSN                           = '888888888' where SSN                                   is not null and substr(SSN                 ,1,3) not in ('123','234','999');
update openffs.MF_CTRC                              set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_CTRC_FILE                         set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_DA_PAYE                           set PAYE_VEND_SSN                 = '888888888' where PAYE_VEND_SSN                         is not null and substr(PAYE_VEND_SSN       ,1,3) not in ('123','234','999');
update openffs.MF_DA_PAYE_AMD                       set PAYE_VEND_SSN                 = '888888888' where PAYE_VEND_SSN                         is not null and substr(PAYE_VEND_SSN       ,1,3) not in ('123','234','999');
update openffs.MF_DA_PAYE_FRM                       set PAYE_VEND_SSN                 = '888888888' where PAYE_VEND_SSN                         is not null and substr(PAYE_VEND_SSN       ,1,3) not in ('123','234','999');
update openffs.MF_DA_VEND                           set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_DA_VEND_AMD                       set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_DA_VEND_FRM                       set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_DEBT_ACCT_PAYE                    set PAYE_VEND_SSN                 = '888888888' where PAYE_VEND_SSN                         is not null and substr(PAYE_VEND_SSN       ,1,3) not in ('123','234','999');
update openffs.MF_DISB_IN_PRCS                      set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_EI                                set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_ER_JRNL_JN                                set TJ_VEND_SSN                      = '888888888' where TJ_VEND_SSN                              is not null and substr(TJ_VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_ER_JRNL_JN                                set TJ_DGGT_SSN                      = '888888888' where TJ_DGGT_SSN                              is not null and substr(TJ_DGGT_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_FA                                set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_FA_FRM                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_FB                                set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_FB_FRM                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_FC                                set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_FC_FRM                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_GREX_STG                          set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
--PJB -- no need to update a flag -- update openffs.MF_GREX_XWLK                         set VEND_SSN_FL                   = '888888888' where VEND_SSN_FL                           is not null and substr(VEND_SSN_FL         ,1,3) not in ('123','234','999');
update openffs.MF_GREX_XWLK_DTAL                    set VEND_SSN_TO                   = '888888888' where VEND_SSN_TO                           is not null and substr(VEND_SSN_TO         ,1,3) not in ('123','234','999');
update openffs.MF_GREX_XWLK_DTAL                    set VEND_SSN_OP                   = '888888888' where VEND_SSN_OP                           is not null and substr(VEND_SSN_OP         ,1,3) not in ('123','234','999');
update openffs.MF_GREX_XWLK_DTAL                    set VEND_SSN_FR                   = '888888888' where VEND_SSN_FR                           is not null and substr(VEND_SSN_FR         ,1,3) not in ('123','234','999');
update openffs.MF_GRIN_STG                          set VEND_SSN_REF                  = '888888888' where VEND_SSN_REF                          is not null and substr(VEND_SSN_REF        ,1,3) not in ('123','234','999');
update openffs.MF_GRIN_STG                          set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_GRIN_XWLK_DTAL                    set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_GR_OBLG_LN                        set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_IC_FRM                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_IC_FRM                            set DGGT_SSN                      = '888888888' where DGGT_SSN                              is not null and substr(DGGT_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_IO_FRM                            set DGGT_SSN                      = '888888888' where DGGT_SSN                              is not null and substr(DGGT_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_IO_FRM                            set ALTP_SSN                      = '888888888' where ALTP_SSN                              is not null and substr(ALTP_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_IO_FRM                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_IQ_AMD                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_IQ_FRM                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_IV_FRM                            set DGGT_SSN                      = '888888888' where DGGT_SSN                              is not null and substr(DGGT_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_IV_FRM                            set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
update openffs.MF_SV_LN                             set VEND_SSN                      = '888888888' where VEND_SSN                              is not null and substr(VEND_SSN            ,1,3) not in ('123','234','999');
commit;

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

drop index openffs.DGGT_SSN_399            ;
drop index openffs.SSN_427                 ;
drop index openffs.SSN_429                 ;
drop index openffs.SSN_433                 ;
drop index openffs.SSN_435                 ;
drop index openffs.SSN_VENDCD              ;
drop index openffs.VEND_SSN_403            ;
drop index openffs.VEND_SSN_404            ;
drop index openffs.VEND_SSN_405            ;
drop index openffs.VEND_SSN_407            ;
drop index openffs.VEND_SSN_409            ;
drop index openffs.VEND_SSN_411            ;
drop index openffs.VEND_SSN_413            ;
drop index openffs.VEND_SSN_415            ;
drop index openffs.VEND_SSN_417            ;
drop index openffs.VEND_SSN_419            ;
drop index openffs.VEND_SSN_421            ;
drop index openffs.VEND_SSN_423            ;
drop index openffs.MF_VEND_SSN           ;
drop index openffs.VEND_SSN_431            ;
drop index openffs.VEND_SSN_437            ;
drop index openffs.VEND_SSN_439            ;
drop index openffs.VEND_SSN_443            ;
drop index openffs.VEND_SSN_447            ;


drop index openffs.DGGT_SSN_176            ;
drop index openffs.ALTP_SSN_178            ;
drop index openffs.VEND_SSN_180            ;
drop index openffs.VEND_SSN_182            ;
drop index openffs.ALTP_SSN_184            ;
drop index openffs.DGGT_SSN_186            ;

drop index openffs.DFLT_VEND_SSN_78        ;
drop index openffs.DGGT_SSN_82             ;
drop index openffs.DGGT_SSN_84             ;
drop index openffs.DGGT_SSN_88             ;
drop index openffs.NON_VEND_SSN_76         ;
drop index openffs.PAYE_SSN_68             ;
drop index openffs.PAYE_VEND_SSN_102       ;
drop index openffs.PAYE_VEND_SSN_104       ;
drop index openffs.PAYE_VEND_SSN_106       ;
drop index openffs.PAYE_VEND_SSN_114       ;
drop index openffs.SSN_91                  ;
drop index openffs.SSN_92                  ;
drop index openffs.SSN_97                  ;
drop index openffs.VEND_SSN_100            ;
drop index openffs.VEND_SSN_108            ;
drop index openffs.VEND_SSN_110            ;
drop index openffs.VEND_SSN_112            ;
drop index openffs.VEND_SSN_116            ;
drop index openffs.VEND_SSN_119            ;
drop index openffs.VEND_SSN_120A            ;
drop index openffs.VEND_SSN_120B            ;
drop index openffs.VEND_SSN_121            ;
drop index openffs.VEND_SSN_123            ;
drop index openffs.VEND_SSN_125            ;
drop index openffs.VEND_SSN_127            ;
drop index openffs.VEND_SSN_129            ;
drop index openffs.VEND_SSN_131            ;
drop index openffs.VEND_SSN_132            ;
drop index openffs.VEND_SSN_138            ;
drop index openffs.VEND_SSN_140            ;
drop index openffs.VEND_SSN_141            ;
drop index openffs.VEND_SSN_58             ;
drop index openffs.VEND_SSN_60             ;
drop index openffs.VEND_SSN_62             ;
drop index openffs.VEND_SSN_64             ;
drop index openffs.VEND_SSN_66             ;
drop index openffs.VEND_SSN_67             ;
drop index openffs.VEND_SSN_68             ;
drop index openffs.VEND_SSN_69             ;
drop index openffs.VEND_SSN_70             ;
drop index openffs.VEND_SSN_72             ;
drop index openffs.VEND_SSN_74             ;
drop index openffs.VEND_SSN_80             ;
drop index openffs.VEND_SSN_86             ;
drop index openffs.VEND_SSN_90             ;
drop index openffs.VEND_SSN_94             ;
drop index openffs.VEND_SSN_96             ;
drop index openffs.VEND_SSN_99             ;
drop index openffs.VEND_SSN_FL_133         ;
drop index openffs.VEND_SSN_FR_136         ;
drop index openffs.VEND_SSN_OP_135         ;
drop index openffs.VEND_SSN_REF_137        ;
drop index openffs.VEND_SSN_TO_134         ;

drop index openffs.ALTP_SSN_190            ;
drop index openffs.DGGT_SSN_188            ;
drop index openffs.DGGT_SSN_212            ;
drop index openffs.VEND_SSN_152            ;
drop index openffs.DGGT_SSN_153            ;
drop index openffs.VEND_SSN_192            ;
drop index openffs.VEND_SSN_204            ;
drop index openffs.VEND_SSN_206            ;
drop index openffs.VEND_SSN_214            ;

drop index openffs.VEND_SSN_347            ;


commit;
spool off;
exit;
