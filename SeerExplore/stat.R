library("data.table")

cancer_data <- fread("./hypocancer_all.csv")

# 改变量名称中其他符号为“_”，并使用leader+o导出为 comment，方便变量引用
library("stringr")
names(cancer_data) <- str_replace_all(names(cancer_data), "[- <,+/()]", "_")
names(cancer_data)
# [1] 'Age_recode_with__1_year_olds' [2] 'Race_recode__White__Black__Other_'
# [3] 'Sex' [4] 'Year_of_diagnosis' [5] 'SEER_registry' [6]
# 'Louisiana_2005___1st_vs_2nd_half_of_year' [7] 'County' [8] 'State_county'
# [9] 'In_research_data' [10] 'PRCDA_2016' [11] 'PRCDA_Region' [12]
# 'Site_recode_ICD_O_3_WHO_2008' [13] 'Behavior_recode_for_analysis' [14]
# 'AYA_site_recode_WHO_2008' [15] 'Lymphoma_subtype_recode_WHO_2008' [16]
# 'ICCC_site_recode_ICD_O_3_WHO_2008' [17] 'TNM_7_CS_v0204__Schema' [18]
# 'CS_Schema___AJCC_6th_Edition' [19] 'Primary_Site___labeled' [20]
# 'Primary_Site' [21] 'Histologic_Type_ICD_O_3' [22] 'Behavior_code_ICD_O_3'
# [23] 'Grade' [24] 'Laterality' [25] 'Diagnostic_Confirmation' [26]
# 'ICD_O_3_Hist_behav' [27] 'ICD_O_3_Hist_behav__malignant' [28]
# 'Histology_recode___broad_groupings' [29]
# 'Histology_recode___Brain_groupings' [30]
# 'ICCC_site_rec_extended_ICD_O_3_WHO_2008' [31]
# 'Site_recode_B_ICD_O_3_WHO_2008' [32] 'Summary_stage_2000__1998__' [33]
# 'SEER_Combined_Summary_Stage_2000__2004__' [34]
# 'SEER_historic_stage_A__1973_2015_' [35] 'Derived_SS1977__2004_2015_' [36]
# 'SEER_summary_stage_2000__2001_2003_' [37]
# 'SEER_summary_stage_1977__1995_2000_' [38]
# 'Derived_AJCC_Stage_Group__7th_ed__2010_2015_' [39]
# 'Derived_AJCC_T__7th_ed__2010_2015_' [40]
# 'Derived_AJCC_N__7th_ed__2010_2015_' [41]
# 'Derived_AJCC_M__7th_ed__2010_2015_' [42] 'Derived_SEER_Cmb_Stg_Grp__2016__'
# [43] 'Derived_SEER_Combined_T__2016__' [44] 'Derived_SEER_Combined_N__2016__'
# [45] 'Derived_SEER_Combined_M__2016__' [46]
# 'Derived_SEER_Combined_T_Src__2016__' [47]
# 'Derived_SEER_Combined_N_Src__2016__' [48]
# 'Derived_SEER_Combined_M_Src__2016__' [49]
# 'Derived_AJCC_Stage_Group__6th_ed__2004_2015_' [50]
# 'Breast___Adjusted_AJCC_6th_Stage__1988_2015_' [51]
# 'Derived_AJCC_T__6th_ed__2004_2015_' [52]
# 'Derived_AJCC_N__6th_ed__2004_2015_' [53]
# 'Derived_AJCC_M__6th_ed__2004_2015_' [54]
# 'Breast___Adjusted_AJCC_6th_T__1988_2015_' [55]
# 'Breast___Adjusted_AJCC_6th_N__1988_2015_' [56]
# 'Breast___Adjusted_AJCC_6th_M__1988_2015_' [57]
# 'Lymphoma___Ann_Arbor_Stage__1983_2015_' [58]
# 'AJCC_stage_3rd_edition__1988_2003_' [59]
# 'SEER_modified_AJCC_stage_3rd__1988_2003_' [60]
# 'T_value___based_on_AJCC_3rd__1988_2003_' [61]
# 'N_value___based_on_AJCC_3rd__1988_2003_' [62]
# 'M_value___based_on_AJCC_3rd__1988_2003_' [63] 'TNM_Edition_Number__2016__'
# [64] 'RX_Summ__Surg_Prim_Site__1998__' [65]
# 'RX_Summ__Scope_Reg_LN_Sur__2003__' [66] 'RX_Summ__Surg_Oth_Reg_Dis__2003__'
# [67] 'Radiation_sequence_with_surgery' [68]
# 'Reason_no_cancer_directed_surgery' [69] 'Radiation_recode' [70]
# 'Chemotherapy_recode__yes__no_unk_' [71]
# 'Scope_of_reg_lymph_nd_surg__1998_2002_' [72]
# 'RX_Summ__Reg_LN_Examined__1998_2002_' [73]
# 'Surgery_of_oth_reg_dis_sites__1998_2002_' [74]
# 'Site_specific_surgery__1973_1997_varying_detail_by_year_and_site_' [75]
# 'Radiation_to_Brain_or_CNS_Recode__1988_1997_' [76]
# 'Tumor_Size_Summary__2016__' [77] 'Regional_nodes_examined__1988__' [78]
# 'Regional_nodes_positive__1988__' [79]
# 'SEER_Combined_Mets_at_DX_bone__2010__' [80]
# 'SEER_Combined_Mets_at_DX_brain__2010__' [81]
# 'SEER_Combined_Mets_at_DX_liver__2010__' [82]
# 'SEER_Combined_Mets_at_DX_lung__2010__' [83] 'Mets_at_DX_Distant_LN__2016__'
# [84] 'Mets_at_DX_Other__2016__' [85] 'Breast_Subtype__2010__' [86]
# 'ER_Status_Recode_Breast_Cancer__1990__' [87]
# 'PR_Status_Recode_Breast_Cancer__1990__' [88] 'Derived_HER2_Recode__2010__'
# [89] 'Lymph_vascular_Invasion__2004__varying_by_schema_' [90]
# 'CS_tumor_size__2004_2015_' [91] 'CS_extension__2004_2015_' [92]
# 'CS_lymph_nodes__2004_2015_' [93] 'CS_mets_at_dx__2004_2015_' [94]
# 'CS_Tumor_Size_Ext_Eval__2004_2015_' [95] 'CS_Reg_Node_Eval__2004_2015_' [96]
# 'CS_Mets_Eval__2004_2015_' [97]
# 'CS_site_specific_factor_1__2004__varying_by_schema_' [98]
# 'CS_site_specific_factor_2__2004__varying_by_schema_' [99]
# 'CS_site_specific_factor_3__2004__varying_by_schema_' [100]
# 'CS_site_specific_factor_4__2004__varying_by_schema_' [101]
# 'CS_site_specific_factor_5__2004__varying_by_schema_' [102]
# 'CS_site_specific_factor_6__2004__varying_by_schema_' [103]
# 'CS_site_specific_factor_7__2004__varying_by_schema_' [104]
# 'CS_site_specific_factor_8__2004__varying_by_schema_' [105]
# 'CS_site_specific_factor_9__2004__varying_by_schema_' [106]
# 'CS_site_specific_factor_10__2004__varying_by_schema_' [107]
# 'CS_site_specific_factor_11__2004__varying_by_schema_' [108]
# 'CS_site_specific_factor_12__2004__varying_by_schema_' [109]
# 'CS_site_specific_factor_13__2004__varying_by_schema_' [110]
# 'CS_site_specific_factor_15__2004__varying_by_schema_' [111]
# 'CS_site_specific_factor_16__2004__varying_by_schema_' [112]
# 'CS_site_specific_factor_25__2004__varying_by_schema_' [113]
# 'CS_version_input_current__2004_2015_' [114]
# 'CS_version_input_original__2004_2015_' [115]
# 'CS_version_derived__2004_2015_' [116]
# 'EOD_10___Prostate_path_ext__1995_2003_' [117] 'EOD_10___extent__1988_2003_'
# [118] 'EOD_10___nodes__1988_2003_' [119] 'EOD_10___size__1988_2003_' [120]
# 'Tumor_marker_1__1990_2003_' [121] 'Tumor_marker_2__1990_2003_' [122]
# 'Tumor_marker_3__1998_2003_' [123] 'Coding_system_EOD__1973_2003_' [124]
# '2_Digit_NS_EOD_part_1__1973_1982_' [125] '2_Digit_NS_EOD_part_2__1973_1982_'
# [126] '2_Digit_SS_EOD_part_1__1973_1982_' [127]
# '2_Digit_SS_EOD_part_2__1973_1982_' [128]
# 'Expanded_EOD_1____CP53__1973_1982_' [129]
# 'Expanded_EOD_2____CP54__1973_1982_' [130]
# 'Expanded_EOD_1_2____CP53_54__1973_1982_' [131]
# 'Expanded_EOD_3____CP55__1973_1982_' [132]
# 'Expanded_EOD_4____CP56__1973_1982_' [133]
# 'Expanded_EOD_5____CP57__1973_1982_' [134]
# 'Expanded_EOD_6____CP58__1973_1982_' [135]
# 'Expanded_EOD_7____CP59__1973_1982_' [136]
# 'Expanded_EOD_8____CP60__1973_1982_' [137]
# 'Expanded_EOD_9____CP61__1973_1982_' [138]
# 'Expanded_EOD_10____CP62__1973_1982_' [139]
# 'Expanded_EOD_11____CP63__1973_1982_' [140]
# 'Expanded_EOD_12____CP64__1973_1982_' [141]
# 'Expanded_EOD_13____CP65__1973_1982_' [142] 'EOD_4___extent__1983_1987_'
# [143] 'EOD_4___nodes__1983_1987_' [144] 'EOD_4___size__1983_1987_' [145]
# 'COD_to_site_recode' [146] 'SEER_cause_specific_death_classification' [147]
# 'SEER_other_cause_of_death_classification' [148] 'Survival_months' [149]
# 'Survival_months_flag' [150] 'COD_to_site_rec_KM' [151]
# 'Vital_status_recode__study_cutoff_used_' [152] 'Type_of_follow_up_expected'
# [153] 'Sequence_number' [154] 'First_malignant_primary_indicator' [155]
# 'Primary_by_international_rules' [156] 'Record_number_recode' [157]
# 'Total_number_of_in_situ_malignant_tumors_for_patient' [158]
# 'Total_number_of_benign_borderline_tumors_for_patient' [159]
# 'Behavior_code_ICD_O_2' [160] 'Histology_ICD_O_2' [161] 'Recode_ICD_O_2_to_9'
# [162] 'Recode_ICD_O_2_to_10' [163] 'Age_recode_with_single_ages_and_85_'
# [164] 'Race_recode__W__B__AI__API_' [165]
# 'Origin_recode_NHIA__Hispanic__Non_Hisp_' [166]
# 'Race_and_origin_recode__NHW__NHB__NHAIAN__NHAPI__Hispanic_' [167]
# 'Age_at_diagnosis' [168] 'Race_ethnicity' [169] 'IHS_Link' [170]
# 'Year_of_birth' [171] 'Month_of_diagnosis' [172] 'Month_of_diagnosis_recode'
# [173] 'SS_seq_#___mal_ins__most_detail_' [174]
# 'SS_seq_#_1975____mal_ins__most_detail_' [175]
# 'SS_seq_#_1992____mal_ins__most_detail_' [176]
# 'SS_seq_#_2000____mal_ins__most_detail_' [177] 'Site___mal_ins__most_detail_'
# [178] 'SS_seq_#___mal__most_detail_' [179]
# 'SS_seq_#_1975____mal__most_detail_' [180]
# 'SS_seq_#_1992____mal__most_detail_' [181]
# 'SS_seq_#_2000____mal__most_detail_' [182] 'Site___malignant__most_detail_'
# [183] 'SS_seq_#___mal_ins__least_detail_' [184]
# 'SS_seq_#_1975____mal_ins__least_detail_' [185]
# 'SS_seq_#_1992____mal_ins__least_detail_' [186]
# 'SS_seq_#_2000____mal_ins__least_detail_' [187]
# 'Site___mal_ins__least_detail_' [188] 'SS_seq_#___mal__least_detail_' [189]
# 'SS_seq_#_1975____mal__least_detail_' [190]
# 'SS_seq_#_1992____mal__least_detail_' [191]
# 'SS_seq_#_2000____mal__least_detail_' [192] 'Site___malignant__least_detail_'
# [193] 'Patient_ID' [194] 'Type_of_Reporting_Source' [195]
# 'Insurance_Recode__2007__' [196] 'Marital_status_at_diagnosis'

library("DataExplorer")
library("tidyverse")
introduce(cancer_data)

# 查看空缺数值百分比
cancer_data[cancer_data == "Blank(s)"] <- NA
na_percent <- apply(cancer_data, MARGIN = 2, function(x) {
    sum(is.na(x))/length(x)
}) %>% as.data.frame()


