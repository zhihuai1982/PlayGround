library("data.table")

cancer_data <- fread("./hypopharynx.csv")

# 改变量名称中其他符号为“_”，并使用leader+o导出为 comment，方便变量引用
library("stringr")
names(cancer_data) <- str_replace_all(names(cancer_data), "[- <,+/()]", "_")
names(cancer_data)
#  [1] "Race_recode__White__Black__Other_"
#  [2] "Age_recode_with__1_year_olds"
#  [3] "Sex"
#  [4] "Year_of_diagnosis"
#  [5] "Site_recode_ICD_O_3_WHO_2008"
#  [6] "Behavior_recode_for_analysis"
#  [7] "Primary_Site"
#  [8] "Histologic_Type_ICD_O_3"
#  [9] "Grade"
# [10] "Laterality"
# [11] "ICD_O_3_Hist_behav"
# [12] "Derived_AJCC_Stage_Group__6th_ed__2004_2015_"
# [13] "RX_Summ__Surg_Prim_Site__1998__"
# [14] "RX_Summ__Scope_Reg_LN_Sur__2003__"
# [15] "RX_Summ__Surg_Oth_Reg_Dis__2003__"
# [16] "CS_tumor_size__2004_2015_"
# [17] "CS_extension__2004_2015_"
# [18] "CS_lymph_nodes__2004_2015_"
# [19] "CS_mets_at_dx__2004_2015_"
# [20] "COD_to_site_rec_KM"
# [21] "Sequence_number"
# [22] "Survival_months"
# [23] "First_malignant_primary_indicator"
# [24] "SEER_cause_specific_death_classification"
# [25] "SEER_other_cause_of_death_classification"

cancer_data[]
