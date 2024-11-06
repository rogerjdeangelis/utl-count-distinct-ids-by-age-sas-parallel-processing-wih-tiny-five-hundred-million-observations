%let pgm=utl-count-distinct-ids-by-age-sas-parallel-processing-wih-tiny-five-hundred-million-observations;

Count distinct ids by age using sas parallel processing wih five hundred million observations 43 seconds

github
https://tinyurl.com/43yvwj85
https://github.com/rogerjdeangelis/utl-count-distinct-ids-by-age-sas-parallel-processing-wih-tiny-five-hundred-million-observations

I do have an old cheap dell 7610 with 129gb ram, 32gb should be plenty.

Dataset is less than 12gb. I single table over 1tb is big data.

After buildong the data it took only 38 secons to get the count.

TIMINGS (processing took 43 seconds)

 SECONDS

    1.34    CREATE DATA WITH INDEX ON THE 8 RACES

    0.38    8 paralell tasks (total time 38 seconds)
    0.05    create view (set 8 outputs together (yoy can
            Best to put together in sort order ASIAN CZECH DUTCH GREEK IRISH MALAY SWISS WELSH
    ====
    0.43    Processing time

FYI

/*--- this is from my autoexec and is used to create input  ---*/
/*--- see end of message for more autoexec macro variables  ---*/

%let states50q="AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT",
"NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY";

/*               _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
*/

/**************************************************************************************************************************/
/*                                    |                                                             |                     */
/*                                    |                                                             |                     */
/*              INPUT                 |                  PROCESS                                    |    OUTPUT           */
/*              =====                 |                  =======                                    |    =====            */
/*                                    |                                                             |                     */
/* MSD1.MILLION500 obs=500,000,000    |1 create input 500 million obs with index on race            |                     */
/*                            UNIQUE_ |                                                             |                     */
/*       Obs  RACE   AGE SEX STA   ID |2 create sql macro and place                                 | FSD1.SWISS  obs=100 */
/*                                    |  in autocall library                                        |                     */
/*         1  ASIAN   1   F  AL   159 |                                                             |  RACE   AGE COUNT   */
/*         2  ASIAN   1   F  AL   401 |  filename ft15f001 "c:/oto/getcnt.sas";                     |                     */
/*         3  ASIAN   1   F  AL   955 |  parmcards4;                                                |  SWISS    1  1000   */
/*         4  ASIAN   1   F  AL   546 |  %macro getcnt(race,var);                                   |  SWISS    2  1000   */
/*         5  ASIAN   1   F  AL   468 |  libname fsd1 "f:/sd1";                                     |  SWISS    3  1000   */
/*         6  ASIAN   1   F  AL   579 |  libname msd1 "m:/sd1";                                     |  SWISS    4  1000   */
/*         7  ASIAN   1   F  AL   378 |  /*---                                                      |                     */
/*         8  ASIAN   1   F  AL   660 |    %let race=ASIAN;                                         |  SWISS   97  1000   */
/*         9  ASIAN   1   F  AL   789 |    %let var=AGE;                                            |  SWISS   98  1000   */
/*        10  ASIAN   1   F  AL   963 |  --*/                                                       |  SWISS   99  1000   */
/*                                    |  proc sql;                                                  |  SWISS  100  1000   */
/* 499999990  WELSH  100  M  WY    68 |    create                                                   |                     */
/* 499999991  WELSH  100  M  WY   233 |       table fsd1.&race as                                   |                     */
/* 499999992  WELSH  100  M  WY   455 |    select                                                   |                     */
/* 499999993  WELSH  100  M  WY   408 |       "&race" as race                                       |                     */
/* 499999994  WELSH  100  M  WY   532 |      ,&var                                                  |                     */
/* 499999995  WELSH  100  M  WY   843 |      ,count(distinct x) as count                            |                     */
/* 499999996  WELSH  100  M  WY   479 |    from                                                     |                     */
/* 499999997  WELSH  100  M  WY   846 |       msd1.million500                                       |                     */
/* 499999998  WELSH  100  M  WY   143 |    where                                                    |                     */
/* 499999999  WELSH  100  M  WY   371 |       race = "&race"                                        |                     */
/* 500000000  WELSH  100  M  WY   114 |    group                                                    |                     */
/*                                    |       by &var;                                              |                     */
/*                                    |      ;;;;                                                   |                     */
/*                                    |                                                             |                     */
/*                                    |3 call macro 8 time using once for each race systask batch   |                     */
/*                                    |  create 8 outputs                                           |                     */
/*                                    |                                                             |                     */
/*                                    |  systask command "&_s -termstmt %nrstr(%getcnt(WELSH,fsd1);)|                     */
/*                                    |  ....                                                       |                     */
/*                                    |  systask command "&_s -termstmt %nrstr(%getcnt(ASIAN,fsd1);)|                     */
/*                                    |                                                             |                     */
/*                                    |4 create a view combining all eight outputs (races           |                     */
/*                                    |                                                             |                     */
/*                                    | data allraces/view=allraces;                                |                     */
/*                                    |   set                                                       |                     */
/*                                    |        fsd1.ASIAN                                           |                     */
/*                                    |        fsd1.CZECH                                           |                     */
/*                                    |        fsd1.DUTCH                                           |                     */
/*                                    |        fsd1.GREEK                                           |                     */
/*                                    |        fsd1.IRISH                                           |                     */
/*                                    |        fsd1.MALAY                                           |                     */
/*                                    |        fsd1.SWISS                                           |                     */
/*                                    |        fsd1.WELSH                                           |                     */
/*                                    |   ;                                                         |                     */
/*                                    | run;quit;                                                   |                     */
/*                                    |                                                             |                     */
/**************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

libname msd1 "m:/sd1";

data msd1.million500 (index=(race) drop=i);
  call streaminit(1234567);
   do race='ASIAN', 'CZECH', 'DUTCH', 'GREEK', 'IRISH', 'MALAY','SWISS','WELSH';
    do age=1 to 100;
     do sex= 'F', 'M';
       do sta=&states50q;
          do i=1 to 6250;
            unique_id = rand("Integer", 1, 1000);
            output;
          end;
       end;
     end;
   end;
  end;
run;quit;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  CREATE 500 MILLION OBSERVATIONS (less than 2 minutes)                                                                 */
/*                                                                                                                        */
/*  NOTE: The data set WORK.MILLION500 has 500,000,000 observations                                                       */
/*        and 6 variables.                                                                                                */
/*  INFO: Multiple concurrent threads will be used to create the index.                                                   */
/*                                                                                                                        */
/*  NOTE: Simple index RACE has been defined.                                                                             */
/*  NOTE: DATA statement used (Total process time):                                                                       */
/*        real time           1:35.41                                                                                     */
/*                                                                                                                        */
/*                                                                                                                        */
/*   MSD1.MILLION500 total obs=500,000,000                                                                                */
/*                                             UNIQUE_                                                                    */
/*        Obs    RACE     AGE    SEX    STA       ID                                                                      */
/*                                                                                                                        */
/*          1    ASIAN     1      F     AL       159                                                                      */
/*          2    ASIAN     1      F     AL       401                                                                      */
/*          3    ASIAN     1      F     AL       955                                                                      */
/*          4    ASIAN     1      F     AL       546                                                                      */
/*          5    ASIAN     1      F     AL       468                                                                      */
/*          6    ASIAN     1      F     AL       579                                                                      */
/*          7    ASIAN     1      F     AL       378                                                                      */
/*          8    ASIAN     1      F     AL       660                                                                      */
/*          9    ASIAN     1      F     AL       789                                                                      */
/*         10    ASIAN     1      F     AL       963                                                                      */
/*                                                                                                                        */
/*  499999990    WELSH    100     M     WY        68                                                                      */
/*  499999991    WELSH    100     M     WY       233                                                                      */
/*  499999992    WELSH    100     M     WY       455                                                                      */
/*  499999993    WELSH    100     M     WY       408                                                                      */
/*  499999994    WELSH    100     M     WY       532                                                                      */
/*  499999995    WELSH    100     M     WY       843                                                                      */
/*  499999996    WELSH    100     M     WY       479                                                                      */
/*  499999997    WELSH    100     M     WY       846                                                                      */
/*  499999998    WELSH    100     M     WY       143                                                                      */
/*  499999999    WELSH    100     M     WY       371                                                                      */
/*  500000000    WELSH    100     M     WY       114                                                                      */
/*                                                                                                                        */
/**************************************************************************************************************************/
/*                   _
  ___ _ __ ___  __ _| |_ ___   _ __ ___   __ _  ___ _ __ ___
 / __| `__/ _ \/ _` | __/ _ \ | `_ ` _ \ / _` |/ __| `__/ _ \
| (__| | |  __/ (_| | ||  __/ | | | | | | (_| | (__| | | (_) |
 \___|_|  \___|\__,_|\__\___| |_| |_| |_|\__,_|\___|_|  \___/

*/
filename ft15f001 "c:/oto/getcnt.sas";
parmcards4;
%macro getcnt(race,var);
libname fsd1 "f:/sd1";
libname msd1 "m:/sd1";
/*---
  %let race=ASIAN;
  %let var=AGE;
--*/
proc sql;
  create
     table fsd1.&race as
  select
     "&race" as race
    ,&var
    ,count(distinct unique_id) as count
  from
     msd1.million500
  where
     race = "&race"
  group
     by &var;
quit;
%mend getcnt;
;;;;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  c:/oto/getcnt.sas  (macro in autocall library)                                                                        */
/*                                                                                                                        */
/*  %macro getcnt(race,var);                                                                                              */
/*  libname fsd1 "f:/sd1";                                                                                                */
/*  libname msd1 "m:/sd1";                                                                                                */
/*  /*---                                                                                                                 */
/*    %let race=ASIAN;                                                                                                    */
/*    %let var=AGE;                                                                                                       */
/*  --*/                                                                                                                  */
/*  proc sql;                                                                                                             */
/*    create                                                                                                              */
/*       table fsd1.&race as                                                                                              */
/*    select                                                                                                              */
/*       "&race" as race                                                                                                  */
/*      ,&var                                                                                                             */
/*      ,count(distinct unique_id) as count                                                                               */
/*    from                                                                                                                */
/*       msd1.million500                                                                                                  */
/*    where                                                                                                               */
/*       race = "&race"                                                                                                   */
/*    group                                                                                                               */
/*       by &var;                                                                                                         */
/*  quit;                                                                                                                 */
/*  %mend getcnt;                                                                                                         */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*___                          _ _      _   _            _
 ( _ )   _ __   __ _ _ __ __ _| | | ___| | | |_ __ _ ___| | _____
 / _ \  | `_ \ / _` | `__/ _` | | |/ _ \ | | __/ _` / __| |/ / __|
| (_) | | |_) | (_| | | | (_| | | |  __/ | | || (_| \__ \   <\__ \
 \___/  | .__/ \__,_|_|  \__,_|_|_|\___|_|  \__\__,_|___/_|\_\___/
        |_|
*/

/*--- SAS CLI COMMAND ----*/

%let _s=%sysfunc(compbl(C:\Progra~1\SASHome\SASFoundation\9.4\sas.exe -sysin
c:\nul -sasautos c:\oto -autoexec c:\oto\Tut_Oto.sas
-work d:\wrk));

options noxwait noxsync;
%let tym=%sysfunc(time());
systask kill sys1 sys2 sys3 sys4  sys5 sys6 sys7 sys8;
systask command "&_s -termstmt %nrstr(%getcnt(WELSH,AGE);) -log d:\log\a1.log" taskname=sys1;
systask command "&_s -termstmt %nrstr(%getcnt(IRISH,AGE);) -log d:\log\a2.log" taskname=sys2;
systask command "&_s -termstmt %nrstr(%getcnt(DUTCH,AGE);) -log d:\log\a3.log" taskname=sys3;
systask command "&_s -termstmt %nrstr(%getcnt(SWISS,AGE);) -log d:\log\a4.log" taskname=sys4;
systask command "&_s -termstmt %nrstr(%getcnt(GREEK,AGE);) -log d:\log\a5.log" taskname=sys5;
systask command "&_s -termstmt %nrstr(%getcnt(CZECH,AGE);) -log d:\log\a6.log" taskname=sys6;
systask command "&_s -termstmt %nrstr(%getcnt(MALAY,AGE);) -log d:\log\a7.log" taskname=sys7;
systask command "&_s -termstmt %nrstr(%getcnt(ASIAN,AGE);) -log d:\log\a8.log" taskname=sys8;
waitfor sys1 sys2 sys3 sys4  sys5 sys6 sys7 sys8;
%put %sysevalf( %sysfunc(time()) - &tym);

/*-- 38.2439999580019 seconds ---*/

libname fsd1 "f:/sd1";
proc print data=fsd1.swiss;
run;quit;


 /**************************************************************************************************************************/
 /*                                                                                                                        */
 /* EXAMPLE ON OF THE EIGHT OBS                                                                                            */
 /*                                                                                                                        */
 /* FSD1.SWISS total obs=100        SWISS =1/8th =50 states x 2 sexes x 100 ages x 6250 repeats = 62,500,.000              */
 /*                                 * races = 8 * 62,500,000  = 500,000,000                                                */
 /* Obs    RACE     AGE    COUNT                                                                                           */
 /*                                                                                                                        */
 /*   1    SWISS      1     1000                                                                                           */
 /*   2    SWISS      2     1000                                                                                           */
 /*   3    SWISS      3     1000                                                                                           */
 /*   4    SWISS      4     1000                                                                                           */
 /*                                                                                                                        */
 /*  97    SWISS     97     1000                                                                                           */
 /*  98    SWISS     98     1000                                                                                           */
 /*  99    SWISS     99     1000                                                                                           */
 /* 100    SWISS    100     1000                                                                                           */
 /*                                                                                                                        */
 /**************************************************************************************************************************/

/*                     _                        __         _ _
 ___  __ _ ___  __   _(_) _____      __   ___  / _|   __ _| | |  _ __ __ _  ___ ___  ___
/ __|/ _` / __| \ \ / / |/ _ \ \ /\ / /  / _ \| |_   / _` | | | | `__/ _` |/ __/ _ \/ __|
\__ \ (_| \__ \  \ V /| |  __/\ V  V /  | (_) |  _| | (_| | | | | | | (_| | (_|  __/\__ \
|___/\__,_|___/   \_/ |_|\___| \_/\_/    \___/|_|    \__,_|_|_| |_|  \__,_|\___\___||___/

*/

/*--- CREATE A VIEW OV THE EIGHT OUTPUTS IN SORT ORDER ---*/

libname fsd1 "d:/sd1";

data allraces/view=allraces;
  set
       fsd1.ASIAN
       fsd1.CZECH
       fsd1.DUTCH
       fsd1.GREEK
       fsd1.IRISH
       fsd1.MALAY
       fsd1.SWISS
       fsd1.WELSH
  ;
run;quit;

/**************************************************************************************************************************/
/*                                                                                                                        */
/*  Variables in Creation Order                                                                                           */
/*                                                                                                                        */
/* #    Variable    Type    Len                                                                                           */
/*                                                                                                                        */
/* 1    RACE        Char      5                                                                                           */
/* 2    AGE         Num       8                                                                                           */
/* 3    COUNT       Num       8                                                                                           */
/*                                                                                                                        */
/**************************************************************************************************************************/

/*         _     _   _                      _
  __ _  __| | __| | | |_ ___     __ _ _   _| |_ ___   _____  _____  ___
 / _` |/ _` |/ _` | | __/ _ \   / _` | | | | __/ _ \ / _ \ \/ / _ \/ __|
| (_| | (_| | (_| | | || (_) | | (_| | |_| | || (_) |  __/>  <  __/ (__
 \__,_|\__,_|\__,_|  \__\___/   \__,_|\__,_|\__\___/ \___/_/\_\___|\___|

*/

let lettersq=
 "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z";
%let letters=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z;


%let numbersq=%str("1","2","3","4","5","6","7","8","9","10");

%let numbers=1 2 3 4 5 6 7 8 9 10;

%let states50= %sysfunc(compbl(AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT
NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY)) ;

%let states50q="AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN","IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT",
"NE","NV","NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN","TX","UT","VT","VA","WA","WV","WI","WY";


%let months = JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC;
%let monthsq="JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT", "NOV", "DEC" ;

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
