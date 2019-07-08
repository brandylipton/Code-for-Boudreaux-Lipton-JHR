# Code-for-Boudreaux-Lipton-JHR
"Boudreaux Lipton JHR Clean Data FINAL" should be run first using the 2002-2013 CPS ASEC. The CPS ASEC data are available here: https://cps.ipums.org/cps/. The do file "Boudreaux_Lipton_JHR_vision_dental_vars" creates the dental and vision policy variables, including the placebo variable used in the geographic placebo test shown in Table 6. The stata dataset "Boudreaux_Lipton_policyvars.dta" contains all other external policy variables used in the analysis by state and year. The Clean Data file will merge these variables with the CPS automatically, as long as they are in the appropriate directory. 

"Boudreaux Lipton JHR Analysis FINAL" can be run after the Clean Data file and recreates all tables and figures in the main paper and appendix using the CPS ASEC 2002-2013, with the exception of Figure 1 and Appendix Table 6. Figure 1 includes policy information collected by the authors. Appendix Table 6 uses the 2008-2013 ACS (available from IPUMS: https://usa.ipums.org/usa/). Code and instructions for Appendix Table 6 are included at the bottom of the Analysis file.
