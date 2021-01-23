--se tiver que precisa ser deletada e estiver offline, ele deixa online, se nao, ele apenas tira do sql, mas nao deleta do disco
select 		
	   'alter database ' + name + ' set online' + char(10) +
	    'go' + char(10)
		from sys.databases
where name in
('_NAVIS',
'ab_prod2007',
'acfslj01',
'ajq_cpt',
'ajq_cpt2',
'Altaj_Tij',
'ams_lojafranca',
'ams_lojafranca_orig',
'Ams_teste',
'araslj01_new',
'araslj02',
'artlev',
'artlevprod',
'auguri_bkp',
'auguri_procs_bkp',
'bd',
'BD_2009_DARUMA',
'BD_2009_DARUMA_DISCADO',
'BD_2009_MP2100',
'BD_2009_MP2100_DISCADO',
'bd_cecy',
'bd_ddd',
'bd_prod2008',
'bd_prod2100',
'bd_prod7000',
'bd_prod7000dedicado',
'bd_proddaruma',
'bd_rimele',
'bd_rimele_captasql2',
'bd_rimele2',
'bkpmccr',
'bkpmccr2',
'cbslj06',
'CECY',
'cfg_fopag',
'cg_pdv',
'cidadejardim',
'co_livros',
'coliseu_pdv',
'contab',
'contab_29',
'contab_jv',
'CONVEXFIS',
'cpt_jv_loja_iguatemi',
'cptolap',
'cptprocs2000',
'cptprocs2000_1',
'cptprocs2005',
'cptprocs2005v2',
'cptverif',
'Crack_Me',
'criativa_cbslj03',
'ctbvazio',
'danielle_Profiler',
'danyfopag_01',
'db_divadoro2',
'delamour',
'delamour2_1',
'divadoro',
'dl_amg',
'dl_contabilidade',
'dl_cptdb01',
'dl_fab_amg',
'dl_fab_dramalux',
'dl_fabrica',
'dl_pdv',
'dl_tst_dl_fop01',
'dlcptprocs',
'ecm_livros',
'eldorado',
'EMC',
'estoque',
'ETtstloja',
'fj_prod2008',
'gd',
'ger_cecy_1',
'ggfest_02',
'homologacao_a5',
'importfolha',
'inel',
'inel_sljcli',
'jv_livros',
'jv_nk',
'jv_pos',
'jvfis',
'kabalah',
'livrosdannyhome',
'livrostb',
'loja',
'lojabkp',
'man_prod2008',
'MB_FolhaPagto',
'mb_homologacao',
'mb_logistica',
'mb_moviment',
'mb_pdv',
'mcf_prod2007',
'ntcecyslj01',
'ntmslj01',
'ntnslj01',
'NTNVSLJ01',
'nu_livros01',
'omega_erp',
'paf102010',
'Pcenturion',
'profiler_mb',
'rachel_livros',
'rdslj03',
'rh_ppr_jac',
'rj400',
'rj400_dts',
'sms_tst_01',
'sms_tst_02',
'sms_tst_03',
'tb_fop01',
'teste_sljcli',
'TESTEMG_LIVRO',
'tmptorino',
'tst_convex',
'TST_CTB',
'tst_dmd_lab01',
'tst_livros',
'tst_new_un_mp',
'tstamsliv',
'tstbho',
'tstntnslj01',
'vvctb01')			

												
--comeca a delecao das bases
select 		
	   /*'alter database ' + name + ' set single_user with rollback immediate' + char(10) +
       'go' + char(10) + */
	   'drop database ' + name + char(10) +
       'go' + char(10)
from sys.databases where name in
('_NAVIS',
'ab_prod2007',
'acfslj01',
'ajq_cpt',
'ajq_cpt2',
'Altaj_Tij',
'ams_lojafranca',
'ams_lojafranca_orig',
'Ams_teste',
'araslj01_new',
'araslj02',
'artlev',
'artlevprod',
'auguri_bkp',
'auguri_procs_bkp',
'bd',
'BD_2009_DARUMA',
'BD_2009_DARUMA_DISCADO',
'BD_2009_MP2100',
'BD_2009_MP2100_DISCADO',
'bd_cecy',
'bd_ddd',
'bd_prod2008',
'bd_prod2100',
'bd_prod7000',
'bd_prod7000dedicado',
'bd_proddaruma',
'bd_rimele',
'bd_rimele_captasql2',
'bd_rimele2',
'bkpmccr',
'bkpmccr2',
'cbslj06',
'CECY',
'cfg_fopag',
'cg_pdv',
'cidadejardim',
'co_livros',
'coliseu_pdv',
'contab',
'contab_29',
'contab_jv',
'CONVEXFIS',
'cpt_jv_loja_iguatemi',
'cptolap',
'cptprocs2000',
'cptprocs2000_1',
'cptprocs2005',
'cptprocs2005v2',
'cptverif',
'Crack_Me',
'criativa_cbslj03',
'ctbvazio',
'danielle_Profiler',
'danyfopag_01',
'db_divadoro2',
'delamour',
'delamour2_1',
'divadoro',
'dl_amg',
'dl_contabilidade',
'dl_cptdb01',
'dl_fab_amg',
'dl_fab_dramalux',
'dl_fabrica',
'dl_pdv',
'dl_tst_dl_fop01',
'dlcptprocs',
'ecm_livros',
'eldorado',
'EMC',
'estoque',
'ETtstloja',
'fj_prod2008',
'gd',
'ger_cecy_1',
'ggfest_02',
'homologacao_a5',
'importfolha',
'inel',
'inel_sljcli',
'jv_livros',
'jv_nk',
'jv_pos',
'jvfis',
'kabalah',
'livrosdannyhome',
'livrostb',
'loja',
'lojabkp',
'man_prod2008',
'MB_FolhaPagto',
'mb_homologacao',
'mb_logistica',
'mb_moviment',
'mb_pdv',
'mcf_prod2007',
'ntcecyslj01',
'ntmslj01',
'ntnslj01',
'NTNVSLJ01',
'nu_livros01',
'omega_erp',
'paf102010',
'Pcenturion',
'profiler_mb',
'rachel_livros',
'rdslj03',
'rh_ppr_jac',
'rj400',
'rj400_dts',
'sms_tst_01',
'sms_tst_02',
'sms_tst_03',
'tb_fop01',
'teste_sljcli',
'TESTEMG_LIVRO',
'tmptorino',
'tst_convex',
'TST_CTB',
'tst_dmd_lab01',
'tst_livros',
'tst_new_un_mp',
'tstamsliv',
'tstbho',
'tstntnslj01',
'vvctb01')	