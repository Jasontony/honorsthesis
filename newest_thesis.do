#delimit;    
set more 1; 
drop _all ;  
capture log close; 

cd C:/users/jaotengnyame/downloads;

log using C:/users/jaotengnyame/downloads/sum_stats.txt  , text replace;

use summystats.dta;

/*Adjustments:*/
/*kicking out non alum*/
drop if primaryconstituency!= "Alum - Non-grad" & primaryconstituency != "Alumnus/A";
/*kicking out international students*/
drop if ethnicity== 12; 
/*kicking out the dead*/
drop if deceased==1;
/*kicking out students graduating before 2004*/
drop if dc_prefclassyr < 2004 | dc_prefclassyr>2013;
/*drop efc more than 4 years*/
gen posefc1=1 if efc0001>0;
replace posefc1=0 if posefc1 !=1;

gen posefc2=1 if efc0102>0;
replace posefc2=0 if posefc2 !=1;

gen posefc3=1 if efc0203>0;
replace posefc3=0 if posefc3 !=1;

gen posefc4=1 if efc0304>0;
replace posefc4=0 if posefc4 !=1;

gen posefc5=1 if efc0405>0;
replace posefc5=0 if posefc5 !=1;

gen posefc6=1 if efc0506>0;
replace posefc6=0 if posefc6 !=1;

gen posefc7=1 if efc0607>0;
replace posefc7=0 if posefc7 !=1;

gen posefc8=1 if efc0708>0;
replace posefc8=0 if posefc8 !=1;

gen posefc9=1 if efc0809>0;
replace posefc9=0 if posefc9 !=1;

gen posefc10=1 if efc0910>0;
replace posefc10=0 if posefc10 !=1;

gen posefc11=1 if efc1011>0;
replace posefc11=0 if posefc11 !=1;

gen posefc12=1 if efc1112>0;
replace posefc12=0 if posefc12 !=1;

gen posefc13=1 if efc1213>0;
replace posefc13=0 if posefc13 !=1;

gen totalposefc=  posefc1 + posefc2 + posefc3 +  posefc4 +  posefc5 +  posefc6 +  posefc7 +  posefc8 +  posefc9 +  posefc10 +  posefc11 +  posefc12 +  posefc13;

drop if totalposefc>4;



/*drop simulated loans if it is positive when total loans is 0*/
/*
drop demonneed0001 demonneed0102 demonneed0203 demonneed0304 demonneed0405 demonneed0506 demonneed0607 demonneed0708 demonneed0809 demonneed0910 demonneed1011 demonneed1112 demonneedefc1213 total_demonneed;

drop simulloan0001 simulloan0102 simulloan0203 simulloan0304 simulloan0405 simulloan0506 simulloan0607 simulloan0708 simulloan0910 simulloan0809 simulloan1011 simulloan1112 total_simulatedloans simulloan1213;


gen demonneed0001=  41308.20-efc0001 if dc_prefclassyr==2004;
replace demonneed0001= 0 if demonneed0001==. | demonneed0001<0;
gen demonneed0102=  41934.30-efc0102 if dc_prefclassyr==2004 | dc_prefclassyr==2005 ;
replace demonneed0102= 0 if demonneed0102==. | demonneed0102<0;
gen demonneed0203 = 42767.63-efc0203 if dc_prefclassyr==2004 | dc_prefclassyr==2005| dc_prefclassyr==2006 ;
replace demonneed0203= 0 if demonneed0203==. | demonneed0203<0;
gen demonneed0304 = 43565.60-efc0304 if dc_prefclassyr==2004 | dc_prefclassyr==2005| dc_prefclassyr==2006|dc_prefclassyr==2007;
replace demonneed0304= 0 if demonneed0304==. | demonneed0304<0;
gen demonneed0405 = 44315.14-efc0405 if dc_prefclassyr==2008 | dc_prefclassyr==2005| dc_prefclassyr==2006|dc_prefclassyr==2007;
replace demonneed0405= 0 if demonneed0405==. | demonneed0405<0;
gen demonneed0506= 45105.76-efc0506 if dc_prefclassyr==2008 | dc_prefclassyr==2009| dc_prefclassyr==2006|dc_prefclassyr==2007;
replace demonneed0506= 0 if demonneed0506==. | demonneed0506<0;
gen demonneed0607 = 45906.64-efc0607 if dc_prefclassyr==2008 | dc_prefclassyr==2009| dc_prefclassyr==2010|dc_prefclassyr==2007;
replace demonneed0607= 0 if demonneed0607==. | demonneed0607<0;
gen demonneed0708= 46935.90-efc0708 if dc_prefclassyr==2008 | dc_prefclassyr==2009| dc_prefclassyr==2010|dc_prefclassyr==2011 ;
replace demonneed0708= 0 if demonneed0708==. | demonneed0708<0;
gen demonneed0809= 48287.12-efc0809  if dc_prefclassyr==2012 | dc_prefclassyr==2009| dc_prefclassyr==2010|dc_prefclassyr==2011;
replace demonneed0809= 0 if demonneed0809==. | demonneed0809<0;
gen demonneed0910= 50060.36-efc0910  if dc_prefclassyr==2012 | dc_prefclassyr==2013| dc_prefclassyr==2010|dc_prefclassyr==2011;
replace demonneed0910= 0 if demonneed0910==. | demonneed0910<0;
gen demonneed1011 = 51477.71-efc1011  if dc_prefclassyr==2012 |dc_prefclassyr==2011|dc_prefclassyr==2013;
replace demonneed1011= 0 if demonneed1011==. | demonneed1011<0;
gen demonneed1112 = 53144.83-efc1112  if dc_prefclassyr==2012 |dc_prefclassyr==2013 ;
replace demonneed1112= 0 if demonneed1112==. | demonneed1112<0;
gen demonneed1213= 54655.00-efc1213 if dc_prefclassyr==2013;
replace demonneed1213= 0 if demonneed1213==. | demonneed1213<0;

gen simulloan0001= 5000 if demonneed0001>=5000;
replace simulloan0001= demonneed0001 if demonneed0001<5000 & demonneed0001>=0;
replace simulloan0001= 0 if demonneed0001<0;
gen simulloan0102= 5000 if demonneed0102>=5000;
replace simulloan0102= demonneed0102 if demonneed0102<5000 & demonneed0102>=0;
replace simulloan0102= 0 if demonneed0102<0;
gen simulloan0203= 5000 if demonneed0203>=5000;
replace simulloan0203= demonneed0203 if demonneed0203<5000 & demonneed0203>=0;
replace simulloan0203= 0 if demonneed0203<0;
gen simulloan0304= 5000 if demonneed0304>=5000;
replace simulloan0304= demonneed0304 if demonneed0304<5000 & demonneed0304>=0;
replace simulloan0304= 0 if demonneed0304<0;
gen simulloan0405= 5000 if demonneed0405>=5000;
replace simulloan0405= demonneed0405 if demonneed0405<5000 & demonneed0405>=0;
replace simulloan0405= 0 if demonneed0405<0;
gen simulloan0506= 5000 if demonneed0506>=5000;
replace simulloan0506= demonneed0506 if demonneed0506<5000 & demonneed0506>=0;
replace simulloan0506= 0 if demonneed0506<0;
gen simulloan0607= 5000 if demonneed0607>=5000;
replace simulloan0607= demonneed0607 if demonneed0607<5000 & demonneed0607>=0;
replace simulloan0607= 0 if demonneed0607<0;
gen simulloan0708= 5000 if demonneed0708>=5000;
replace simulloan0708= demonneed0708 if demonneed0708<5000 & demonneed0708>=0;
replace simulloan0708= 0 if demonneed0708<0;
gen simulloan0910= 5000 if demonneed0809>=5000;
replace simulloan0910= demonneed0809 if demonneed0809<5000 & demonneed0809>=0;
replace simulloan0910= 0 if demonneed0809<0;
gen simulloan0809= 5000 if demonneed0910>=5000;
replace simulloan0809= demonneed0910 if demonneed0910<5000 & demonneed0910>=0;
replace simulloan0809= 0 if demonneed0910<0;
gen simulloan1011= 5000 if demonneed1011>=5000;
replace simulloan1011= demonneed1011 if demonneed1011<5000 & demonneed1011>=0;
replace simulloan1011= 0 if demonneed1011<0;
gen simulloan1112= 5000 if demonneed1112>=5000;
replace simulloan1112= demonneed1112 if demonneed1112<5000 & demonneed1112>=0;
replace simulloan1112= 0 if demonneed1112<0;
gen simulloan1213= 5000 if demonneed1213>=5000;
replace simulloan1213= demonneed1213 if demonneed1213<5000 & demonneed1213>=0;
replace simulloan1213= 0 if demonneed1213<0;
*/







/*New variables:*/
/*accounting for inflation in 2017 fiures*/
replace fy16_givingtotal_hh = fy16_givingtotal_hh*1.01;
replace fy15_givingtotal_hh = fy15_givingtotal_hh*1.03;
replace fy14_givingtotal_hh = fy14_givingtotal_hh*1.02;
replace fy13_givingtotal_hh = fy13_givingtotal_hh*1.04;
replace fy12_givingtotal_hh = fy12_givingtotal_hh*1.06;
replace fy11_givingtotal_hh = fy11_givingtotal_hh*1.08;
replace fy10_givingtotal_hh = fy10_givingtotal_hh*1.11;
replace fy09_givingtotal_hh = fy09_givingtotal_hh*1.14;
replace fy08_givingtotal_hh = fy08_givingtotal_hh*1.13;
replace fy07_givingtotal_hh = fy07_givingtotal_hh*1.17;
replace fy06_givingtotal_hh = fy06_givingtotal_hh*1.21;
replace fy05_givingtotal_hh = fy05_givingtotal_hh*1.25;
replace fy04_givingtotal_hh = fy04_givingtotal_hh*1.29;


replace efc0001= efc0001*1.42;
replace efc0102=efc0102*1.37;
replace efc0203= efc0203*1.35;
replace efc0304=efc0304*1.32;
replace efc0405= efc0405*1.29;
replace efc0506= efc0506*1.25;
replace efc0607=efc0607*1.21;
replace efc0708= efc0708*1.17;
replace efc0809=efc0809*1.13;
replace efc0910=efc0910*1.14;
replace efc1011= efc1011*1.11;
replace efc1112=efc1112*1.08;
replace efc1213=efc1213*1.06;

replace total_efc= efc0001 + efc0102 + efc0203 + efc0304 + efc0405 + efc0405 + efc0506 + efc0607 + efc0708 + efc0809 + efc0910 + efc1011 + efc1112 + efc1213;


replace demonneed0001= "0" if demonneed0001 =="n/a" ;
replace demonneed0102= "0"  if demonneed0102 =="n/a";
replace demonneed0203=  "0"  if demonneed0203 =="n/a";
replace demonneed0304= "0"  if demonneed0304 =="n/a";
replace demonneed0405=  "0"  if demonneed0405 =="n/a";
replace demonneed0506=  "0"  if demonneed0506 =="n/a";
replace demonneed0607= "0" if demonneed0607 =="n/a";
replace demonneed0708=  "0"  if demonneed0708 =="n/a";
replace demonneed0809= "0"  if demonneed0809 =="n/a";
replace demonneed0910= "0"  if demonneed0910 =="n/a";
replace demonneed1011="0"  if demonneed1011 =="n/a";
replace demonneed1112= "0"  if demonneed1112 =="n/a";
replace demonneedefc1213= "0"  if demonneedefc1213 =="n/a";

destring demonneed0001, replace;
destring demonneed0102, replace;
destring demonneed0203, replace;
destring demonneed0304, replace;
destring demonneed0405, replace;
destring demonneed0506, replace;
destring demonneed0607, replace;
destring demonneed0708, replace;
destring demonneed0809, replace;
destring demonneed0910, replace;
destring demonneed1011, replace;
destring demonneed1112, replace;
destring demonneedefc1213, replace;

replace demonneed0001= demonneed0001*1.42;
replace demonneed0102=demonneed0102*1.37;
replace demonneed0203= demonneed0203*1.35;
replace demonneed0304=demonneed0304*1.32;
replace demonneed0405=demonneed0405*1.25;
replace demonneed0506= demonneed0506*1.21;
replace demonneed0607=demonneed0607*1.17;
replace demonneed0708= demonneed0708*1.13;
replace demonneed0809=demonneed0809*1.14;
replace demonneed0910=demonneed0910*1.11;
replace demonneed1011=demonneed1011*1.08;
replace demonneed1112=demonneed1112*1.06;
replace demonneedefc1213=demonneedefc1213*1.04;

replace total_demonneed= demonneed0001 + demonneed0102+ demonneed0203 + demonneed0304 + demonneed0405 + demonneed0506 + demonneed0607 + demonneed0708+ demonneed0809  + demonneed0910 + demonneed1011+ demonneed1112 + demonneedefc1213  ;
replace total_demonneed=0 if total_demonneed<0;

replace simulloan0001= "0" if simulloan0001 =="n/a" ;
replace simulloan0102= "0"  if simulloan0102 =="n/a";
replace simulloan0203=  "0"  if simulloan0203 =="n/a";
replace simulloan0304= "0"  if simulloan0304 =="n/a";
replace simulloan0405=  "0"  if simulloan0405 =="n/a";
replace simulloan0506=  "0"  if simulloan0506 =="n/a";
replace simulloan0607= "0" if simulloan0607 =="n/a";

destring simulloan0001, replace;
destring simulloan0102, replace;
destring simulloan0203, replace;
destring simulloan0304, replace;
destring simulloan0405, replace;
destring simulloan0506, replace;
destring simulloan0607, replace;

replace simulloan0001= 5000 if demonneed0001>=5000;
replace simulloan0001= demonneed0001 if demonneed0001<5000 & demonneed0001>=0;
replace simulloan0001= 0 if demonneed0001<0;
replace simulloan0102= 5000 if demonneed0102>=5000;
replace simulloan0102= demonneed0102 if demonneed0102<5000 & demonneed0102>=0;
replace simulloan0102= 0 if demonneed0102<0;
replace simulloan0203= 5000 if demonneed0203>=5000;
replace simulloan0203= demonneed0203 if demonneed0203<5000 & demonneed0203>=0;
replace simulloan0203= 0 if demonneed0203<0;
replace simulloan0304= 5000 if demonneed0304>=5000;
replace simulloan0304= demonneed0304 if demonneed0304<5000 & demonneed0304>=0;
replace simulloan0304= 0 if demonneed0304<0;
replace simulloan0405= 5000 if demonneed0405>=5000;
replace simulloan0405= demonneed0405 if demonneed0405<5000 & demonneed0405>=0;
replace simulloan0405= 0 if demonneed0405<0;
replace simulloan0506= 5000 if demonneed0506>=5000;
replace simulloan0506= demonneed0506 if demonneed0506<5000 & demonneed0506>=0;
replace simulloan0506= 0 if demonneed0506<0;
replace simulloan0607= 5000 if demonneed0607>=5000;
replace simulloan0607= demonneed0607 if demonneed0607<5000 & demonneed0607>=0;
replace simulloan0607= 0 if demonneed0607<0;
replace simulloan0708= 5000 if demonneed0708>=5000;
replace simulloan0708= demonneed0708 if demonneed0708<5000 & demonneed0708>=0;
replace simulloan0708= 0 if demonneed0708<0;
replace simulloan0910= 5000 if demonneed0809>=5000;
replace simulloan0910= demonneed0809 if demonneed0809<5000 & demonneed0809>=0;
replace simulloan0910= 0 if demonneed0809<0;
replace simulloan0809= 5000 if demonneed0910>=5000;
replace simulloan0809= demonneed0910 if demonneed0910<5000 & demonneed0910>=0;
replace simulloan0809= 0 if demonneed0910<0;
replace simulloan1011= 5000 if demonneed1011>=5000;
replace simulloan1011= demonneed1011 if demonneed1011<5000 & demonneed1011>=0;
replace simulloan1011= 0 if demonneed1011<0;
replace simulloan1112= 5000 if demonneed1112>=5000;
replace simulloan1112= demonneed1112 if demonneed1112<5000 & demonneed1112>=0;
replace simulloan1112= 0 if demonneed1112<0;
replace simulloan1213= 5000 if demonneedefc1213>=5000;
replace simulloan1213= demonneedefc1213 if demonneedefc1213<5000 & demonneedefc1213>=0;
replace simulloan1213= 0 if demonneedefc1213<0;

replace simulloan0001= simulloan0001*1.42;
replace simulloan0102=simulloan0102*1.37;
replace simulloan0203= simulloan0203*1.35;
replace simulloan0304=simulloan0304*1.32;
replace simulloan0405=simulloan0405*1.25;
replace simulloan0506= simulloan0506*1.21;
replace simulloan0607=simulloan0607*1.17;
replace simulloan0708= simulloan0708*1.13;
replace simulloan0809=simulloan0809*1.14;
replace simulloan0910=simulloan0910*1.11;
replace simulloan1011=simulloan1011*1.08;
replace simulloan1112=simulloan1112*1.06;
replace simulloan1213=simulloan1213*1.04;*/

gen total_simulatedloans= simulloan0001 + simulloan0102+simulloan0203+ simulloan0304 +simulloan0405+ simulloan0506+ simulloan0607 +simulloan0708 +simulloan0809+simulloan0910+ simulloan1011+ simulloan1112+ simulloan1213;

replace loan0001= loan0001*1.42;
replace loan0102=loan0102*1.37;
replace loan0203= loan0203*1.35;
replace loan0304=loan0304*1.32;
replace loan0405=loan0405*1.25;
replace loan0506= loan0506*1.21;
replace loan0607=loan0607*1.17;
replace loan0708= loan0708*1.13;
replace loan0809=loan0809*1.14;
replace loan0910=loan0910*1.11;
replace loan1011=loan1011*1.08;
replace loan1112=loan1112*1.06;
replace loan1213=loan1213*1.04;

replace total_loan= loan0001 + loan0001 +  loan0203 +  loan0304 +  loan0405 +  loan0506 +  loan0607 +  loan0708 +  loan0809  + loan0910  + loan1011 +  loan1112 +  loan1213;



/*amount of giving in first five years out of college*/
gen amount_give_fiveyear=0;
replace amount_give_fiveyear=fy16_givingtotal_hh+fy15_givingtotal_hh+fy14_givingtotal_hh+fy13_givingtotal_hh+fy12_givingtotal_hh if dc_prefclassyr==2012;
replace amount_give_fiveyear=fy15_givingtotal_hh+fy14_givingtotal_hh+fy13_givingtotal_hh+fy12_givingtotal_hh+fy11_givingtotal_hh if dc_prefclassyr==2011;
replace amount_give_fiveyear=fy14_givingtotal_hh+fy13_givingtotal_hh+fy12_givingtotal_hh+fy11_givingtotal_hh+fy10_givingtotal_hh if dc_prefclassyr==2010;
replace amount_give_fiveyear=fy13_givingtotal_hh+fy12_givingtotal_hh+fy11_givingtotal_hh+fy10_givingtotal_hh+fy09_givingtotal_hh if dc_prefclassyr==2009;
replace amount_give_fiveyear=fy12_givingtotal_hh+fy11_givingtotal_hh+fy10_givingtotal_hh+fy09_givingtotal_hh+fy08_givingtotal_hh if dc_prefclassyr==2008;
replace amount_give_fiveyear=fy11_givingtotal_hh+fy10_givingtotal_hh+fy09_givingtotal_hh+fy08_givingtotal_hh+fy07_givingtotal_hh if dc_prefclassyr==2007;
replace amount_give_fiveyear=fy10_givingtotal_hh+fy09_givingtotal_hh+fy08_givingtotal_hh+fy07_givingtotal_hh+fy06_givingtotal_hh if dc_prefclassyr==2006;
replace amount_give_fiveyear=fy09_givingtotal_hh+fy08_givingtotal_hh+fy07_givingtotal_hh+fy06_givingtotal_hh+fy05_givingtotal_hh if dc_prefclassyr==2005;
replace amount_give_fiveyear=fy08_givingtotal_hh+fy07_givingtotal_hh+fy06_givingtotal_hh+fy05_givingtotal_hh+fy04_givingtotal_hh if dc_prefclassyr==2004;

/*did you give in first five years out of college*/
gen did_give_fiveyear=0;
replace did_give_fiveyear=1 if  amount_give_fiveyear>0 ;

/*amount of giving in first four years out of college excluding first year*/
gen amount_give_fouryear=0;
replace amount_give_fouryear=fy16_givingtotal_hh+fy15_givingtotal_hh+fy14_givingtotal_hh+fy13_givingtotal_hh if dc_prefclassyr==2012;
replace amount_give_fouryear=fy15_givingtotal_hh+fy14_givingtotal_hh+fy13_givingtotal_hh+fy12_givingtotal_hh if dc_prefclassyr==2011;
replace amount_give_fouryear=fy14_givingtotal_hh+fy13_givingtotal_hh+fy12_givingtotal_hh+fy11_givingtotal_hh if dc_prefclassyr==2010;
replace amount_give_fouryear=fy13_givingtotal_hh+fy12_givingtotal_hh+fy11_givingtotal_hh+fy10_givingtotal_hh if dc_prefclassyr==2009;
replace amount_give_fouryear=fy12_givingtotal_hh+fy11_givingtotal_hh+fy10_givingtotal_hh+fy09_givingtotal_hh if dc_prefclassyr==2008;
replace amount_give_fouryear=fy11_givingtotal_hh+fy10_givingtotal_hh+fy09_givingtotal_hh+fy08_givingtotal_hh if dc_prefclassyr==2007;
replace amount_give_fouryear=fy10_givingtotal_hh+fy09_givingtotal_hh+fy08_givingtotal_hh+fy07_givingtotal_hh if dc_prefclassyr==2006;
replace amount_give_fouryear=fy09_givingtotal_hh+fy08_givingtotal_hh+fy07_givingtotal_hh+fy06_givingtotal_hh if dc_prefclassyr==2005;
replace amount_give_fouryear=fy08_givingtotal_hh+fy07_givingtotal_hh+fy06_givingtotal_hh+fy05_givingtotal_hh if dc_prefclassyr==2004;


/*did you give in first four years out of college exluding first year*/
gen did_give_fouryear=0;
replace did_give_fouryear=1 if  amount_give_fouryear>0 ;

/*amount of giving in first four years out of college including first year*/
gen amount_give_fifouryear=0;
replace amount_give_fifouryear=fy16_givingtotal_hh+fy15_givingtotal_hh+fy14_givingtotal_hh+fy13_givingtotal_hh if dc_prefclassyr==2013;
replace amount_give_fifouryear=fy12_givingtotal_hh+fy15_givingtotal_hh+fy14_givingtotal_hh+fy13_givingtotal_hh if dc_prefclassyr==2012;
replace amount_give_fifouryear=fy11_givingtotal_hh+fy14_givingtotal_hh+fy13_givingtotal_hh+fy12_givingtotal_hh if dc_prefclassyr==2011;
replace amount_give_fifouryear=fy10_givingtotal_hh+fy13_givingtotal_hh+fy12_givingtotal_hh+fy11_givingtotal_hh if dc_prefclassyr==2010;
replace amount_give_fifouryear=fy09_givingtotal_hh+fy12_givingtotal_hh+fy11_givingtotal_hh+fy10_givingtotal_hh if dc_prefclassyr==2009;
replace amount_give_fifouryear=fy08_givingtotal_hh+fy11_givingtotal_hh+fy10_givingtotal_hh+fy09_givingtotal_hh if dc_prefclassyr==2008;
replace amount_give_fifouryear=fy07_givingtotal_hh+fy10_givingtotal_hh+fy09_givingtotal_hh+fy08_givingtotal_hh if dc_prefclassyr==2007;
replace amount_give_fifouryear=fy06_givingtotal_hh+fy09_givingtotal_hh+fy08_givingtotal_hh+fy07_givingtotal_hh if dc_prefclassyr==2006;
replace amount_give_fifouryear=fy05_givingtotal_hh+fy08_givingtotal_hh+fy07_givingtotal_hh+fy06_givingtotal_hh if dc_prefclassyr==2005;
replace amount_give_fifouryear=fy04_givingtotal_hh+fy07_givingtotal_hh+fy06_givingtotal_hh+fy05_givingtotal_hh if dc_prefclassyr==2004;

/*did you give in first four years out of college including first year*/
gen did_give_fifouryear=0;
replace did_give_fifouryear=1 if  amount_give_fifouryear>0 ;


/*with demonstrated need*/
gen didneed=0;
replace didneed=1 if total_demonneed>0;

/*not in sample*/
drop if didneed==0 & total_simulatedloans!=0;



gen ethnicity_n= 0 if ethnicity ==14;
replace ethnicity_n=1 if ethnicity>=1 & ethnicity<=3;
replace ethnicity_n=1 if ethnicity==5;
replace ethnicity_n=1 if ethnicity>=7 & ethnicity<=10;
replace ethnicity_n=1 if ethnicity>=12 & ethnicity<=13;
replace ethnicity_n=1 if ethnicity==15;
replace ethnicity_n=2 if ethnicity==16;
replace ethnicity_n=2 if ethnicity==4;
replace ethnicity_n=2 if ethnicity==6;
replace ethnicity_n=2 if ethnicity==11;

gen ethnicity_nw= 1 if ethnicity_n==0;
replace ethnicity_nw=1 if ethnicity_n==1;
replace ethnicity_nw=1 if ethnicity== . & primaryaddresscountry != "United States";
replace ethnicity_nw=0 if ethnicity_n==2;
replace ethnicity_nw=0 if ethnicity == . & dc_prefclassyr < 1963;
replace ethnicity_nw = . if ethnicity_nw!=0 & ethnicity_nw!=1 & ethnicity== . ;


gen parent= 1 if parent_constituency!= ".";
replace parent =0 if parent_constituency =="." ;










/*Regression Variables:*/

/*log of giving*/
gen lnamount_give_fiveyear=ln(amount_give_fiveyear + 1);
gen lnamount_give_fouryear=ln(amount_give_fouryear + 1);
gen lnamount_give_fifouryear=ln(amount_give_fifouryear + 1);

/*prospect manager*/
gen prospect =0 if prospect_manager== "No";
replace prospect =0 if prospect_manager== "No Fundraiser";
replace prospect =0 if prospect_manager== "Unassigned";
replace prospect =1 if prospect != 0;



/*creating post trust variable*/
generate posttrust=0;
replace posttrust=1 if dc_prefclassyr>2007;

/*variable for social organization*/
gen soc=1 if social_org!="#N/A" & social_org!="0";
replace soc=0 if social_org=="0";
replace soc=0 if social_org=="#N/A";


/*Standardizing SAT and ACT scores*/
sum sattotal;
scalar satmean= r(mean);
scalar satsd= r(sd);
gen satstand= (sattotal-satmean)/satsd;
*gen satstand= (sattotal-satmean/satsd);

sum act;
scalar actmean= r(mean);
scalar actsd= r(sd);
gen actstand= (act-actmean)/actsd;


/*demographic variables*/
gen female=1 if gender==0;
replace female=0 if gender==1;

gen married=1 if maritalstatus==2;
replace married=0 if maritalstatus!=2;

gen years_out2= years_out*years_out;

tab ethnicity, gen(eth) missing;

global ethnicityvars "eth1 eth2 eth3 eth4 eth5 eth6 eth7 eth8 eth9 eth10 eth11 eth13";

tab ethnicity_nw, gen(neweth) missing;

global newethnicityvars " eth2 eth3"; 

gen ethnicity_nn= 1 if ethnicity_n ==1;
replace ethnicity_nn=1 if ethnicity_n==0;
replace ethnicity_nn=0 if ethnicity_n==2;
replace ethnicity_nn=2 if ethnicity_n==.;


gen big_state="North Carolina" if  primaryaddressstate=="North Carolina";
replace big_state="South Carolina" if  primaryaddressstate=="South Carolina";
replace big_state="Georgia" if  primaryaddressstate=="Georgia";
replace big_state="Virginia" if  primaryaddressstate=="Virginia";
replace big_state="Other" if  primaryaddressstate!="South Carolina" & primaryaddressstate!="Virginia" &  primaryaddressstate!="Georgia" & primaryaddressstate!="North Carolina";

tab big_state, gen(state);

global statevars "state1 state2 state4 state5 ";



/*academic variables*/

replace major="." if major=="#N/A";
replace major="." if major=="0";                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
replace major="." if major=="03";
replace major="." if major=="04";
replace major="." if major=="06";
replace major="." if major=="11";
replace major="." if major=="3-2";

tab major, gen(mjr) missing;

gen natsocsciencemjr= 0;
replace natsocsciencemjr= 1 if mjr16==1;
replace natsocsciencemjr=1 if mjr4==1;
replace natsocsciencemjr=1 if mjr5==1;
replace natsocsciencemjr=1 if mjr18==1;
replace natsocsciencemjr=1 if mjr17==1;
replace natsocsciencemjr=1 if mjr6==1;


gen econmjr=0;
replace econmjr=1 if mjr8==1;


gen mathmjr=0;
replace mathmjr=1 if mjr13==1;

gen fineartsmjr=0;
replace fineartsmjr=1 if mjr3==1;

gen humanitiesmjr=0;
replace humanitiesmjr=1 if  mjr12==1;
replace humanitiesmjr=1 if mjr2==1;
replace humanitiesmjr=1 if mjr7==1;
replace humanitiesmjr=1 if mjr9==1;
replace humanitiesmjr=1 if mjr10==1;
replace humanitiesmjr=1 if mjr11==1;
replace humanitiesmjr=1 if mjr12==1;
replace humanitiesmjr=1 if mjr14==1;
replace humanitiesmjr=1 if mjr16==1;
replace humanitiesmjr=1 if mjr20==1;
replace humanitiesmjr=1 if mjr21==1;
replace humanitiesmjr=1 if mjr22==1;
replace humanitiesmjr=1 if mjr19==1;



gen davdegree=1 if degree=="Bachelor of Science";
replace davdegree=0 if degree=="Bachelor of Arts";

tab davdegree, gen(bos);



global majorvars "natsocsciencemjr mathmjr fineartsmjr humanitiesmjr";
 


/*income controls*/
gen median_income_households2= median_income_households*median_income_households;

gen lnmedian_income_households= ln(median_income_households);

/*Controls*/
global demcontrols "years_out years_out2 female $ethnicityvars married $statevars ";
global incomecontrols "lnmedian_income_households total_efc cum_gpa satstand $majorvars";
global addcontrols "soc prospect";
global controls "years_out years_out2 female $ethnicityvars lnmedian_income_households total_efc cum_gpa married soc prospect satstand $majorvars $statevars";
global amcontrols "years_out years_out2 female $ethnicityvars lnmedian_income_households total_efc cum_gpa satstand married $majorvars $statevars";



/*Descriptive Statistics*/ 
logout, save(newsumgentable) excel replace: sum gender years_out is_athlete cum_gpa total_efc total_demonneed total_simulatedloans total_loan amount_give_fiveyear amount_give_fifouryear amount_give_fouryear did_give_fifouryear did_give_fiveyear did_give_fouryear didneed prospect posttrust soc married eth1 eth2 eth3 eth4 eth5 eth6 eth7 eth8 eth9 eth10 eth11 eth12 eth13 state1 state2 state3 state4 state5 econmjr fineartsmjr humanitiesmjr natsocsciencemjr mathmjr;
logout, save(newsumdidtable1) excel replace: sum gender years_out is_athlete cum_gpa total_efc total_demonneed total_simulatedloans total_loan amount_give_fiveyear amount_give_fifouryear amount_give_fouryear did_give_fifouryear did_give_fiveyear did_give_fouryear didneed prospect posttrust soc married eth1 eth2 eth3 eth4 eth5 eth6 eth7 eth8 eth9 eth10 eth11 eth12 eth13 state1 state2 state3 state4 state5 econmjr fineartsmjr humanitiesmjr natsocsciencemjr mathmjr if posttrust==0 & didneed==0;
logout, save(sumdidtable2) excel replace: sum gender years_out is_athlete cum_gpa total_efc total_demonneed total_simulatedloans total_loan amount_give_fiveyear amount_give_fifouryear amount_give_fouryear did_give_fifouryear did_give_fiveyear did_give_fouryear didneed prospect posttrust soc married eth1 eth2 eth3 eth4 eth5 eth6 eth7 eth8 eth9 eth10 eth11 eth12 eth13 state1 state2 state3 state4 state5 econmjr fineartsmjr humanitiesmjr natsocsciencemjr mathmjr if posttrust==1 & didneed==0;
logout, save(sumdidtable3) excel replace: sum gender years_out is_athlete cum_gpa total_efc total_demonneed total_simulatedloans total_loan amount_give_fiveyear amount_give_fifouryear amount_give_fouryear did_give_fifouryear did_give_fiveyear did_give_fouryear didneed prospect posttrust soc married eth1 eth2 eth3 eth4 eth5 eth6 eth7 eth8 eth9 eth10 eth11 eth12 eth13 state1 state2 state3 state4 state5 econmjr fineartsmjr humanitiesmjr natsocsciencemjr mathmjr if posttrust==0 & didneed==1;
logout, save(sumdidtable4) excel replace: sum gender years_out is_athlete cum_gpa total_efc total_demonneed total_simulatedloans total_loan amount_give_fiveyear amount_give_fifouryear amount_give_fouryear did_give_fifouryear did_give_fiveyear did_give_fouryear didneed prospect posttrust soc married eth1 eth2 eth3 eth4 eth5 eth6 eth7 eth8 eth9 eth10 eth11 eth12 eth13 state1 state2 state3 state4 state5 econmjr fineartsmjr humanitiesmjr natsocsciencemjr mathmjr if posttrust==1 & didneed==1;


/*Regression Analysis*/

/*DID regressions*/
reg did_give_fiveyear didneed posttrust c.posttrust#c.didneed if dc_prefclassyr<2013, vce(cluster constituentlookupid);
outreg2 using DIDtable, excel replace;

reg did_give_fiveyear didneed posttrust c.posttrust#c.didneed $demcontrols if dc_prefclassyr<2013, vce(cluster constituentlookupid);
outreg2 using DIDtable, excel append;

reg did_give_fiveyear didneed posttrust c.posttrust#c.didneed $demcontrols $incomecontrols if dc_prefclassyr<2013, vce(cluster constituentlookupid);
outreg2 using DIDtable, excel append;

reg did_give_fiveyear didneed posttrust c.posttrust#c.didneed $controls if dc_prefclassyr<2013, vce(cluster constituentlookupid);
outreg2 using DIDtable, excel append;

reg did_give_fouryear didneed posttrust c.posttrust#c.didneed if dc_prefclassyr<2013,vce(cluster constituentlookupid);
outreg2 using DIDfourtable, word replace;

reg did_give_fouryear didneed posttrust c.posttrust#c.didneed $demcontrols if dc_prefclassyr<2013,  vce(cluster constituentlookupid);
outreg2 using DIDfourtable, word append;

reg did_give_fouryear didneed posttrust c.posttrust#c.didneed $demcontrols $incomecontrols if dc_prefclassyr<2013, vce(cluster constituentlookupid);
outreg2 using DIDfourtable, word append;

reg did_give_fouryear didneed posttrust c.posttrust#c.didneed $controls if dc_prefclassyr<2013,  vce(cluster constituentlookupid);
outreg2 using DIDfourtable, word append;

reg did_give_fifouryear didneed posttrust c.posttrust#c.didneed,  vce(cluster constituentlookupid);
outreg2 using DIDfifourtable, word replace;

reg did_give_fifouryear didneed posttrust c.posttrust#c.didneed $demcontrols,vce(cluster constituentlookupid);
outreg2 using DIDfifourtable, word append;

reg did_give_fifouryear didneed posttrust c.posttrust#c.didneed $demcontrols $incomecontrols,  vce(cluster constituentlookupid);
outreg2 using DIDfifourtable, word append;

reg did_give_fifouryear didneed posttrust c.posttrust#c.didneed $controls, vce(cluster constituentlookupid);
outreg2 using DIDfifourtable, word append;



/*IV regression*/
reg total_loan total_simulatedloans $controls if dc_prefclassyr<2013,  vce(cluster constituentlookupid);
test total_simulatedloans;
outreg2 using Fstagetable, excel replace;

ivregress 2sls did_give_fiveyear didneed posttrust (total_loan = total_simulatedloans) if dc_prefclassyr<2013, vce(cluster constituentlookupid);
outreg2 using IVtable, word replace;

ivregress 2sls did_give_fiveyear didneed posttrust $demcontrols (total_loan = total_simulatedloans) if dc_prefclassyr<2013, vce(cluster constituentlookupid);
outreg2 using IVtable, word append;

ivregress 2sls did_give_fiveyear didneed posttrust $demcontrols $incomecontrols (total_loan = total_simulatedloans) if dc_prefclassyr<2013, vce(cluster constituentlookupid);
outreg2 using IVtable, word append;

ivregress 2sls did_give_fiveyear didneed posttrust $controls (total_loan = total_simulatedloans) if dc_prefclassyr<2013,vce(cluster constituentlookupid);
outreg2 using IVtable, word append;

ivregress 2sls did_give_fouryear didneed posttrust (total_loan = total_simulatedloans) if dc_prefclassyr<2013, vce(cluster constituentlookupid);
outreg2 using IVfourtable, word replace;

ivregress 2sls did_give_fouryear didneed posttrust $demcontrols (total_loan = total_simulatedloans) if dc_prefclassyr<2013, vce(cluster constituentlookupid);
outreg2 using IVfourtable, word append;

ivregress 2sls did_give_fouryear didneed posttrust $demcontrols $incomecontrols (total_loan = total_simulatedloans) if dc_prefclassyr<2013,vce(cluster constituentlookupid);
outreg2 using IVfourtable, word append;

ivregress 2sls did_give_fouryear didneed posttrust $controls (total_loan = total_simulatedloans) if dc_prefclassyr<2013, vce(cluster constituentlookupid);
outreg2 using IVfourtable, word append;


ivregress 2sls did_give_fifouryear didneed posttrust (total_loan = total_simulatedloans), vce(cluster constituentlookupid);
outreg2 using IVfifourtable, word replace;

ivregress 2sls did_give_fifouryear didneed posttrust $demcontrols (total_loan = total_simulatedloans), vce(cluster constituentlookupid);
outreg2 using IVfifourtable, word append;
 
ivregress 2sls did_give_fifouryear didneed posttrust $demcontrols $incomecontrols (total_loan = total_simulatedloans), vce(cluster constituentlookupid);
outreg2 using IVfifourtable, word append;

ivregress 2sls did_give_fifouryear didneed posttrust $controls (total_loan = total_simulatedloans), vce(cluster constituentlookupid);
outreg2 using IVfifourtable, word append;


/*Probit Regression*/
reg total_loan total_simulatedloans didneed posttrust $controls if dc_prefclassyr<2013, r;
predict total_loanhat;

probit did_give_fiveyear total_loan didneed posttrust  $demcontrols if dc_prefclassyr<2013, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probittable, excel replace;

probit did_give_fiveyear total_loan didneed posttrust $demcontrols $incomecontrols if dc_prefclassyr<2013, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probittable, excel append;

probit did_give_fiveyear total_loan didneed posttrust $controls if dc_prefclassyr<2013, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probittable, excel append;


probit did_give_fiveyear total_loanhat didneed posttrust if dc_prefclassyr<2013,vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probittable, excel append;

probit did_give_fiveyear total_loanhat didneed posttrust $demcontrols if dc_prefclassyr<2013, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probittable, excel append;

probit did_give_fiveyear total_loanhat didneed posttrust $demcontrols $incomecontrols if dc_prefclassyr<2013, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probittable, excel append;

probit did_give_fiveyear total_loanhat didneed posttrust $controls if dc_prefclassyr<2013,vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probittable, excel append;

probit did_give_fouryear total_loan didneed posttrust $demcontrols if dc_prefclassyr<2013, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probitfourtable, excel replace;

probit did_give_fouryear total_loan didneed posttrust $demcontrols $incomecontrols if dc_prefclassyr<2013, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probitfourtable, excel append;

probit did_give_fouryear total_loan didneed posttrust $controls if dc_prefclassyr<2013, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probitfourtable, excel append;


probit did_give_fouryear total_loanhat didneed posttrust $demcontrols if dc_prefclassyr<2013, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probitfourtable, excel append;

probit did_give_fouryear total_loanhat didneed posttrust $demcontrols $incomecontrols if dc_prefclassyr<2013,vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probitfourtable, excel append;

probit did_give_fouryear total_loanhat didneed posttrust $controls if dc_prefclassyr<2013, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probitfourtable, excel append;

probit did_give_fifouryear total_loan didneed posttrust $demcontrols, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probitfifourtable, excel replace;

probit did_give_fifouryear total_loan didneed posttrust $demcontrols $incomecontrols, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probitfifourtable, excel append;

probit did_give_fifouryear total_loan didneed posttrust $controls, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probitfifourtable, excel append;



probit did_give_fifouryear total_loanhat didneed posttrust $demcontrols, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probitfifourtable, excel append;

probit did_give_fifouryear total_loanhat didneed posttrust $demcontrols $incomecontrols, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probitfifourtable, excel append;

probit did_give_fifouryear total_loanhat didneed posttrust $controls, vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using probitfifourtable, excel append;

/*IVProbit Regression*/

ivprobit did_give_fiveyear didneed posttrust (total_loan = total_simulatedloans) if dc_prefclassyr<2013, mle vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using ivprobittable, excel replace;

ivprobit did_give_fiveyear didneed posttrust $demcontrols (total_loan = total_simulatedloans) if dc_prefclassyr<2013, mle vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using ivprobittable, excel append;

ivprobit did_give_fiveyear didneed posttrust $demcontrols lnmedian_income_households total_efc satstand $majorvars (total_loan = total_simulatedloans) if dc_prefclassyr<2013, mle vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using ivprobittable, excel append;

ivprobit did_give_fiveyear didneed posttrust  $demcontrols lnmedian_income_households total_efc satstand $majorvars soc prospect (total_loan = total_simulatedloans) if dc_prefclassyr<2013, mle vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using ivprobittable, excel append;
*/

ivprobit did_give_fouryear didneed posttrust (total_loan = total_simulatedloans) if dc_prefclassyr<2013, mle vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using ivprobitfourtable, excel replace;

ivprobit did_give_fouryear didneed posttrust $demcontrols (total_loan = total_simulatedloans) if dc_prefclassyr<2013, mle vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using ivprobitfourtable, excel append;

ivprobit did_give_fouryear didneed posttrust $demcontrols lnmedian_income_households total_efc satstand $majorvars (total_loan = total_simulatedloans) if dc_prefclassyr<2013, mle vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using ivprobitfourtable, excel append;

ivprobit did_give_fouryear didneed posttrust $demcontrols lnmedian_income_households total_efc satstand $majorvars soc prospect  (total_loan = total_simulatedloans) if dc_prefclassyr<2013, mle vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using ivprobitfourtable, excel append;

ivprobit did_give_fifouryear didneed posttrust (total_loan = total_simulatedloans), mle vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using ivprobitfifourtable, excel replace;

ivprobit did_give_fifouryear didneed posttrust $demcontrols (total_loan = total_simulatedloans), mle vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using ivprobitfifourtable, excel append;

ivprobit did_give_fifouryear didneed posttrust $demcontrols lnmedian_income_households total_efc satstand $majorvars (total_loan = total_simulatedloans), mle vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using ivprobitfifourtable, excel append;

ivprobit did_give_fifouryear didneed posttrust $demcontrols lnmedian_income_households total_efc satstand $majorvars soc prospect (total_loan = total_simulatedloans), mle vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using ivprobitfifourtable, excel append;



/*Tobit regression*/
tobit lnamount_give_fiveyear total_loanhat didneed posttrust if dc_prefclassyr<2013, ll(0) vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using tobittable, excel replace;

tobit lnamount_give_fiveyear total_loanhat didneed posttrust $demcontrols if dc_prefclassyr<2013, ll(0) vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using tobittable, excel append;

tobit lnamount_give_fiveyear total_loanhat didneed posttrust $demcontrols $incomecontrols if dc_prefclassyr<2013, ll(0) vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using tobittable, excel append;

tobit lnamount_give_fiveyear total_loanhat didneed posttrust $controls if dc_prefclassyr<2013, ll(0) vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using tobittable, excel append;

tobit lnamount_give_fouryear total_loanhat didneed posttrust if dc_prefclassyr<2013, ll(0) vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using tobitfourtable, excel replace;

tobit lnamount_give_fouryear total_loanhat didneed posttrust $demcontrols if dc_prefclassyr<2013, ll(0) vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using tobitfourtable, excel append;

tobit lnamount_give_fouryear total_loanhat didneed posttrust $demcontrols $incomecontrols if dc_prefclassyr<2013, ll(0) vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using tobitfourtable, excel append;

tobit lnamount_give_fouryear total_loanhat didneed posttrust $controls if dc_prefclassyr<2013, ll(0) vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using tobitfourtable, excel append;

tobit lnamount_give_fifouryear total_loanhat didneed posttrust, ll(0) vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using tobitfifourtable, excel replace;

tobit lnamount_give_fifouryear total_loanhat didneed posttrust $demcontrols, ll(0) vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using tobitfifourtable, excel append;

tobit lnamount_give_fifouryear total_loanhat didneed posttrust $demcontrols $incomecontrols, ll(0) vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using tobitfifourtable, excel append;

tobit lnamount_give_fifouryear total_loanhat didneed posttrust $controls, ll(0) vce(cluster constituentlookupid);
margins, dydx(*) pred(pr) post;
outreg2 using tobitfifourtable, excel append;

/*hurdle table*/



churdle exp lnamount_give_fiveyear total_loanhat didneed posttrust $demcontrols if dc_prefclassyr<2013, select(total_loanhat didneed posttrust  $controls) ll(0) vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using hurdletable, excel replace;

churdle exp lnamount_give_fiveyear total_loanhat didneed posttrust $demcontrols  $incomecontrols if dc_prefclassyr<2013, select(total_loanhat didneed posttrust $controls) ll(0) vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using hurdletable, excel append;

churdle exp lnamount_give_fiveyear total_loanhat didneed posttrust $controls if dc_prefclassyr<2013, select(total_loanhat didneed posttrust $controls) ll(0) vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using hurdletable, excel append;



churdle exp lnamount_give_fouryear total_loanhat didneed posttrust years_out years_out2 female $ethnicityvars married if dc_prefclassyr<2013, select(total_loanhat didneed posttrust years_out years_out2 female $ethnicityvars lnmedian_income_households total_efc cum_gpa married soc prospect satstand) ll(0) vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using hurdlefourtable, excel replace;

churdle exp lnamount_give_fouryear total_loanhat didneed posttrust years_out years_out2 female $ethnicityvars married  lnmedian_income_households total_efc cum_gpa satstand if dc_prefclassyr<2013, select(total_loanhat didneed posttrust years_out years_out2 female $ethnicityvars lnmedian_income_households total_efc cum_gpa married soc prospect satstand) ll(0) vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using hurdlefourtable, excel append;

churdle exp lnamount_give_fouryear total_loanhat didneed posttrust years_out years_out2 female $ethnicityvars lnmedian_income_households total_efc cum_gpa married soc prospect if dc_prefclassyr<2013, select(total_loanhat didneed posttrust years_out years_out2 female $ethnicityvars lnmedian_income_households total_efc cum_gpa married soc prospect satstand) ll(0) vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using hurdlefourtable, excel append;




churdle exp lnamount_give_fifouryear total_loanhat didneed posttrust years_out years_out2 female married, select(total_loanhat didneed posttrust years_out years_out2 female $ethnicityvars lnmedian_income_households total_efc cum_gpa married soc prospect satstand) ll(0) vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using hurdlefifourtable, excel replace;

churdle exp lnamount_give_fifouryear total_loanhat didneed posttrust years_out years_out2 female married  lnmedian_income_households total_efc cum_gpa satstand, select(total_loanhat didneed posttrust years_out years_out2 female $ethnicityvars lnmedian_income_households total_efc cum_gpa married soc prospect satstand) ll(0) vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using hurdlefifourtable, excel append;

churdle exp lnamount_give_fifouryear total_loanhat didneed posttrust years_out years_out2 female lnmedian_income_households total_efc cum_gpa married soc prospect, select(total_loanhat didneed posttrust years_out years_out2 female $ethnicityvars lnmedian_income_households total_efc cum_gpa married soc prospect satstand) ll(0) vce(cluster constituentlookupid);
margins, dydx(*) post;
outreg2 using hurdlefifourtable, excel append;


log close;  /* close the log file  */
#delimit cr /* return the signal for end of each line to the default of Carriage Return  */


