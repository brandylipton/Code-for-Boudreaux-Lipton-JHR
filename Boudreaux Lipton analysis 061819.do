*Code to create tables and figures for "Medicaid Benefit Generosity and 
*Labor Market Outcomes: Evidence from Medicaid Adult Vision Benefits" after running "cleandata 111817 FINAL"

*run cleandata 101618

set matsize 10000

***********************************************************************************************************

*TABLE 1
*Vision Benefits and Participation in Medicaid

**********************************************************************************************************

set more off

*Model 1
xi: areg caid visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year [pweight=wtsupp] if sample3==1, cluster(statefip) absorb(statefip)

*Model 2
xi: reg caid visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year c.y##statefip [pweight=wtsupp] if sample3==1, cluster(statefip) 

*Model 3
xi: areg caid visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent i.year [pweight=wtsupp] if sample3==1, cluster(statefip) absorb(statefip)

*Model 4
xi: reg caid visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent i.year c.y##statefip [pweight=wtsupp] if sample3==1, cluster(statefip)

**************************************************************************************************************

*TABLE 2
*DD Estimates
****************************************************************************************************************

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*Taking models from DD on participation

*Model 1 - state and year FE only
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year [pweight=wtsupp] if sample3==1&caid==1, cluster(statefip) absorb(statefip)
}

*Model 2 - state and year FE and state trends
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year c.y##statefip [pweight=wtsupp] if sample3==1&caid==1, cluster(statefip) absorb(statefip)
}

*Model 3 - state and year FE and state-year variables
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent  [pweight=wtsupp] if sample3==1&caid==1, cluster(statefip) absorb(statefip)
}

*Model 4 - state and year FE, state trends, and state-year variables
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent c.y##statefip  [pweight=wtsupp] if sample3==1&caid==1, cluster(statefip) absorb(statefip)
}
*************************************************************************************************************
*FEMALES ONLY
**********************************************************************************************************
*DD Estimates
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*Taking models from DD on participation

*Model 1 - state and year FE only
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year [pweight=wtsupp] if sample3==1&caid==1&male==0, cluster(statefip) absorb(statefip)
}

*Model 2 - state and year FE and state trends
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year c.y##statefip [pweight=wtsupp] if sample3==1&caid==1&male==0, cluster(statefip) 
}

*Model 3 - state and year FE and state-year variables
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent  [pweight=wtsupp] if sample3==1&caid==1&male==0, cluster(statefip) absorb(statefip)
}

*Model 4 - state and year FE, state trends, and state-year variables
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent c.y##statefip  [pweight=wtsupp] if sample3==1&caid==1&male==0, cluster(statefip) 
}

******************************************************************************************************
*MALES ONLY
********************************************************************************************************
*DD Estimates
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*Taking models from DD on participation

*Model 1 - state and year FE only
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year [pweight=wtsupp] if sample3==1&caid==1&male==1, cluster(statefip) absorb(statefip)
}

*Model 2 - state and year FE and state trends
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year c.y##statefip [pweight=wtsupp] if sample3==1&caid==1&male==1, cluster(statefip) 
}

*Model 3 - state and year FE and state-year variables
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent  [pweight=wtsupp] if sample3==1&caid==1&male==1, cluster(statefip) absorb(statefip)
}

*Model 4 - state and year FE, state trends, and state-year variables
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent c.y##statefip  [pweight=wtsupp] if sample3==1&caid==1&male==1, cluster(statefip) 
}

*TEST FOR MALE-FEMALE DIFFERENCES*******************************************************************

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*Model 1 - state and year FE only
foreach depvar of local outcomes{
xi: reg `depvar' male##visionben_cylag male##c.age male##blacknh male##hispanic male##asianother male##married male##lesshs male##highschool male##citizen_gen male##year male##statefip [pweight=wtsupp] if sample3==1&caid==1, cluster(statefip) 
}

*Model 2 - state and year FE and trends
foreach depvar of local outcomes{
xi: reg `depvar' male##visionben_cylag male##c.age male##blacknh male##hispanic male##asianother male##married male##lesshs male##highschool male##citizen_gen male##year male##statefip male##c.y##statefip [pweight=wtsupp] if sample3==1&caid==1, cluster(statefip) 
}

*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
*MEANS
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*MEDICAID ONLY FOR DD TABLE****************************************************************

*foreach depvar of local outcomes{
*mean `depvar' [pweight=wtsupp] if sample3==1&caid==1, cluster(statefip)
*}

*FEMALE MEANS******************************************************************
foreach depvar of local outcomes{
mean `depvar' [pweight=wtsupp] if sample3==1&caid==1&male==0, cluster(statefip)
}
**MALE MEANS*******************************************************************
*foreach depvar of local outcomes{
*mean `depvar' [pweight=wtsupp] if sample3==1&caid==1&male==1, cluster(statefip)
*}

*FULL SAMPLE*************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

foreach depvar of local outcomes{
mean `depvar' [pweight=wtsupp] if sample3==1, cluster(statefip)
}

*FEMALE MEANS******************************************************************
foreach depvar of local outcomes{
mean `depvar' [pweight=wtsupp] if sample3==1&male==0, cluster(statefip)
}
*MALE MEANS*******************************************************************
foreach depvar of local outcomes{
mean `depvar' [pweight=wtsupp] if sample3==1&male==1, cluster(statefip)
}

*****************************************************************************************************
*Table 3
*Sample Composition

***************************************************************************************************

local demos age whitenh blacknh hispanic asianother married male lesshs highschool somecollege_plus citizen_gen 

*Model 1
foreach indvar of local demos{
xi: areg `indvar' visionben_cylag i.year  [pweight=wtsupp] if sample3==1&caid==1, cluster(statefip) absorb(statefip)
}

*Model 2
foreach indvar of local demos{
xi: reg `indvar' caid_visionbenlag caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

***********************************************************************************************************
*EMPLOYED SAMPLE
***********************************************************************************************************
*Model 1
foreach indvar of local demos{
xi: areg `indvar' visionben_cylag i.year  [pweight=wtsupp] if sample3==1&caid==1&employed_ly==1, cluster(statefip) absorb(statefip)
}

*Model 2
foreach indvar of local demos{
xi: reg `indvar' caid_visionbenlag caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&employed_ly==1, cluster(statefip) 
}

*******************************************************************************************************
*TABLE 4
*DDD Estimates, all and by gender - Panels A, B, and C

***************************************************************************************************************
set more off

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*PANEL A

*Model 3 (state trends)**********************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip c.y##statefip [pweight=wtsupp] if sample3==1, cluster(statefip) 
lincom visionben_cylag + caid_visionbenlag
}

*Model 4 (trends and state-year vars)*********************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent caid##year caid##statefip c.y##statefip  [pweight=wtsupp] if sample3==1, cluster(statefip) 
lincom visionben_cylag + caid_visionbenlag
}

*Model 5 (full state-by-year interactions)*******************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

**********************************************************************************************************************************************
*PANEL B: FEMALES*********************************************************************************************************************************
************************************************************************************************************************************************

*Model 3 (state trends)************************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip c.y##statefip [pweight=wtsupp] if sample3==1&male==0, cluster(statefip) 
lincom visionben_cylag + caid_visionbenlag
}

*Model 4 (trends and state-year vars)*********************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent caid##year caid##statefip c.y##statefip  [pweight=wtsupp] if sample3==1&male==0, cluster(statefip) 
lincom visionben_cylag + caid_visionbenlag
}

*Model 5 (full state-by-year interactions)*****************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&male==0, cluster(statefip) 
}

*****************************************************************************************************************************************************
*PANEL C: MALES***********************************************************************************************************************************
****************************************************************************************************************************************************
*Model 3 (state trends)************************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip c.y##statefip [pweight=wtsupp] if sample3==1&male==1, cluster(statefip) 
lincom visionben_cylag + caid_visionbenlag
}

*Model 4 (trends and state-year vars)*********************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent caid##year caid##statefip c.y##statefip  [pweight=wtsupp] if sample3==1&male==1, cluster(statefip) 
lincom visionben_cylag + caid_visionbenlag
}

*Model 5 (full state-by-year interactions)*****************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&male==1, cluster(statefip) 
}

*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
*FULLY INTERACTED MODELS****************************************************************************************************************
*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
set matsize 10000
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*Model 3 (state trends)************************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' male##visionben_cylag male##caid_visionbenlag male##c.age male##blacknh male##hispanic male##asianother male##married male##lesshs male##highschool male##citizen_gen male##caid##year male##caid##statefip male##c.y##statefip [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

*Model 4 (trends and state-year vars)*********************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' male##visionben_cylag male##caid_visionbenlag male##c.age male##blacknh male##hispanic male##asianother male##married male##lesshs male##highschool male##citizen_gen male##c.arf_unem male##c.i_arf_pov male##c.pc_i_arf_adultpcp male##c.working_thresh male##workthresh_higher male##c.mng_percent male##caid##year male##caid##statefip male##c.y##statefip  [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

*Model 5***************************************************************************************************************************************************
*Control group, no state-specific trends, Medicaid x state, Medicaid x year, state x year
foreach depvar of local outcomes{
xi: reg `depvar' male##caid_visionbenlag male##c.age male##blacknh male##hispanic male##asianother male##married male##lesshs male##highschool male##citizen_gen male##caid##year male##caid##statefip male##statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip) 
}


************************************************************************************************************************

*TABLE 5
*EVENT STUDY

*************************************************************************************************************************

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

foreach depvar of local outcomes{
xi: reg `depvar' visionlead2plus visionlead1 vision0 visionlag2plus caid_visionlead2plus caid_visionlead1 caid_vision0 caid_visionlag2plus age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip[pweight=wtsupp] if sampleES==1, cluster(statefip)
}

*APPENDIX OR NOT SHOW
**************************************************************************************************************************************
*One additional lag

local outcomes employed_ly loghrsly fulltimeall_ly partimeall_ly fulltime_ly loghrlywage_excl meanoccwage

foreach depvar of local outcomes{
xi: reg `depvar' visionlead2plus visionlead1 vision0 visionlag2 visionlag3plus caid_visionlead2plus caid_visionlead1 caid_vision0 caid_visionlag2 caid_visionlag3plus age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip[pweight=wtsupp] if sampleES==1, cluster(statefip)
}

*************************************************************************************************************************

*SPEC CHECKS 1 (BEFORE OR AFTER EVENT STUDY?)
********************************************************************************************************************
*Original tables 6-9
*Notes: T6 has two spec checks since DD (no control group) is pulled out.
*Notes: T7 reports a placebo test that can be reported in one row using the main reg spec only (model 5)
*T8 gets one row, and T9 gets two rows. (I think she means T9 gets one row and T8 gets two rows)

*ROWS 1 & 2 (OLD TABLE 6)

set more off
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

********************************************************************************************************************************************
*ROW 1: Higher income adults
*********************************************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if samplehigh==1, cluster(statefip) 
}

***********************************************************************************************************************************************
*ROW 2: Low-income, childless adult control group
**********************************************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&(caid==1|ownkids==0), cluster(statefip) 
}

***********************************************************************************************************************************************
*ROWS 3 and 4 (OLD TABLE 8)
****************************************************************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

**********************************************************************************************************************************************
*ROW 3: Including Medicaid expenditures per person
**************************************************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid#c.mcaidexp_pp caid##year caid##statefip statefip##year  [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

*****************************************************************************************************************************************
*ROW 4: Including Medicaid adult dental coverage 
*****************************************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag caid_dentalbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

******************************************************************************************************************************************
*ROW 5 (OLD TABLE 9): Intent to treat
****************************************************************************************************************************************

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*Low educated
foreach depvar of local outcomes{
xi: areg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year [pweight=wtsupp] if sample==1&lesshs==1, cluster(statefip) absorb(statefip)
}

*********************************************************************************************************************************************
*ROW 6 (OLD TABLE 7): geographic neighbors placebo test
********************************************************************************************************************************************

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlaggeo age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
*******************************************************************************************************************
*SPEC CHECKS 2 (BEFORE OR AFTER EVENT STUDY?)
*********************************************************************************************************************
*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
*Also combine Appendix tables 5, 6, 11, 12, 13, and 14 into one or maybe two tables of aditional spec checks - no need to keep repeating the main results
*6/17 - add concurrent vision coverage indicator results

*ROWS  1 and 2 (OLD APPENDIX TABLE 5) - weighting

set more off
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

********************************************************************************************************************************************
*ROW 1 - HINSWT
*******************************************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=hinswt] if sample3==1, cluster(statefip) 
}

****************************************************************************************************************************************
*ROW 2- NO WEIGHTS
****************************************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year if sample3==1, cluster(statefip) 
}

************************************************************************************************************************************
*ROW 3 - CHANGER STATES ONLY (OLD APPENDIX TABLE 6)
************************************************************************************************************************************
gen changer10= 0
replace changer10=1 if fipsst==6|fipsst==12|fipsst==25|fipsst==26|fipsst==29|fipsst==32|fipsst==35|fipsst==41|fipsst==48|fipsst==49

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&changer10==1, cluster(statefip) 
}

***********************************************************************************************************************************
*ROWS 4 and 5 - OUTCOME TRENDS DD and DDD (OLD APPENDIX TABLE 11)
************************************************************************************************************************************
gen changer= 0
replace changer=1 if fipsst==6|fipsst==16|fipsst==26|fipsst==32|fipsst==35|fipsst==37|fipsst==41|fipsst==53

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*ROW 4 - Medicaid only****************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' changer##c.y age blacknh hispanic asianother married male lesshs highschool citizen_gen i.statefip i.year [pweight=wtsupp] if sample3==1&sampletrend==1&caid==1&year<2009, cluster(statefip) 
}

*ROW 5 - Incl. Low-income control group****************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid##changer##c.y age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&sampletrend==1&year<2009, cluster(statefip) 
}

*****************************************************************************************************************************
*ROW 6 - Pre-great-recession (OLD APPENDIX TABLE 13)
****************************************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&year<=2008, cluster(statefip) 
}

*******************************************************************************************************************************
*ROWS 7-8 - LIFTING INCOME RESTRICTIONS (OLD APPENDIX TABLE 14)
*******************************************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage


*ROW 7 - Less than or equal to 400% FPL*****************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample2==1, cluster(statefip) 
}

*ROW 8 - No income restriction**************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample1==1, cluster(statefip) 
}

********************************************************************************************************************************
*ROW 9 - PLACEBO FOR LOW-INCOME CONTROL GROUP (REPLACES OLD APPENDIX TABLE 12)
*********************************************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year [pweight=wtsupp] if sample3==1&caid==0, cluster(statefip) absorb(statefip)
}

*************************************************************************************************************************
*ROW - CONCURRENT VISION COVERAGE INDICATOR
*************************************************************************************************************************
set more off
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionben age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

***********************************************************************************************************************

*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
*APPENDIX
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
************************************************************************************************

*APPENDIX TABLE 1
*DEMOGRAPHICS - NO UPDATES 

************************************************************************************************

set more off

local demos age whitenh blacknh hispanic asianother married male lesshs highschool somecollege_plus citizen_gen caid visionben_cylag visionben_cy

foreach indvar of local demos{
mean `indvar' [pweight=wtsupp] if sample3==1, cluster(statefip)
}
*************************************************************************************
local demos age whitenh blacknh hispanic asianother married male lesshs highschool somecollege_plus citizen_gen visionben_cylag visionben_cy

foreach indvar of local demos{
mean `indvar' [pweight=wtsupp] if sample3==1, cluster(statefip) over(caid)
lincom [`indvar']1 - [`indvar']0
}

**********************************************************************************************************************

*APPENDIX TABLE 2 - COEFFICIENT ESTIMATES - NEEDS UPDATE - from main log file
**************************************************************************************************************

***********************************************************************************************************
*APPENDIX TABLE 3 - BY AGE AND MARITAL STATUS - NEEDS UPDATE
************************************************************************************************************
**************************************************************************************************************************
*SUBGROUP ANALYSIS BY AGE
**************************************************************************************************************************
*****************************************************************************************************************
*AGE
****************************************************************************************************************
*STRATIFIED MODELS

set more off
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

gen age45=0
replace age45=1 if age<45

*Age<45
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age male blacknh hispanic asianother married lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&age45==1, cluster(statefip) 
}

*Age>=45
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age male blacknh hispanic asianother married lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&age45==0, cluster(statefip) 
}

*AGE
*FULLY INTERACTED MODEL

foreach depvar of local outcomes{
xi: reg `depvar' age45##caid_visionbenlag age45##c.age age45##male age45##blacknh age45##hispanic age45##asianother age45##married age45##lesshs age45##highschool age45##citizen_gen age45##caid##year age45##caid##statefip age45##statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip) 
}
*****************************************************************************************************************
*MARITAL STATUS
******************************************************************************************************************
*STRATIFIED MODELS
set more off
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

*Married
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age male blacknh hispanic asianother lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&married==1, cluster(statefip) 
}

*Not Married
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age male blacknh hispanic asianother lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&married==0, cluster(statefip) 
}

*MARITAL STATUS
*FULLY INTERACTED MODEL
local outcomes loghrsall1

*local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag##married c.age##married male##married blacknh##married hispanic##married asianother##married lesshs##married highschool##married citizen_gen##married caid##year##married caid##statefip##married statefip##year##married [pweight=wtsupp] if sample3==1, cluster(statefip) 
}


***********************************************************************************************************
*APPENDIX TABLE 4 - BY OCC CAT - NO UPDATE
***********************************************************************************************************
local outcomes loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*Managerial and professional specialty occupations********************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&managprof==1, cluster(statefip) 
}

*Technical, sales and administrative support occupations******************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&techadmin==1, cluster(statefip) 
}

*Service occupations*************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&service==1, cluster(statefip) 
}
*Farming, forestry, and fishing occupations**************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&farmfish==1, cluster(statefip) 
}
*Precision production, craft, and repair occupations**************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&craft==1, cluster(statefip) 
}
*Operators, fabricators, and laborers**************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&operatlab==1, cluster(statefip) 
}
*Driving (subset of operators, fabricators, laborers)
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&driveocc==1, cluster(statefip) 
}
*Any transportation (subset of operators, fabricators, and laborers)
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&transportocc==1, cluster(statefip) 
}

**************************************************************************************************************
*APPENDIX TABLE 5 - OCC SWITCHING - NO UPDATE
************************************************************************************************************
local outcomes managprof techadmin service farmfish craft operatlab driveocc transportocc
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip)
}
****************************************************************************************************************
*APPENIX TABLE 6 - ACS COMMUTE VARS - NO UPDATE
****************************************************************************************************************
use micro_caid
*ONLY AVAILABLE 2008-2013

rename statefip fipsst

run create_vision_CPS_113016.do
gen logcomtime = log(comtime) 

local outcomes fulltime_all fulltime_vpt car comtime logcomtime secondshift earlydepart anynight secondshift_car earlydepart_car anynight_car

*****************************************************************************************************
*No state x year
*****************************************************************************************************8
foreach depvar of local outcomes{
reg `depvar' visionben_cy##mcaid female age fipsst##mcaid year##mcaid [pweight=perwt], cluster(fipsst)
}

*****************************************************************************************************
*Including state x year
****************************************************************************************************
foreach depvar of local outcomes{
reg `depvar' visionben_cy##mcaid female age fipsst##mcaid year##mcaid fipsst##year [pweight=perwt], cluster(fipsst)
}





************************************************************************************************************************

*APPENDIX TABLE 6
*Results by age and marital status

***********************************************************************************************************************
*AGE
*STRATIFIED MODELS

set more off
local outcomes employed_ly loghrsly fulltimeall_ly partimeall_ly fulltime_ly loghrlywage_excl meanoccwage

gen age35=0
replace age35=1 if age<35

*Age<35
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age male blacknh hispanic asianother married lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&age35==1, cluster(statefip) 
}

*Age>=35
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age male blacknh hispanic asianother married lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&age35==0, cluster(statefip) 
}

*AGE
*FULLY INTERACTED MODEL

foreach depvar of local outcomes{
xi: reg `depvar' age35##caid_visionbenlag age35##c.age age35##male age35##blacknh age35##hispanic age35##asianother age35##married age35##lesshs age35##highschool age35##citizen_gen age35##caid##year age35##caid##statefip age35##statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip) 
}


*********************************************************************************************************************************








*****************************************************************************************************************************************

*FIGURE 2

*************************************************************************************************************************************

*Plot percentage with vision coverage (cy) over time 
*gen year_cy = year-1

*preserve

*set scheme s2mono

*collapse visionben_cy [pweight=wtsupp] if sample3==1&caid==1, by(year_cy)
*replace visionben_cy = visionben_cy*100

*twoway (connected visionben_cy year_cy), xlabel(2001(1)2012, angle(45)) xtitle(Calendar year) ytitle(Percentage with vision coverage, size(medsmall)) legend(off) yscale(range(0(10)100)) ylabel(0(10)100, labsize(medsmall) nogrid)





