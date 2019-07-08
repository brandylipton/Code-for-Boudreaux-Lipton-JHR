*Clean CPS IPUMS data for results in Boudreaux and Lipton 

*Set directory to where CPS data are stored, use 2002-2013 ASEC 

*use cps_0213

*Generate demographic controls
gen male = 1 if sex==1
replace male=0 if sex==2

gen married =1 if marst==1|marst==2|marst==3
replace married=0 if marst==4|marst==5|marst==6|marst==7

gen citizen_gen = 1 if citizen==9|citizen==1|citizen==2|citizen==0
replace citizen_gen=0 if citizen==3

*Race/ethnicity
gen whitenh=0
replace whitenh = 1 if race==100&hispan==0
replace whitenh=. if hispan==901|hispan==902|race==999

gen blacknh=0
replace blacknh=1 if race==200&hispan==0
replace blacknh=. if hispan==901|hispan==902|race==999

gen hispanic=0 if hispan==0
replace hispanic=1 if hispan>=100&hispan<901

gen asianother = 0
replace asianother=1 if race>=300&race<999&hispan==0

*Education
gen lesshs=0
replace lesshs=1 if educ>=2&educ<=71
replace lesshs=. if educ==72
replace lesshs=. if educ==999

gen highschool=0
replace highschool=1 if educ==73
replace highschool=. if educ==72|educ==999

gen somecollege_plus = 0
replace somecollege_plus=1 if educ>=80&educ<=125
replace somecollege_plus=. if educ==999

*Insurance status
gen caid=0 if himcaid==1
replace caid=1 if himcaid==2

gen care=0 if himcare==1
replace care=1 if himcare==2

gen private=0 if coverpi==1
replace private=1 if coverpi==2

gen milinsure=0 if hichamp==1
replace milinsure=1 if hichamp==2

*Own children in house

gen ownkids=0 if nchild==0
replace ownkids=1 if nchild>=1

*Family income as percentage FPL

gen famincom = offtotval
replace famincom=. if famincom==999999 

gen povthresh = offcutoff
replace povthresh=. if offcutoff==999999

gen ratiopov = famincom/povthresh
replace ratiopov=0 if ratiopov<0
replace ratiopov=ratiopov*100

*yearly time trend
gen y = 1 if year==2002
replace y=2 if year==2003
replace y=3 if year==2004
replace y=4 if year==2005
replace y=5 if year==2006
replace y=6 if year==2007
replace y=7 if year==2008
replace y=8 if year==2009
replace y=9 if year==2010
replace y=10 if year==2011
replace y=11 if year==2012
replace y=12 if year==2013

*Outcome variables

*Past week employment
gen employed = 1 if empstat==1|empstat==10|empstat==12
replace employed=0 if empstat>=20

*Past calendar year reference period

*Employed at least one week last year********************************
gen employed_ly = 1 if wkswork1>0
replace employed_ly=0 if wkswork1==0

gen usualhrs_ly = uhrsworkly if uhrsworkly<999

*This is variable used in main analysis and is not defined for those without any past-year employment
gen loghrsly = log(usualhrs_ly)

*Allow analysis of log hours for those who did not work in the past year by adding one to all zero-hour observations
gen usualhrs_all1 = usualhrs_ly
replace usualhrs_all1=1 if employed_ly==0

gen loghrsall1 = log(usualhrs_all1)

*Employed only
gen fulltime_ly=1 if fullpart==1
replace fulltime_ly=0 if fullpart==2

*Weeks employed if employed at least one week
gen wkswork_ly = wkswork1 if wkswork1>0

*Firm size (categorical)
gen firmsize100plus = 0 if firmsize>=1&firmsize<=6
replace firmsize100plus=1 if firmsize==7|firmsize==8|firmsize==9

gen firmsize500plus=0 if firmsize>=1&firmsize<=7
replace firmsize500plus=1 if firmsize==8|firmsize==9

*********************************************************************************
*Adjust wage/salary to 1999 dollars

gen wage_cpi99 = incwage*cpi99
replace wage_cpi99=. if incwage>9999998

gen logearnings = log(wage_cpi99) if wage_cpi99>0

gen tothrs = wkswork_ly*usualhrs_ly

gen hrlywage = wage_cpi99/tothrs

gen loghrlywage = log(hrlywage) if hrlywage>0

*Unadjusted hourly wage 
gen unadj_hrlywage = incwage/tothrs
replace unadj_hrlywage =. if incwage>9999998

*Indicator for computed hourly wage under fed min wage for tipped workers ($2.13 for whole period)
gen under_wagetip = 1 if unadj_hrlywage<2.13
replace under_wagetip=0 if unadj_hrlywage>=2.13&unadj_hrlywage<.

gen hrlywage_excl = hrlywage
replace hrlywage_excl = . if under_wagetip==1

*Exclude observations that are below the federal min wage for tipped workers, this is outcome used in analysis
gen loghrlywage_excl = loghrlywage
replace loghrlywage_excl=. if under_wagetip==1
*The federal minimum wage for tipped employees for our full period was $2.13
*only about 5 k of 200 k worker observations are below this level.

********************************************************************************************
*Major occupation categories, based on occ90ly
********************************************************************************************
gen managprof = 1 if occ90ly<=200
replace managprof=0 if occ90ly>200&occ90ly<991

gen techadmin = 1 if occ90ly>=201&occ90ly<=400
replace techadmin=0 if occ90ly<201|(occ90ly>400&occ90ly<991)

gen service=1 if occ90ly>400&occ90ly<=470
replace service=0 if occ90ly<=400|(occ90ly>470&occ90ly<991)

gen farmfish =1 if occ90ly>470&occ90ly<=500
replace farmfish=0 if occ90ly<470|(occ90ly>500&occ90ly<991)

gen craft=1 if occ90ly>=501&occ90ly<=700
replace craft=0 if occ90ly<501|(occ90ly>700&occ90ly<991)

gen operatlab = 1 if occ90ly>=701&occ90ly<=900
replace operatlab=0 if occ90ly<701

gen driveocc = 1 if occ90ly>=803&occ90ly<=815
replace driveocc=0 if occ90ly<803|(occ90ly>815&occ90ly<991)

gen transportocc=1 if occ90ly>=803&occ90ly<=865
replace transportocc=0 if occ90ly<803|(occ90ly>865&occ90ly<991)

********************************************************************************************************

*Generate mean log wage of workers in non-farm occupations

********************************************************************************************************

gen occat = occ1990
replace occat=. if occ1990>=991
*Do not rank for farming
replace occat=. if occ1990>470&occ1990<=500

bysort occat: egen numocc = count(occat)

*Exclude categories with fewer than 100 observations in the whole dataset. 
replace occat=. if numocc<100

*To get weighted mean log occupation wages, collapse by occupation category, use current or last held occupation in main analysis

preserve

collapse (mean) loghrlywage if age>=16&age<=64&popstat==1 [pweight=wtsupp], by(occat)

rename loghrlywage meanoccwage
save meanoccwage, replace

restore

merge m:1 occat using meanoccwage

rename _merge mergemeanocc

replace meanoccwage=. if employed_ly==0&employed==0
replace meanoccwage=. if occat==.

*********************************************************************************
*GENERATE ANALYSIS SAMPLES
**********************************************************************************

*Base Sample
gen sample=0
replace sample=1 if age>=22&age<=64
*No medicare
replace sample=0 if care==1
*Limit to adult civilian
replace sample=0 if popstat~=1
replace sample=0 if wtsupp==0|wtsupp==.
replace sample=0 if age==.|male==.|lesshs==.|highschool==.|married==.|whitenh==.|blacknh==.|hispanic==.|asianother==.
*add SSI exclusion to main sample
replace sample=0 if incssi>0

*Additional exclusion - no second source of insurance
gen sample1 = sample
replace sample1=0 if caid==1&private==1
replace sample1=0 if caid==1&milinsure==1

*Additional exclusion - all must be less than or equal 400 FPL, incl. reported Medicaid benes.
gen sample2=sample1
replace sample2=0 if ratiopov>400

*Less than or equal to 200 FPL - MAIN ANALYSIS SAMPLE
gen sample3=sample1
replace sample3=0 if ratiopov>200

*Also exclude people with implied wages below the minimum for tipped employees
*Test whether excluding these people makes a difference for non-wage results
gen sample4=sample3
replace sample4=0 if under_wagetip==1

*higher income sample for control group robustness check
gen samplehigh=0
replace samplehigh=1 if age>=22&age<=64
replace samplehigh=0 if care==1
replace samplehigh=0 if incssi>0
replace samplehigh=0 if caid~=1&ratiopov<300|ratiopov>400
replace samplehigh=0 if caid==1&ratiopov>200
*Limit to adult civilian
replace samplehigh=0 if popstat~=1
replace samplehigh=0 if wtsupp==0|wtsupp==.
replace samplehigh=0 if year>2013
replace samplehigh=0 if age==.|male==.|lesshs==.|highschool==.|married==.|whitenh==.|blacknh==.|hispanic==.|asianother==.
replace samplehigh=0 if caid==1&private==1
replace samplehigh=0 if caid==1&milinsure==1

gen fipsst = statefip

*SAMPLE FOR TREND ANALYSIS
gen sampletrend = 0
*Always cover states
replace sampletrend=1 if fipsst==1|fipsst==2|fipsst==5|fipsst==9|fipsst==11|fipsst==15|fipsst==17|fipsst==18|fipsst==19|fipsst==27|fipsst==28|fipsst==31|fipsst==33|fipsst==34|fipsst==36|fipsst==38|fipsst==39|fipsst==44|fipsst==46|fipsst==55
*Never cover states
replace sampletrend=1 if fipsst==4|fipsst==8|fipsst==10|fipsst==13|fipsst==21|fipsst==22|fipsst==24|fipsst==23|fipsst==30|fipsst==40|fipsst==42|fipsst==45|fipsst==47|fipsst==50|fipsst==51|fipsst==54|fipsst==56
*AZ, CO, DE, GA, KY, LA, MD, ME, MT, OK, PA, SC, TN, VT, VA, WV, and WY
*Changer states that didn't change until after July 2008
*CA, ID, MI, NV, NM, NC, OR, and WA (8)
replace sampletrend=1 if fipsst==6|fipsst==16|fipsst==26|fipsst==32|fipsst==35|fipsst==37|fipsst==41|fipsst==53

*External policy variable controls********************************************************

*Compute total number adult benes by state and year to get Medicaid expenditures per person
gen sampleenroll=0
replace sampleenroll=1 if age>=19&age<=64
replace sampleenroll=0 if caid~=1
replace sampleenroll=0 if wtsupp==0|wtsupp==.
*Exclude ssi payments because spending does not include disabled category.
replace sampleenroll=0 if incssi>0
replace sampleenroll=0 if year>2013
replace sampleenroll=0 if care==1

bysort statefip year: egen mcaidenroll = total(wtsupp*(sampleenroll==1))
replace mcaidenroll=. if mcaidenroll==0

*create vision and dental coverage indicators, and geographic placebo test
run Boudreaux_Lipton_JHR_vision_dental_vars

*visionben_cy equals one if coverage for at least 6 months of calendar year prior to interview year
*visionben_cylag equals one if coverage for at least 6 months of lagged calendar year

gen caid_visionben = caid*visionben_cy

gen caid_visionbenlag = caid*visionben_cylag

gen caid_dentalbenlag = caid*dentalben_cylag

gen caid_visionbenlaggeo = caid*visionbenlag_geo

*Merge external policy data with CPS*************************************************

*Merge lagged one year, to be consisent with main vision policy variable. 
gen year_merge1 = year - 2

*Merge in eligigibility thresholds for working and non-working parents, ARF variables, Medicaid managed care penetration, and Medicaid expenditures 
*The eligibility threshold for unemployed individuals is missing in CPS years 2002 and 2004, MC penetration is mising in CPS year 2002
*Medicaid expenditures are missing in CPS years 2002-2005.

sort fipsst year_merge1

merge m:1 fipsst year_merge1 using Boudreaux_Lipton_JHR_policyvars

gen workthresh_higher = 1 if working_thresh>notworking_thresh
replace workthresh_higher=0 if working_thresh==notworking_thresh
replace workthresh_higher=. if notworking_thresh==.

*Scale total expenditures by number of adult enrollees computed in CPS
*Use linear imputed because several states missing in 2012 
*Expenditures inflated to 2012 dollars
gen mcaidexp_pp = imputed_inflated_exp/mcaidenroll

rename _merge _mergepolicyvars

***************************************************************************************************
*CODE TO SET UP EVENT STUDY
****************************************************************************************************

*Year before policy change
gen visionlead1 = 0
replace visionlead1=1 if fipsst==6&year==2010
replace visionlead1=1 if fipsst==16&year==2012
replace visionlead1=1 if fipsst==26&year==2009
replace visionlead1=1 if fipsst==35&year==2010
replace visionlead1=1 if fipsst==37&year==2012
replace visionlead1=1 if fipsst==41&year==2010
replace visionlead1=1 if fipsst==53&year==2012
replace visionlead1=1 if fipsst==25&year==2003
replace visionlead1=1 if fipsst==12&year==2004
replace visionlead1=-1 if fipsst==29&year==2003
replace visionlead1=1 if fipsst==49&year==2003
replace visionlead1=1 if fipsst==48&year==2005

*2 years before policy change
gen visionlead2=0
replace visionlead2=1 if fipsst==6&year==2009
replace visionlead2=1 if fipsst==16&year==2011
replace visionlead2=1 if fipsst==26&year==2008
replace visionlead2=1 if fipsst==35&year==2009
replace visionlead2=1 if fipsst==37&year==2011
replace visionlead2=1 if fipsst==41&year==2009
replace visionlead2=1 if fipsst==53&year==2011
replace visionlead2=1 if fipsst==25&year==2002
replace visionlead2=1 if fipsst==12&year==2003
replace visionlead2=-1 if fipsst==29&year==2002
replace visionlead2=1 if fipsst==49&year==2002
replace visionlead2=1 if fipsst==48&year==2004

*3 or more years before policy change
gen visionlead3plus=0
replace visionlead3plus=1 if fipsst==6&year<=2008
replace visionlead3plus=1 if fipsst==16&year<=2010
replace visionlead3plus=1 if fipsst==26&year<=2007
replace visionlead3plus=1 if fipsst==35&year<=2008
replace visionlead3plus=1 if fipsst==37&year<=2010
replace visionlead3plus=1 if fipsst==41&year<=2008
replace visionlead3plus=1 if fipsst==53&year<=2010
replace visionlead3plus=1 if fipsst==12&year==2002
replace visionlead3plus=1 if fipsst==48&year<=2003

*Year of policy change = reference category

*This is the one year lag of policy change, equivalent to defn used in paper.
gen visionlag1plus=0
replace visionlag1plus=1 if fipsst==6&year>=2012
replace visionlag1plus=1 if fipsst==26&year>=2011
replace visionlag1plus=1 if fipsst==35&year>=2012
replace visionlag1plus=1 if fipsst==41&year>=2012
replace visionlag1plus=1 if fipsst==25&year>=2005
replace visionlag1plus=1 if fipsst==12&year>=2006
replace visionlag1plus=-1 if fipsst==29&year>=2005
replace visionlag1plus=1 if fipsst==49&year>=2005
replace visionlag1plus=1 if fipsst==48&year>=2007

*Only include multi-change states up until the second change.
gen sampleES = sample3
*Exclude MI after they add coverage in 10/2012.
replace sampleES=0 if fipsst==26&year==2013
*Exclude MA after add coverage in October 2006
replace sampleES=0 if fipsst==25&year>=2007
*Exclude FL after add coverage in July 2006
replace sampleES=0 if fipsst==12&year>=2007
*Exclude MO after drop in July 2005
replace sampleES=0 if fipsst==29&year>=2006
*Exclude UT after add in July 2005
replace sampleES=0 if fipsst==49&year>=2006
*Exclude TX after add in September 2006
replace sampleES=0 if fipsst==48&year>=2007
*replace sampleES= 0 if fipsst==20|fipsst==25|fipsst==12|fipsst==29|fipsst==32|fipsst==49|fipsst==48

*Interactions between Medicaid status and leads and lags
gen caid_visionlead3plus = caid*visionlead3plus
gen caid_visionlead2 = caid*visionlead2
gen caid_visionlead1 = caid*visionlead1
gen caid_visionlag1plus = caid*visionlag1plus
