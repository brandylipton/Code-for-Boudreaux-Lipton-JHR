*Code to create tables and figures for "Medicaid Benefit Generosity and 
*Labor Market Outcomes: Evidence from Medicaid Adult Vision Benefits" after running "Boudreaux Lipton JHR Clean Data"

*set matsize 10000

***********************************************************************************************************

*TABLE 1
*Regression estimates of the association between vision coverage and participation in Medicaid, CPS 2002-2013

**********************************************************************************************************

*Column 1
xi: areg caid visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year [pweight=wtsupp] if sample3==1, cluster(statefip) absorb(statefip)

*Column 2
xi: reg caid visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year c.y##statefip [pweight=wtsupp] if sample3==1, cluster(statefip) 

*Column 3
xi: areg caid visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent i.year [pweight=wtsupp] if sample3==1, cluster(statefip) absorb(statefip)

*Column 4
xi: reg caid visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent i.year c.y##statefip [pweight=wtsupp] if sample3==1, cluster(statefip)

*****************************************************************************************************
*Table 2
*Regression estimates of the association between vision benefits and sample composition, CPS 2002-2013

***************************************************************************************************

local demos age whitenh blacknh hispanic asianother married male lesshs highschool somecollege_plus citizen_gen 

*Column 1 - Full Sample
foreach indvar of local demos{
xi: reg `indvar' caid_visionbenlag caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

*Column 2 - Employed sample
foreach indvar of local demos{
xi: reg `indvar' caid_visionbenlag caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&employed_ly==1, cluster(statefip) 
}

**************************************************************************************************************

*TABLE 3
*Difference-in-differences estimates of the effect of vision coverage on employment otcomes of Medicaid enrollees, 
*CPS 2002-203
****************************************************************************************************************

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*****************************************************************************************************
*PANEL A - FULL SAMPLE
***************************************************************************************************

*Row 1 - No state-specific trends
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year [pweight=wtsupp] if sample3==1&caid==1, cluster(statefip) absorb(statefip)
}

*Row 2 - State-specific trends
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year c.y##statefip [pweight=wtsupp] if sample3==1&caid==1, cluster(statefip) absorb(statefip)
}

*************************************************************************************************************
*PANEL B - FEMALES ONLY
**********************************************************************************************************

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*Row 1 - No state-specific trends
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year [pweight=wtsupp] if sample3==1&caid==1&male==0, cluster(statefip) absorb(statefip)
}

*Row 2 - State-specific trends
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year c.y##statefip [pweight=wtsupp] if sample3==1&caid==1&male==0, cluster(statefip) 
}

******************************************************************************************************
*PANEL C - MALES ONLY
********************************************************************************************************

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*Row 1 - No state-specific trends
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year [pweight=wtsupp] if sample3==1&caid==1&male==1, cluster(statefip) absorb(statefip)
}

*Row 2 - State-specific trends
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year c.y##statefip [pweight=wtsupp] if sample3==1&caid==1&male==1, cluster(statefip) 
}

*TEST FOR MALE-FEMALE DIFFERENCES*******************************************************************

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*No state-specific trends
foreach depvar of local outcomes{
xi: reg `depvar' male##visionben_cylag male##c.age male##blacknh male##hispanic male##asianother male##married male##lesshs male##highschool male##citizen_gen male##year male##statefip [pweight=wtsupp] if sample3==1&caid==1, cluster(statefip) 
}

*State-specific trends
foreach depvar of local outcomes{
xi: reg `depvar' male##visionben_cylag male##c.age male##blacknh male##hispanic male##asianother male##married male##lesshs male##highschool male##citizen_gen male##year male##statefip male##c.y##statefip [pweight=wtsupp] if sample3==1&caid==1, cluster(statefip) 
}

********************************************************************************************
*PANEL D - Placebo Test
********************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year [pweight=wtsupp] if sample3==1&caid==0, cluster(statefip) absorb(statefip)
}

*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
*MEANS for Panels A, B, and C
*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*FULL MEDICAID SAMPLE MEANS*************************************************
foreach depvar of local outcomes{
mean `depvar' [pweight=wtsupp] if sample3==1&caid==1, cluster(statefip)
}
*FEMALE MEANS******************************************************************
foreach depvar of local outcomes{
mean `depvar' [pweight=wtsupp] if sample3==1&caid==1&male==0, cluster(statefip)
}

*MALE MEANS*******************************************************************
foreach depvar of local outcomes{
mean `depvar' [pweight=wtsupp] if sample3==1&caid==1&male==1, cluster(statefip)
}

*******************************************************************************************************
*TABLE 4
*Triple difference estimates of the effect of Medicaid adult vision benefits on employment outcomes, CPS 2002-2013

***************************************************************************************************************
set more off

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*****************************************************************************************************
*PANEL A - FULL SAMPLE
********************************************************************************************************

*Row 1 (state trends)**********************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip c.y##statefip [pweight=wtsupp] if sample3==1, cluster(statefip) 
lincom visionben_cylag + caid_visionbenlag
}

*Row 2 (trends and state-year vars)*********************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent caid##year caid##statefip c.y##statefip  [pweight=wtsupp] if sample3==1, cluster(statefip) 
lincom visionben_cylag + caid_visionbenlag
}

*Row 3 (full state-by-year interactions)*******************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

**********************************************************************************************************************************************
*PANEL B: FEMALES*********************************************************************************************************************************
************************************************************************************************************************************************

*Row 1 (state trends)************************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip c.y##statefip [pweight=wtsupp] if sample3==1&male==0, cluster(statefip) 
lincom visionben_cylag + caid_visionbenlag
}

*Row 2 (trends and state-year vars)*********************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent caid##year caid##statefip c.y##statefip  [pweight=wtsupp] if sample3==1&male==0, cluster(statefip) 
lincom visionben_cylag + caid_visionbenlag
}

*Row 3 (full state-by-year interactions)*****************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&male==0, cluster(statefip) 
}

*****************************************************************************************************************************************************
*PANEL C: MALES***********************************************************************************************************************************
****************************************************************************************************************************************************

*Row 1 (state trends)************************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip c.y##statefip [pweight=wtsupp] if sample3==1&male==1, cluster(statefip) 
lincom visionben_cylag + caid_visionbenlag
}

*Row 2 (trends and state-year vars)*********************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' visionben_cylag caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen arf_unem i_arf_pov pc_i_arf_adultpcp working_thresh workthresh_higher mng_percent caid##year caid##statefip c.y##statefip  [pweight=wtsupp] if sample3==1&male==1, cluster(statefip) 
lincom visionben_cylag + caid_visionbenlag
}

*Row 3 (full state-by-year interactions)*****************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&male==1, cluster(statefip) 
}

*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
*Test Female/male differences, FULLY INTERACTED MODELS****************************************************************************************************************
*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
set matsize 10000
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*Row 1 (state trends)************************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' male##visionben_cylag male##caid_visionbenlag male##c.age male##blacknh male##hispanic male##asianother male##married male##lesshs male##highschool male##citizen_gen male##caid##year male##caid##statefip male##c.y##statefip [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

*Row 2 (trends and state-year vars)*********************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' male##visionben_cylag male##caid_visionbenlag male##c.age male##blacknh male##hispanic male##asianother male##married male##lesshs male##highschool male##citizen_gen male##c.arf_unem male##c.i_arf_pov male##c.pc_i_arf_adultpcp male##c.working_thresh male##workthresh_higher male##c.mng_percent male##caid##year male##caid##statefip male##c.y##statefip  [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

*Row 3 (full state-by-year interactions)***************************************************************************************************************************************************
foreach depvar of local outcomes{
xi: reg `depvar' male##caid_visionbenlag male##c.age male##blacknh male##hispanic male##asianother male##married male##lesshs male##highschool male##citizen_gen male##caid##year male##caid##statefip male##statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

****************************************************************************************************
*MEANS FOR PANELS A, B, and C
*****************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

*FULL SAMPLE*************************************************************************
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

************************************************************************************************************************

*TABLE 5
*Event study estimates of the effect of Medicaid adult vision benefits on employment outcomes, CPS 2002-2013

*************************************************************************************************************************

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

foreach depvar of local outcomes{
xi: reg `depvar' visionlead3plus visionlead2 visionlead1 visionlag1plus caid_visionlead3plus caid_visionlead2 caid_visionlead1 caid_visionlag1plus age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip[pweight=wtsupp] if sampleES==1, cluster(statefip)
}

*************************************************************************************************************************

*TABLE 6 - Robustness and specification checks of triple difference models, CPS 2002-2013
********************************************************************************************************************

*ROWS 1 & 2 - Alternative control groups for triple difference estimates

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

***********************************************************************************************************************
*ROW 3 - Placebo check: Geographic neighbors
***********************************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlaggeo age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

************************************************************************************************************************
*ROW 4 - Restrict analysis period 2001-2007
************************************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&year<=2008, cluster(statefip) 
}

**************************************************************************************************************
*ROW 5 - Control for Medicaid expenditures per person
****************************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid#c.mcaidexp_pp caid##year caid##statefip statefip##year  [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

*********************************************************************************************************************
*ROW 6 - Control for Medicaid adult dental coverage
*******************************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag caid_dentalbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip) 
}
***************************************************************************************************************
*ROW 7 - Intent-to-treat difference-in-differences, low educated sample
*****************************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

foreach depvar of local outcomes{
xi: areg `depvar' visionben_cylag age blacknh hispanic asianother married male lesshs highschool citizen_gen i.year [pweight=wtsupp] if sample==1&lesshs==1, cluster(statefip) absorb(statefip)
}

******************************************************************************************************************
*ROW 8 - Sample restricted to income less than 400% FPL
*****************************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample2==1, cluster(statefip) 
}
***************************************************************************************************************
*ROW 9 - No sample income restriction
***************************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample1==1, cluster(statefip) 
}

*********************************************************************************************************

* END OF MAIN PAPER TABLES

************************************************************************************************************

*Figure 1 - Timeline of changes to Medicaid adult vision coverage
*Created by authors from Kaiser Family Foundation reports and other sources - see article for more details
***********************************************************************************************************

******************************************************************************************************
*Figure 2 - Percentage of Medicaid enrollees with vision coverage for at least six months of the calendar year, 
*with US recession bars, CPS 2002-2013
*******************************************************************************************************
gen year_cy = year-1

preserve

set scheme s2mono

collapse visionben_cy [pweight=wtsupp] if sample3==1&caid==1, by(year_cy)
replace visionben_cy = visionben_cy*100

twoway (connected visionben_cy year_cy), xlabel(2001(1)2012, angle(45)) xtitle(Calendar year) ytitle(Percentage with vision coverage, size(medsmall)) legend(off) yscale(range(0(10)100)) ylabel(0(10)100, labsize(medsmall) nogrid)

restore

***********************************************************************************************************
*APPENDIX TABLE 1 - Weighted Sample Characteristics, CPS 2002-2013
**********************************************************************************************************
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
***********************************************************************************************************
*APPENDIX TABLE 2 - Coefficient Estimates for Key Explanatory Variables, Triple Difference
* SEE ESTIMATES FOR MAIN ARTICLE TABLE 4, PANEL A, ROW 3
*************************************************************************************************************

***********************************************************************************************************
*APPENDIX TABLE 3 - Triple Difference Results by Age and Marital Status, CPS 2002-2013
*********************************************************************************************************
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

*FULLY INTERACTED MODEL
local outcomes loghrsall1

*local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag##married c.age##married male##married blacknh##married hispanic##married asianother##married lesshs##married highschool##married citizen_gen##married caid##year##married caid##statefip##married statefip##year##married [pweight=wtsupp] if sample3==1, cluster(statefip) 
}

**********************************************************************************************************
*APPENDIX TABLE 4 - Triple Difference Results within Major Occupation Categories, Full Time Vs. Part Time Work,
*CPS 2002-2013
***********************************************************************************************************

*Managerial and professional specialty occupations********************************************************************
xi: reg fulltime_ly caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&managprof==1, cluster(statefip) 

*Technical, sales and administrative support occupations******************************************************************
xi: reg fulltime_ly caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&techadmin==1, cluster(statefip) 

*Service occupations*************************************************************************************************
xi: reg fulltime_ly caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&service==1, cluster(statefip) 

*Precision production, craft, and repair occupations**************************************************************
xi: reg fulltime_ly caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&craft==1, cluster(statefip) 

*Operators, fabricators, and laborers**************************************************************************
xi: reg fulltime_ly caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&operatlab==1, cluster(statefip) 

*Driving (subset of operators, fabricators, laborers)
xi: reg fulltime_ly caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&driveocc==1, cluster(statefip) 

*Any transportation (subset of operators, fabricators, and laborers)
xi: reg fulltime_ly caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&transportocc==1, cluster(statefip) 


***********************************************************************************************************
*APPENDIX TABLE 5 - Triple Difference Estimates of the Effect of Vision Coverage on Occupational Category 
*Switching, CPS 2002-2013
*********************************************************************************************************

local outcomes managprof techadmin service farmfish craft operatlab driveocc transportocc
foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1, cluster(statefip)
}

***************************************************************************************************************
*APPENDIX TABLE 7 - Additional Specification Checks, CPS 2002-2013
***************************************************************************************************************
********************************************************************************************
*ROW 1 - Alternative sample weights
*************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=hinswt] if sample3==1, cluster(statefip) 
}
**************************************************************************************************
*ROW 2 - No sample weights
*************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year if sample3==1, cluster(statefip) 
}
**************************************************************************************************
*ROW 3 - Changer states only
****************************************************************************************************
gen changer10= 0
replace changer10=1 if fipsst==6|fipsst==12|fipsst==25|fipsst==26|fipsst==29|fipsst==32|fipsst==35|fipsst==41|fipsst==48|fipsst==49

local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage 

foreach depvar of local outcomes{
xi: reg `depvar' caid_visionbenlag age blacknh hispanic asianother married male lesshs highschool citizen_gen caid##year caid##statefip statefip##year [pweight=wtsupp] if sample3==1&changer10==1, cluster(statefip) 
}
*****************************************************************************************************
*ROWS 4 and 5 - Outcome trends
*********************************************************************************************************
local outcomes employed_ly loghrsall1 loghrsly fulltime_ly loghrlywage_excl meanoccwage

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

*************************************************************************************************************
*APPENDIX TABLE 6 - Triple Difference Estimates of the Effect of Vision Coverage on Transportation and Commuting
*Variables, ACS 2008-2013
***************************************************************************************************************

*NOTE: SWITCH TO 2008-2013 ACS DATA 


rename statefip fipsst

*Define outcomes - commute by car or motorcycle vs. other modes, commute time (log), depart after 4 pm, depart before 5 am, depart either after 4 pm or before 5 am

*Controls include sex and age. Limit to people with incomes under 200% FPL. Use sampling weigthts (perwt) and cluster errors by state. See code below.

run Boudreaux_Lipton_JHR_vision_dental_vars.do
gen logcomtime = log(comtime) 

local outcomes car comtime logcomtime secondshift earlydepart anynight 
*Note: year is time of interview in ACS rather than one year post as in CPS, so this aligns with lagged vision coverage policies.
foreach depvar of local outcomes{
reg `depvar' visionben_cy##mcaid female age fipsst##mcaid year##mcaid fipsst##year [pweight=perwt], cluster(fipsst)
}

