*VISION COVERAGE INDICATOR
*Consider coverage by calendar year - at least 6 months of calendar year.

gen visionben_cy=0
*Always cover states
*AL, AK, AR, CT, DC, HI, IL, IN, IA, MN, MS, NE, NH, NJ, NY, ND, OH, RI, SD, WI
replace visionben_cy=1 if fipsst==1|fipsst==2|fipsst==5|fipsst==9|fipsst==11|fipsst==15|fipsst==17|fipsst==18|fipsst==19|fipsst==27|fipsst==28|fipsst==31|fipsst==33|fipsst==34|fipsst==36|fipsst==38|fipsst==39|fipsst==44|fipsst==46|fipsst==55

*Never cover states 
*AZ, CO, DE, GA, KY, LA, MD, ME, MT, OK, PA, SC, TN, VT, VA, WV, and 

gen visionben_cylag=0
replace visionben_cylag=1 if fipsst==1|fipsst==2|fipsst==5|fipsst==9|fipsst==11|fipsst==15|fipsst==17|fipsst==18|fipsst==19|fipsst==27|fipsst==28|fipsst==31|fipsst==33|fipsst==34|fipsst==36|fipsst==38|fipsst==39|fipsst==44|fipsst==46|fipsst==55

*CA dropped vision 7/1/2009
replace visionben_cy=1 if fipsst==6&year<=2010
replace visionben_cylag=1 if fipsst==6&year<=2011

*KS dropped vision 1/1/2003 and restored 7/1/2003
replace visionben_cy=1 if fipsst==20
replace visionben_cylag=1 if fipsst==20

*MA dropped vision 10/1/2002 added vision 10/1/2006
replace visionben_cy=1 if fipsst==25&(year<=2003|year>=2008)
replace visionben_cylag=1 if fipsst==25&(year<=2004|year>=2009)

*MI dropped coverage 10/1/2008 and added 10/1/2012
replace visionben_cy=1 if fipsst==26&year<=2009
replace visionben_cylag=1 if fipsst==26&year<=2010

*FL dropped 7/1/2003 added vision 7/1/2006
replace visionben_cy=1 if fipsst==12&year<=2004
replace visionben_cy=1 if fipsst==12&year>=2007
replace visionben_cylag=1 if fipsst==12&year<=2005
replace visionben_cylag=1 if fipsst==12&year>=2008

*MO added 7/1/2003, dropped 7/1/2005, added vision 7/1/2006
replace visionben_cy=1 if fipsst==29&year>=2004
replace visionben_cylag=1 if fipsst==29&year>=2005

*NV dropped 7/1/2008 and added 7/1/2009
replace visionben_cy=1 if fipsst==32
replace visionben_cylag=1 if fipsst==32

*UT dropped 2/01/2003, restored 7/1/2005, dropped 7/1/2006 
replace visionben_cy=1 if fipsst==49&(year<=2003|year==2006|year==2007)
replace visionben_cylag=1 if fipsst==49&(year<=2004|year==2007|year==2008)

*ID dropped 7/1/2011
replace visionben_cy=1 if fipsst==16&year<=2012
replace visionben_cylag=1 if fipsst==16&year<=2013

*NM dropped 1/1/2010
replace visionben_cy=1 if fipsst==35&year<=2010
replace visionben_cylag=1 if fipsst==35&year<=2011

*NC dropped 10/1/11
replace visionben_cy=1 if fipsst==37&year<=2012
replace visionben_cylag=1 if fipsst==37&year<=2013

*OR dropped 1/1/10
replace visionben_cy=1 if fipsst==41&year<=2010
replace visionben_cylag=1 if fipsst==41&year<=2011

*TX dropped 9/1/2004, added 9/1/2006
replace visionben_cy=1 if fipsst==48&(year<=2005|year>=2008)
replace visionben_cylag=1 if fipsst==48&(year<=2006|year>=2009)

*WA dropped 7/1/2011
replace visionben_cy=1 if fipsst==53&year<=2012
replace visionben_cylag=1 if fipsst==53&year<=2013

************************************************************************************************************************************
*DENTAL COVERAGE INDICATOR FOR TABLE 6
************************************************************************************************************************************

gen dentalben_cy = 0
replace dentalben_cy =1 if fipsst==9|fipsst==18|fipsst==19|fipsst==21|fipsst==27|fipsst==31|fipsst==34|fipsst==35|fipsst==36|fipsst==37|fipsst==38|fipsst==39|fipsst==41|fipsst==42|fipsst==44|fipsst==50|fipsst==55

gen dentalben_cylag=0
replace dentalben_cylag =1 if fipsst==9|fipsst==18|fipsst==19|fipsst==21|fipsst==27|fipsst==31|fipsst==34|fipsst==35|fipsst==36|fipsst==37|fipsst==38|fipsst==39|fipsst==41|fipsst==42|fipsst==44|fipsst==50|fipsst==55

*KS restored basic dental Jan 1, 2013
replace dentalben_cy=1 if fipsst==20&year>=2014
replace dentalben_cylag=1 if fipsst==20&year>=2015

*AK added dental 3/29/2007
replace dentalben_cy=1 if fipsst==2&year>=2008
replace dentalben_cylag=1 if fipsst==2&year>=2009

*AR added dental 7/1/2009
replace dentalben_cy=1 if fipsst==5&year>=2010
replace dentalben_cylag=1 if fipsst==5&year>=2011

*DC added dental 10/1/2006
replace dentalben_cy=1 if fipsst==11&year>=2008
replace dentalben_cylag=1 if fipsst==11&year>=2009

*SD added dental 01/01/2002
replace dentalben_cy=1 if fipsst==46&(year>=2003)
replace dentalben_cylag=1 if fipsst==46&year>=2004

*WY added dental 7/1/2007
replace dentalben_cy=1 if fipsst==56&year>=2008
replace dentalben_cylag=1 if fipsst==56&year>=2009

*CA dropped dental 7/1/2009 and added 5/1/2014
replace dentalben_cy=1 if fipsst==6&year<=2010
replace dentalben_cy=1 if fipsst==6&year>=2015
replace dentalben_cylag=1 if fipsst==6&year<=2011
replace dentalben_cylag=1 if fipsst==6&year>=2016

*FL dropped 7/1/2002
replace dentalben_cy=1 if fipsst==12&year<=2003
replace dentalben_cylag=1 if fipsst==12&year<=2004

*ID dropped dental 7/1/2011
replace dentalben_cy=1 if fipsst==16&year<=2012
replace dentalben_cylag=1 if fipsst==1&year<=2013

*OK dropped dental 7/1/2002
replace dentalben_cy=1 if fipsst==40&year<=2003
replace dentalben_cylag=1 if fipsst==40&year<=2004

*WA dropped dental 7/1/2011 and added 1/1/2014
replace dentalben_cy=1 if fipsst==53&year<=2012|year>=2015
replace dentalben_cylag=1 if fipsst==53&year<=2013|year>=2016

*HI added dental 7/1/2006 and dropped 7/1/2009
replace dentalben_cy=1 if fipsst==15&year>=2007&year<=2010
replace dentalben_cylag=1 if fipsst==15&year>=2008&year<=2011

*MA dropped 7/1/2002 and added dental 7/1/2006
replace dentalben_cy=1 if fipsst==25&(year<=2003|year>=2007)
replace dentalben_cylag=1 if fipsst==25&(year<=2004|year>=2008)

*MI dropped 10/1/2003, added 10/1/2005, dropped dental 4/1/2009 and added 10/1/2010
replace dentalben_cy=1 if fipsst==26&(year<=2004|(year>=2007&year<=2009)|year>=2012)
replace dentalben_cylag=1 if fipsst==26&(year<=2005|(year>=2008&year<=2010)|year>=2013)

*MO added 7/1/2003 and dropped 7/1/2005
replace dentalben_cy=1 if fipsst==29&year>=2004&year<=2006
replace dentalben_cylag=1 if fipsst==29&year>=2005&year<=2007

*UT dropped 7/1/2002, added 7/1/2005, and dropped dental 7/1/2006
replace dentalben_cy=1 if fipsst==49&(year<=2003|(year>=2006&year<=2007))
replace dentalben_cylag=1 if fipsst==49&(year<=2004|(year>=2007&year<=2008))

*CO added adult dental 4/1/2014
replace dentalben_cy=1 if fipsst==8&year>=2015
replace dentalben_cylag=1 if fipsst==8&year>=2016

*IL added adult dental 7/1/2014
replace dentalben_cy=1 if fipsst==17&year>=2015
replace dentalben_cylag=1 if fipsst==17&year>=2016

*SC added dental 7/1/2014
replace dentalben_cy=1 if fipsst==45&year>=2015
replace dentalben_cylag=1 if fipsst==45&year>=2016


**************************************************************************************

************************************************************************************
*CREATE INDICATOR FOR GEOGRAPHIC PLACEBO TEST SHOWN IN TABLE 6
***************************************************************************************

*Reassign policy histories of changer states to nearby states

gen visionben_geo=0

*Never cover states 
*AZ, CO, GA, KY, LA, MD, ME, MT, OK, PA, SC, TN, VT, VA, WV, and WY

*Always cover states
*AL, AK, AR, CT, DC, HI, IL, IN, IA, MN, MS, NE, NH, NJ, NY, ND, OH, RI, SD, WI
replace visionben_geo=1 if fipsst==1|fipsst==2|fipsst==5|fipsst==11|fipsst==15|fipsst==17|fipsst==18|fipsst==27|fipsst==28|fipsst==33|fipsst==34|fipsst==36|fipsst==38|fipsst==39|fipsst==44|fipsst==46

gen visionbenlag_geo=0
replace visionbenlag_geo=1 if fipsst==1|fipsst==2|fipsst==5|fipsst==11|fipsst==15|fipsst==17|fipsst==18|fipsst==27|fipsst==28|fipsst==33|fipsst==34|fipsst==36|fipsst==38|fipsst==39|fipsst==44|fipsst==46

*Remove all real changer states from sample
replace visionben_geo = . if fipsst==6|fipsst==20|fipsst==25|fipsst==26|fipsst==12|fipsst==10|fipsst==29|fipsst==32|fipsst==49|fipsst==16|fipsst==35|fipsst==37|fipsst==41|fipsst==48|fipsst==53
replace visionbenlag_geo = . if fipsst==6|fipsst==20|fipsst==25|fipsst==26|fipsst==12|fipsst==10|fipsst==29|fipsst==32|fipsst==49|fipsst==16|fipsst==35|fipsst==37|fipsst==41|fipsst==48|fipsst==53

*CA (6) dropped vision 7/1/2009, KFF report says they restored optometry benefit to non-institutionalized, non-pregnant adults in July 2010, but appears not so for eyeglasses.
*Use AZ (4) as placebo state (never cover state)
replace visionben_geo=1 if fipsst==4&year<=2010
replace visionbenlag_geo=1 if fipsst==4&year<=2011

*KS (20) dropped vision 1/1/2003 and restored 7/1/2003
*Use Nebraska (31) as placebo state (always cover state)
*Basically not even considered a changer state
replace visionben_geo=1 if fipsst==31
replace visionbenlag_geo=1 if fipsst==31

*MA (25) dropped vision 10/1/2002 added vision 10/1/2006
*Use CT (9) as placebo state (always cover state)
replace visionben_geo=1 if fipsst==9&(year<=2003|year>=2008)
replace visionbenlag_geo=1 if fipsst==9&(year<=2004|year>=2009)

*MI (26) dropped coverage 10/1/2008 and added 10/1/2012
*Use WI (55) as placebo state (always cover state)
replace visionben_geo=1 if fipsst==55&year<=2009
replace visionbenlag_geo=1 if fipsst==55&year<=2010

*FL (12) dropped 7/1/2003 added vision 7/1/2006
*Use GA (13) as placebo state (never cover state)
replace visionben_geo=1 if fipsst==13&year<=2004
replace visionben_geo=1 if fipsst==13&year>=2007
replace visionbenlag_geo=1 if fipsst==13&year<=2005
replace visionbenlag_geo=1 if fipsst==13&year>=2008

*DE (10) dropped vision 7/1/2011
*Use MD (24)(never cover state)
*Not really contributing when the lag is used.
replace visionben_geo=1 if fipsst==24&year<=2012
replace visionbenlag_geo=1 if fipsst==24&year<=2013

*MO (29) added 7/1/2003, dropped 7/1/2005, added vision 7/1/2006
* Use IA (19) as placebo state (always cover state)
replace visionben_geo=1 if fipsst==19&year>=2004
replace visionbenlag_geo=1 if fipsst==19&year>=2005

*NV dropped 7/1/2008 and added 7/1/2009
*No good placebo except AZ, which is getting used for CA
*Omit for now

*UT (49) dropped 2/01/2003, restored 7/1/2005, dropped 7/1/2006 
*Use WY (56) for placebo state (never cover state)
replace visionben_geo=1 if fipsst==56&(year<=2003|year==2006|year==2007)
replace visionbenlag_geo=1 if fipsst==56&(year<=2004|year==2007|year==2008)

*ID (16) dropped 7/1/2011
*Not really contributing when lag is used.
*Can use MT (30) as placebo state (never cover state)
replace visionben_geo=1 if fipsst==30&year<=2012
replace visionbenlag_geo=1 if fipsst==30&year<=2013

*NM (35) dropped 1/1/2010
*Use CO (8) as placebo state (never cover state)
replace visionben_geo=1 if fipsst==8&year<=2010
replace visionbenlag_geo=1 if fipsst==8&year<=2011

*NC (37) dropped 10/1/11
*Not really contributing when lag used
*Use SC (45) as placebo state (never cover)
replace visionben_geo=1 if fipsst==45&year<=2012
replace visionbenlag_geo=1 if fipsst==45&year<=2013

*OR dropped 1/1/10
*Just omit because there aren't really any possibilities.


*TX (48) dropped 9/1/2004, added 9/1/2006
*Use OK (40) as placebo state (never cover state)
replace visionben_geo=1 if fipsst==40&(year<=2005|year>=2008)
replace visionbenlag_geo=1 if fipsst==40&(year<=2006|year>=2009)

*WA dropped 7/1/2011
*Just omit because no good match - not contributing with lag.


*****************************************************************************
