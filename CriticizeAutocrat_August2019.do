use "/Users/Alex2/Desktop/Documents/Dissertation/SSI Russia Survey/ForeignMediaRussia_May2019.dta", clear

gen pass = 1 if time >4 & time <61
replace pass = 0 if pass==.

*Main Effect
reg putin i.domestic_treat if pass==1 , robust
margins, dydx(domestic_treat) level(90)
mplotoffset,xline(0, lcolor(black) lpattern(dash) lwidth(medthick)) recast(scatter) ///
title("Domestic Criticism vs. Control", margin(20 0 5 0) size(medium)  position(12) span)  ///
horiz ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel( `=1' "One-sided" `=2' "Balanced", ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
xline(0, lcolor(gs7) lpattern(dash) lwidth(medthick)) ///
name(domestictreatputin, replace)  



reg putin i.foreign_treat if pass==1, robust
margins, dydx(foreign_treat) level(90)
mplotoffset, xline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Foreign Criticism vs. Control", margin(20 0 5 0) size(medium)  position(12) span)  ///
horiz ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel( `=1' "One-sided" `=2' "Balanced", ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
xline(0, lcolor(gs7) lpattern(dash) lwidth(medthick)) ///
name(foreigntreatputin, replace)  

gr combine domestictreatputin foreigntreatputin,  ycommon xcommon row(1) /// 
b1("Treatment effect", size(small)) /// 
title("{bf:Influence of Domestic and Foreign Criticism on Support for Putin}", margin(10 0 5 0))
graph export "maineffects_vote", as(eps) replace


*Main Effect by Regime Support
reg putin i.domestic_treat##regimesupport if pass==1 , robust
margins regimesupport, dydx(domestic_treat)
mplotoffset,  offset(0.1) xline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Domestic Criticism vs. Control", margin(20 0 5 0) size(medium)  position(12) span)  ///
horiz ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(11) row(2) ring(0)) ///
xline(0, lcolor(gs7) lpattern(dash) lwidth(medthick)) ///
name(domestictreatputin, replace)  

reg putin i.foreign_treat##regimesupport  if pass==1, robust
margins regimesupport, dydx(foreign_treat)
mplotoffset,  offset(0.1) xline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Foreign Criticism vs. Control", margin(20 0 5 0) size(medium)  position(12) span)  ///
horiz ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(11) row(2) ring(0)) ///
xline(0, lcolor(gs7) lpattern(dash) lwidth(medthick)) ///
name(foreigntreatputin, replace)  


gr combine domestictreatputin foreigntreatputin, ycommon xcommon row(1) /// 
b1("Treatment effect", size(small)) /// 
title("{bf:Influence of Domestic and Foreign Criticism on Support for Putin}", margin(10 0 5 0))
graph export "putinmaineffects_vote", as(eps) replace

********************
*Does Source Matter*
********************

reg putin i.criticism##regimesupport if pass==1, robust
margins regimesupport, dydx(criticism)
mplotoffset, xline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Domestic One-Sided vs. Foreign One-Sided", margin(20 0 5 0) size(medium)  position(12) span)  ///
horiz ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
xline(0, lcolor(gs7) lpattern(dash) lwidth(medthick)) ///
name(source_one, replace)  

reg putin i.balanced##regimesupport if pass==1, robust
margins regimesupport, dydx(balanced)
mplotoffset, xline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Domestic Balanced vs. Foreign Balanced",  margin(20 0 5 0) size(medium)  position(12) span) ///
horiz ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
xline(0, lcolor(gs7) lpattern(dash) lwidth(medthick)) ///
name(source_bal, replace)  

gr combine source_one source_bal, xcommon row(1) b1("Treatment effect", size(small)) ///
title("{bf:Influence of Domestic vs. Foreign Criticism on Support for Putin}", margin(10 0 5 0))
graph export "source_graphs", as(eps) replace

***************************
*Trust Source - Mechanism**
***************************

reg trustsource i.domestic_treat##regimesupport if pass==1, robust
margins regimesupport, dydx(domestic_treat)
mplotoffset, offset(0.1) xline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Domestic Criticism vs. Control", margin(20 0 5 0) size(medium)  position(12) span) ///
horiz ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(2) row(2) ring(0)) ///
xline(0, lcolor(gs7) lpattern(dash) lwidth(medthick)) ///
name(biasD, replace) 

reg trustsource  biased i.foreign_treat##regimesupport if pass==1, robust
margins regimesupport, dydx(foreign_treat) 
mplotoffset,  offset(0.1)xline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Foreign Criticism vs. Control", margin(20 0 5 0) size(medium)  position(12) span)  ///
horiz ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(2) row(2) ring(0)) ///
xline(0, lcolor(gs7) lpattern(dash) lwidth(medthick)) ///
name(biasF, replace)  ytitle("") xtitle("")

gr combine biasD biasF, ycommon row(1) b1("Treatment effect", size(small)) ///
title("{bf:Influence of Domestic and Foreign Criticism on Trust in Strela}", margin(10 0 5 0))
graph export "cred_vote", as(eps) replace



***************************************
*Angry at Insult Russia and Treatments*
***************************************

reg putin domestic_treat##c.angryinsultrussia i.regimesupport  /// 
female age married city russian orthodox i.media_use3 polinterest4 if pass==1, robust
margins, dydx(domestic_treat) at(angryinsultrussia=(1(1)4))
mplotoffset, offset(0.12)  yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Domestic Criticism vs. Control", margin(10 0 5 0) size(medium)  position(12) span)  ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid angle(45)) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(2) row(2) ring(0)) ///
name(angryrussia_dom, replace)  

reg putin foreign_treat##c.angryinsultrussia i.regimesupport  /// 
female age married city russian orthodox i.media_use3 polinterest4 if pass==1, robust
margins, dydx(foreign_treat) at(angryinsultrussia=(1(1)4))
mplotoffset, offset(0.12)  yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Foreign Criticism vs. Control", margin(10 0 5 0) size(medium)  position(12) span)  ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid angle(45)) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(2) row(2) ring(0)) ///
name(angryrussia_for, replace)  

gr combine angryrussia_dom angryrussia_for, ycommon row(1) ///
l1("Treatment effect", size(small)) b1("Get upset when Russia is insulted", size(small)) /// 
title("{bf:Influence of Domestic and Foreign Criticism on Support for Putin}" "{bf:By Sensitivity to Criticism}", margin(10 0 5 0))

graph export "angryRussia", as(eps) replace

********************************************
*Interaction with Foreign Media Consumption*
********************************************

reg putin i.domestic_treat##c.fm_proportion ///
female age married city russian orthodox i.regimesupport i.media_use3 polinterest4 if pass==1, robust
margins, dydx(domestic_treat) at(fm_proportion=(0(0.05)0.3)) 
mplotoffset, offset(0.008)  yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Domestic Criticism vs. Control", margin(10 0 5 0) size(medium)  position(12) span)  ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(0 "None" 0.3 "A lot", labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(11) row(2) ring(0)) ///
name(dom_fcon, replace) 

reg putin i.foreign_treat##c.fm_proportion ///
female age married city russian orthodox i.regimesupport i.media_use3 polinterest4 if pass==1, robust
margins, dydx(foreign_treat) at(fm_proportion=(0(0.05)0.3)) 
mplotoffset, offset(0.008)  yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Foreign Criticism vs. Control", margin(10 0 5 0) size(medium)  position(12) span)  ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(0 "None" 0.3 "A lot", labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid ) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(11) row(2) ring(0)) ///
name(for_fcon, replace) 

gr combine dom_fcon for_fcon, ///
l1("Treatment effect", size(small)) b1("Consumption of Foreign Media (Proportion)", size(small)) ///
title("{bf:Influence of Domestic and Foreign Criticism on Support for Putin}" "{bf:by Foreign Media Consumption}", margin(10 0 5 0))
graph export "consumeforeign", as(eps) replace

***********************
*Education Interaction*
***********************

reg putin i.domestic_treat##c.education i.regimesupport if pass==1, robust
margins, dydx(domestic_treat) at(education=(1 6 11))
mplotoffset,  offset(0.45) yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Domestic Criticism vs. Control", margin(10 0 5 0) size(medium)  position(12) span)  ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(2) row(2) ring(0)) ///
name(educ_dom, replace)  

reg putin i.foreign_treat##c.education i.regimesupport if pass==1, robust
margins, dydx(foreign_treat) at(education=(1 6 11))
mplotoffset,  offset(0.45) yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Foreign Criticism vs. Control", margin(10 0 5 0) size(medium)  position(12) span)  ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(2) row(2) ring(0)) ///
name(educ_for, replace)  


gr combine educ_dom educ_for, ycommon row(1) /// 
l1("Treatment effect", size(small)) /// 
b1("Education", size(small)) /// 
title("{bf:Influence of Domestic and Foreign Criticism on Support for Putin}" "{bf:By Education}", margin(10 0 5 0))
graph export "educ_interaction", as(eps) replace

*****************
*Age Interaction*
*****************

reg putin i.domestic_treat##c.age##c.age /// 
female married city russian orthodox i.regimesupport i.media_use3 polinterest4 if pass==1, robust
margins, dydx(domestic_treat) at(age=(18(10)70))
mplotoffset,  offset(2) yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Domestic Criticism vs. Control", margin(10 0 5 0) size(medium)  position(12) span)  ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(`=20' "20" `=30' "30" `=40' "40" `=50' "50" `=60' "60" `=70' "70", labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(5) row(2) ring(0)) ///
name(age_dom, replace)  

reg putin i.foreign_treat##c.age##c.age female /// 
married city russian orthodox i.regimesupport i.media_use3 polinterest4 if pass==1, robust
margins, dydx(foreign_treat) at(age=(18(10)70))
mplotoffset,  offset(2) yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Foreign Criticism vs. Control", margin(10 0 5 0) size(medium)  position(12) span)  ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(`=20' "20" `=30' "30" `=40' "40" `=50' "50" `=60' "60" `=70' "70", labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(5) row(2) ring(0)) ///
name(age_for, replace)  


gr combine age_dom age_for, ycommon row(1) /// 
l1("Treatment effect", size(small)) b1("Age", size(small)) ///
title("{bf:Influence of Domestic and Foreign Criticism on Support for Putin}", margin(10 0 5 0))
graph export "age_interaction", as(eps) replace

*********************************
*Alternative Dependent Varibales*
*********************************

logit vote_navalny i.domestic_treat##regimesupport if pass==1, robust
margins regimesupport, dydx(domestic_treat)
mplotoffset,  offset(0.1) xline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Domestic Criticism vs. Control", margin(20 0 5 0) size(medium)  position(12) span)  ///
horiz ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(1) row(2) ring(0)) ///
xline(0, lcolor(gs7) lpattern(dash) lwidth(medthick)) ///
name(domestictreatvote_navalny_vote, replace)  

logit vote_navalny i.foreign_treat##regimesupport if pass==1, robust
margins regimesupport, dydx(foreign_treat)
mplotoffset,  offset(0.1) xline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Foreign Criticism vs. Control", margin(20 0 5 0) size(medium)  position(12) span)  ///
horiz ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(1) row(2) ring(0)) ///
xline(0, lcolor(gs7) lpattern(dash) lwidth(medthick)) ///
name(foreigntreatvote_navalny_vote, replace)  

gr combine domestictreatvote_navalny_vote foreigntreatvote_navalny_vote, ycommon row(1) /// 
b1("Treatment effect", size(small)) ///
title("{bf:Influence of Domestic and Foreign Criticism on Support for Navalny}", margin(10 0 5 0))
graph export "navalnymaineffects_vote", as(eps) replace

reg democracy i.domestic_treat##regimesupport if pass==1, robust
margins regimesupport, dydx(domestic_treat)
mplotoffset,  offset(0.1) xline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Domestic  Criticism vs. Control", margin(20 0 5 0) size(medium)  position(12) span)  ///
horiz ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(11) row(2) ring(0)) ///
xline(0, lcolor(gs7) lpattern(dash) lwidth(medthick)) ///
name(domestic_dem, replace)  

reg democracy i.foreign_treat##regimesupport if pass==1, robust
margins regimesupport, dydx(foreign_treat)
mplotoffset,  offset(0.1) xline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Foreign  Criticism vs. Control", margin(20 0 5 0) size(medium)  position(12) span)  ///
horiz ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(11) row(2) ring(0)) ///
xline(0, lcolor(gs7) lpattern(dash) lwidth(medthick)) ///
name(foreign_dem, replace)  

gr combine domestic_dem foreign_dem, xcommon row(1) /// 
b1("Treatment effect", size(small)) ///
title("{bf:Influence of Domestic and Foreign Criticism on View that Russia is Democratic}", margin(10 0 5 0))
graph export "democracyeffects_vote", as(eps) replace


*********************
*****APPENDIX********
*********************

*Table Domestic Treat
reg putin i.domestic_treat, robust
est store mod1
reg putin i.domestic_treat female age married city russian orthodox i.regimesupport i.media_use3, robust
est store mod2

esttab  mod1 mod2  ///
using multilevel.tex, b(%9.2f) se(%9.2f) label ///
title(Domestic Criticism: Treatment effects \label{tab2}) /// 
addnotes(Note: Put your notes here.) nonum  ///
mtitles("No Controls" "Controls") compress  replace ///
stats(N r2 , labels("Observations" "R-Squared") fmt(%9.1g)) ///
nobaselevels interaction(" X ") nogap collabels(,lhs()) wide  booktabs

*Table Foreign Treat
reg putin i.foreign_treat if pass==1, robust
est store mod1
reg putin i.foreign_treat female age married city russian orthodox i.regimesupport i.media_use3 if pass==1, robust
est store mod2

esttab  mod1 mod2  ///
using multilevel.tex, b(%9.2f) se(%9.2f) label ///
title(Foreign Criticism: Treatment effects \label{tab2}) /// 
addnotes(Note: Put your notes here.) nonum  ///
mtitles("No Controls" "Controls") compress   replace ///
stats(N r2 , labels("Observations" "R-Squared") fmt(%9.0g)) ///
nobaselevels interaction(" X ") nogap collabels(,lhs()) wide  booktabs

*Table Interaction - Domestic Treat
reg putin i.domestic_treat##i.regimesupport if pass==1, robust
est store mod1
reg putin i.domestic_treat##i.regimesupport female age married city russian orthodox i.media_use3 if pass==1, robust
est store mod2

esttab  mod1 mod2   ///
using multilevel.tex, b(%9.2f) se(%9.2f) label ///
title(Domestic Criticism: Treatment effects \label{tab2}) /// 
addnotes(Note: Put your notes here.) nonum  ///
mtitles("No Controls" "Controls") compress star(* 0.05)  replace ///
stats(N r2 , labels("Observations" "R-Squared") fmt(%9.1g)) ///
nobaselevels interaction(" X ") nogap collabels(,lhs()) wide  booktabs

*Table Interaction - Foreign Treat
reg putin i.foreign_treat##i.regimesupport if pass==1, robust
est store mod1
reg putin i.foreign_treat##i.regimesupport female age married city russian orthodox i.media_use3 if pass==1, robust
est store mod2

esttab  mod1 mod2   ///
using multilevel.tex, b(%9.2f) se(%9.2f) label ///
title(Foreign Criticism: Treatment effects \label{tab2}) /// 
addnotes(Note: Put your notes here.) nonum  ///
mtitles("No Controls" "Controls") compress star(* 0.05)  replace ///
stats(N r2 , labels("Observations" "R-Squared") fmt(%9.0g)) ///
nobaselevels interaction(" X ") nogap collabels(,lhs()) wide  booktabs

*Appendix X: Other Regime Support Operationalization
gen regimesupport_pure = 2 if who_voted==4 
replace regimesupport_pure = 1 if who_voted==1 | who_voted==2 | who_voted==3 | who_voted==5 | who_voted==6 | who_voted==7 | who_voted==8 | who_voted==9
replace regimesupport_pure = 0 if voted==2 | voted==3 | who_voted==10 | who_voted==11
label variable regimesupport_pure "Regime Support"
label define regimesupport_pure 2 "Regime Voter" 1 "Opposition Voter" 0 "Non-Voter", replace
label values regimesupport_pure regimesupport_pure

reg putin i.domestic_treat##i.regimesupport_pure if pass==1, robust
est store mod1
reg putin i.domestic_treat##i.regimesupport_pure female age married city russian orthodox i.media_use3 if pass==1, robust
est store mod2

esttab  mod1 mod2   ///
using multilevel.tex, b(%9.2f) se(%9.2f) label ///
title(Domestic Criticism: Treatment effects \label{tab2}) /// 
addnotes(Note: Put your notes here.) nonum  ///
mtitles("No Controls" "Controls") compress star(* 0.05)  replace ///
stats(N r2 , labels("Observations" "R-Squared") fmt(%9.1g)) ///
nobaselevels interaction(" X ") nogap collabels(,lhs()) wide  booktabs

reg putin i.foreign_treat##i.regimesupport_pure if pass==1, robust
est store mod1
reg putin i.foreign_treat##i.regimesupport_pure female age married city russian orthodox i.media_use3 if pass==1, robust
est store mod2

esttab  mod1 mod2   ///
using multilevel.tex, b(%9.2f) se(%9.2f) label ///
title(Foreign Criticism: Treatment effects \label{tab2}) /// 
addnotes(Note: Put your notes here.) nonum  ///
mtitles("No Controls" "Controls") compress star(* 0.05)  replace ///
stats(N r2 , labels("Observations" "R-Squared") fmt(%9.0g)) ///
nobaselevels interaction(" X ") nogap collabels(,lhs()) wide  booktabs

* Appendix C: Characteristics of Regime Supporters
mlogit regimesupport i.female age education married city russian howreligious orthodox /// 
polinterest4  i.media_use3 socialmediause i.mediatrust usattitudes  if pass==1
margins, dydx(*) post predict(outcome(0))
estimates store nonvote

mlogit regimesupport  i.female age education married city russian howreligious orthodox /// 
polinterest4  i.media_use3 socialmediause i.mediatrust  usattitudes  if pass==1
margins, dydx(*) post predict(outcome(1))
estimates store oppvote

mlogit regimesupport i.female age education married city russian howreligious orthodox /// 
polinterest4  i.media_use3 socialmediause i.mediatrust  usattitudes  if pass==1
margins, dydx(*) post predict(outcome(2))
estimates store pvote

coefplot nonvote, bylabel(Non-Voter)   || /// 
		 oppvote, bylabel(Opposition Voter)   || /// 
		 pvote, bylabel(Regime Voter)   ||, /// 
		 drop(_cons) xline(0, lcolor(black)) msymb(O) msize(medlarge) ///
		 byopts(cols(3)) scheme(plottig) ///
		 plotregion(fcolor(white) lcolor(gs10))
		 
		 graph export "regimechar", as(eps) replace


*Appendix F: Interaction with Trust in Foreign Media

reg putin i.domestic_treat##trust_media_foreign2 ///
female age married city russian orthodox i.regimesupport i.media_use3 polinterest4 if pass==1, robust
margins, dydx(domestic_treat) at(trust_media_foreign2=(0(1)1)) 
mplotoffset,  yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Domestic Criticism vs. Control", margin(10 0 5 0) size(medium)  position(12) span)  ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(11) row(2) ring(0)) ///
name(trustdomestic, replace) 

reg putin i.foreign_treat##trust_media_foreign2 /// 
female age married city russian orthodox i.regimesupport i.media_use3 polinterest4 if pass==1, robust
margins, dydx(foreign_treat) at(trust_media_foreign2=(0(1)1)) 
mplotoffset,  yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Foreign Criticism vs. Control", margin(10 0 5 0) size(medium)  position(12) span)  ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(11) row(2) ring(0)) ///
name(trustforeign, replace) 

gr combine trustdomestic trustforeign, ///
l1("Treatment effect", size(small)) b1("Trust Foreign Media", size(small)) ///
title("{bf:Influence of Domestic and Foreign Criticism on Support for Putin}" "{bf:By Trust in Foreign Media}", margin(10 0 5 0))

graph export "trustforeign", as(eps) replace


*Appendix G: Interaction with U.S. Attitudes

reg putin i.domestic_treat##i.usattitudes ///
female age married city russian orthodox i.regimesupport i.media_use3 polinterest4 if pass==1, robust
margins, dydx(domestic_treat) at(usattitudes=(1(1)3)) 
mplotoffset, offset(0.1) yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Domestic Criticism vs. Control", margin(10 0 5 0) size(medium)  position(12) span)  ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(2) row(2) ring(0)) ///
xscale(range(1 3.2)) ///
name(dom_us, replace) 

reg putin i.foreign_treat##i.usattitudes ///
female age married city russian orthodox i.regimesupport i.media_use3 polinterest4 if pass==1, robust
margins, dydx(foreign_treat) at(usattitudes=(1(1)3)) 
mplotoffset,  offset(0.1) yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
title("Foreign Criticism vs. Control", margin(10 0 5 0) size(medium)  position(12) span)  ///
plotregion(fcolor(white) lcolor(gs10) lwidth(medium)) ///
xlabel(, labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
ylabel(, ///
labcolor(gs4) tlcolor() tlwidth(thin) labsize(small) nogrid) ///
xtitle("", color(black)) ///
ytitle("", color(black)) ///
recastci(rspike) ciopts(lwidth(thick)) plotopt(msym(O) msize(large)) ///
plot1opts(mcolor(white) mlcolor(black) lcolor(black)) ///
plot( , label( "One-Sided" "Balanced")) legend(pos(2) row(2) ring(0)) ///
xscale(range(1 3.2)) ///
name(for_us, replace) 

gr combine dom_us for_us, ///
l1("Treatment effect on Support for Putin", size(small)) b1("Attitudes toward U.S.", size(small)) ///
title("{bf:Influence of Domestic and Foreign Criticism on Support for Putin}" "{bf:By Priors toward United States}", margin(10 0 5 0))
graph export "usattitudes", as(eps) replace

*Proud Citizen
gen country_pride = 0 if proud_citizen >2
replace country_pride = 1 if proud_citizen <3
replace country_pride = . if proud_citizen ==.
label variable country_pride "Proud to be a Russian Citizen"
label define proud 0 "Not proud" 1 "Proud", replace
label values country_pride proud



reg putin i.domestic_treat##i.country_pride if pass==1, robust
margins country_pride, dydx(domestic_treat)  
mplotoffset, yline(0, lcolor(black) lpattern(dash) lwidth(thick))  recast(scatter) ///
offset(0.1) ///
xlabel(, nogrid) ///
ylabel(, nogrid) ///
plot( , label("One-Sided" "Balanced")) legend(pos(1) row(2) ring(0)) ///
title("Domestic Treatments vs. Control", /// 
margin(10 0 5 0) size(medium)  position(12) span) scheme(lean1)  ///
recastci(rspike) ///
ciopts(fcolor(gs11)  lpattern() lwidth(thick)) plotopt(msym() msize(large)) ///
plotregion(fcolor(white) lcolor(gs10)) ///
name(dom_proud, replace) ///
ytitle("") xtitle("") 

reg putin i.foreign_treat##country_pride if pass==1, robust
margins country_pride, dydx(foreign_treat) 
mplotoffset, yline(0, lcolor(black) lpattern(dash) lwidth(thick))  recast(scatter) ///
offset(0.1) ///
xlabel(, nogrid) ///
ylabel(, nogrid) ///
plot( , label("One-Sided" "Balanced")) legend(pos(1) row(2) ring(0)) ///
title("Foreign Treatments vs. Control", /// 
margin(10 0 5 0) size(medium)  position(12) span) scheme(lean1)  ///
recastci(rspike) ///
ciopts(fcolor(gs11)  lpattern() lwidth(thick)) plotopt(msym() msize(large)) ///
plotregion(fcolor(white) lcolor(gs10)) ///
name(for_proud, replace) ///
ytitle("") xtitle("") 

gr combine dom_proud for_proud, ///
l1("Treatment effect on Support for Putin", size(small)) b1("Proud to be a Russian Citizen.", size(small)) 
graph export "proud_cit", as(eps) replace


*Appendix X: Tables for alterenative DVs**

reg vote_nav i.domestic_treat if pass==1, robust
est store mod3
reg vote_nav i.domestic_treat female age married city russian orthodox i.media_use3 if pass==1, robust
est store mod4
reg democracy i.domestic_treat if pass==1, robust
est store mod5
reg democracy i.domestic_treat female age married city russian orthodox i.regimesupport i.media_use3 if pass==1, robust
est store mod6

esttab  mod3 mod4 mod5 mod6 ///
using multilevel.tex, b(%9.2f) se(%9.2f) label ///
title(Domestic Criticism: Treatment effects \label{tab1}) /// 
addnotes(Note: Put your notes here.) nonum  ///
mtitles("Putin" "Putin" "Navalny" "Navalny" "Democracy" "Democracy") compress star(* 0.05)  replace ///
stats(N r2 , labels("Observations" "R-Squared") fmt(%9.0g)) ///
nobaselevels interaction(" X ") nogap collabels(,lhs()) wide  booktabs

reg vote_nav i.foreign_treat if pass==1, robust
est store mod3
reg vote_nav i.foreign_treat female age married city russian orthodox i.regimesupport i.media_use3 if pass==1, robust
est store mod4
reg democracy i.foreign_treat if pass==1, robust
est store mod5
reg democracy i.foreign_treat female age married city russian orthodox i.regimesupport i.media_use3 if pass==1, robust
est store mod6

esttab  mod3 mod4 mod5 mod6 ///
using multilevel.tex, b(%9.2f) se(%9.2f) label ///
title(Foreign Criticism: Treatment effects \label{tab2}) /// 
addnotes(Note: Put your notes here.) nonum  ///
mtitles("Putin" "Putin" "Navalny" "Navalny" "Democracy" "Democracy") compress star(* 0.05)  replace ///
stats(N r2 , labels("Observations" "R-Squared") fmt(%9.0g)) ///
nobaselevels interaction(" X ") nogap collabels(,lhs()) wide  booktabs


*Table with percentages
gen putin3 = 1 if putin_approve > 3
replace putin3 = 2 if putin_approve==3
replace putin3 = 3 if putin_approve < 3
label variable putin3 "Putin Support"
label define putin3 1 "Disapprove" 2 "Neutral" 3 "Approve", replace
label values putin3 putin3

svyset responseid

tabout putin3 foreign_treat using table8.txt, ///
c(col ci) f(1 1) clab(Col_% 95%_CI) svy stats(chi2) ///
npos(lab) percent cisep(-) ptotal(none) ///
rep ///
style(tex) bt font(bold)  cl1(2-6) ///
topf(top.tex) botf(bot.tex) topstr(14cm) botstr(nlsw88.dta)

*Just Education Interaction

reg putin i.foreign_treat##c.education if regimesupport==0 & pass==1, robust
margins, dydx(foreign_treat) at(education=(1 6 11))
mplotoffset, offset(0.55)  yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
xlabel(, labsize(vsmall)  nogrid angle()) ///
ylabel(, nogrid) ///
title("Non-Voter", /// 
margin(10 0 5 0) size(medium)  position(12) span) scheme(lean1) ///
ytitle("") ///
recastci(rspike) ///
ciopts(fcolor(gs11)  lpattern() lwidth(thick)) plotopt(msym() msize(large)) ///
xscale(range(0.5 7)) ///
xtitle("") ///
plotregion(fcolor(white) lcolor(gs10)) ///
byopts(title("Support for Vladimir Putin")) ///
plot( , label("One-Sided" "Balanced")) legend(pos(1) row(2) ring(0)) ///
name(nonvoteeduc, replace)  

reg putin i.foreign_treat##c.education if regimesupport==1 & pass==1, robust
margins, dydx(foreign_treat) at(education=(1 6 11))
mplotoffset, offset(0.55)  yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
xlabel(, labsize(vsmall)  nogrid angle()) ///
ylabel(, nogrid) ///
title("Opposition Voter", /// 
margin(10 0 5 0) size(medium)  position(12) span) scheme(lean1) ///
ytitle("") ///
recastci(rspike) ///
ciopts(fcolor(gs11)  lpattern() lwidth(thick)) plotopt(msym() msize(large)) ///
xscale(range(0.5 7)) ///
xtitle("") ///
plotregion(fcolor(white) lcolor(gs10)) ///
byopts(title("Support for Vladimir Putin")) ///
plot( , label("One-Sided" "Balanced")) legend(pos(1) row(2) ring(0)) ///
name(othervoteeduc, replace)  

reg putin i.foreign_treat##c.education if regimesupport==2 & pass==1, robust
margins, dydx(foreign_treat) at(education=(1 6 11))
mplotoffset, offset(0.55)  yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
xlabel(, labsize(vsmall)  nogrid angle()) ///
ylabel(, nogrid) ///
title("Regime Voter", /// 
margin(10 0 5 0) size(medium)  position(12) span) scheme(lean1) ///
ytitle("") ///
recastci(rspike) ///
ciopts(fcolor(gs11)  lpattern() lwidth(thick)) plotopt(msym() msize(large)) ///
xscale(range(0.5 7)) ///
xtitle("") ///
plotregion(fcolor(white) lcolor(gs10)) ///
byopts(title("Support for Vladimir Putin")) ///
plot( , label("One-Sided" "Balanced")) legend(pos(1) row(2) ring(0)) ///
name(putinvoteeduc, replace)  

gr combine nonvoteeduc othervoteeduc putinvoteeduc, ycommon row(1) ///
l1("Treatment effect", size(small)) b1("Education", size(small)) /// 
title("{bf:Influence of Domestic and Foreign Criticism on Support for Putin}" "{bf:By Education Level}", margin(10 0 5 0))

graph export "vote_educ", as(eps) replace


*Education and Political Interest Interaction
reg putin i.foreign_treat##polinterest##c.education if pass==1, robust
margins polinterest, dydx(foreign_treat) at(education=(1 6 11))
mplotoffset, by(polinterest) offset(0.45)  yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
xlabel(, labsize(vsmall)  nogrid angle()) ///
ylabel(, nogrid) ///
title("", /// 
margin(10 0 5 0) size(medium)  position(12) span) scheme(lean1) ///
ytitle("") ///
recastci(rspike) ///
ciopts(fcolor(gs11)  lpattern() lwidth(thick)) plotopt(msym() msize(large)) ///
xscale(range(0.5 7)) ///
xtitle("") ///
plotregion(fcolor(white) lcolor(gs10)) ///
byopts(title("{bf:Influence of Foreign Criticism on Support for Vladimir Putin}")) ///
plot( , label("One-Sided" "Balanced")) legend(pos(12) row(2) ring(1)) ///
name(interest_educ_for, replace)  
graph export "interest_educ", as(eps) replace

reg putin i.domestic_treat##polinterest##c.education if pass==1, robust
margins polinterest, dydx(domestic_treat) at(education=(1 6 11))
mplotoffset, by(polinterest) offset(0.45)  yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
xlabel(, labsize(vsmall)  nogrid angle()) ///
ylabel(, nogrid) ///
title("", /// 
margin(10 0 5 0) size(medium)  position(12) span) scheme(lean1) ///
ytitle("") ///
recastci(rspike) ///
ciopts(fcolor(gs11)  lpattern() lwidth(thick)) plotopt(msym() msize(large)) ///
xscale(range(0.5 7)) ///
xtitle("") ///
plotregion(fcolor(white) lcolor(gs10)) ///
byopts(title("{bf:Influence of Foreign Criticism on Support for Vladimir Putin}")) ///
plot( , label("One-Sided" "Balanced")) legend(pos(12) row(2) ring(1)) ///
name(interest_educ_dom, replace)  
graph export "interest_educ", as(eps) replace


*Religious Interaction
reg putin foreign_treat##c.howreligious /// 
female age married city russian orthodox i.regimesupport i.media_use3 polinterest4 if pass==1, robust
margins, dydx(foreign_treat) at(howreligious=(1(1)7))
mplotoffset,  offset(0.1)  yline(0, lcolor(black) lpattern(dash) lwidth(medthick))  recast(scatter) ///
xlabel(, labsize(vsmall)  nogrid angle()) ///
ylabel(, nogrid) ///
title("", /// 
margin(10 0 5 0) size(medium)  position(12) span) scheme(lean1) ///
ytitle("") ///
recastci(rspike) ///
ciopts(fcolor(gs11)  lpattern() lwidth(thick)) plotopt(msym() msize(large)) ///
xtitle("") ///
plotregion(fcolor(white) lcolor(gs10)) ///
byopts(title("{bf:Influence of Foreign Criticism on Support for Vladimir Putin}")) ///
plot( , label("One-Sided" "Balanced")) legend(pos(12) row(2) ring(1)) ///
name(interest_educ_dom, replace)  
graph export "relig_interaction", as(eps) replace


*Prior Views on Corruption
reg putin foreign_treat##i.country_corruption i.regimesupport i.media_use3 polinterest4 /// 
female age married city russian orthodox howreligious  if pass==1, robust

reg putin domestic_treat##i.country_corruption i.regimesupport i.media_use3 polinterest4 /// 
female age married city russian orthodox howreligious  if pass==1, robust

*Summary Statistics
tabout female generation married city russian orthodox regimesupport if pass==1 using summarytable1.tex, /// 
replace  cells(freq col) f(2) oneway ///
style(tex) bt font(bold) topf(top.tex) botf(bot.tex)topstr(11cm) 

*Balance Test
tabout female generation married city russian orthodox regimesupport  treatments if pass==1  using summarytable1.tex, /// 
replace  f(0c) stats(chi2) ///
style(tex) bt font(bold) topf(top.tex) botf(bot.tex)topstr(11cm) 


