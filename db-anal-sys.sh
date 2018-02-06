# Set environment variables
#Top of scrip	$
#
DATE=$(date +%Y%m%d)
SITE1=$(echo $(hostname) | cut -c1-2)           #get the 1st 2 characters of the host name
SITE2=""
HOSTNAME=$(hostname)
DIR=/home/130450/new-scripts/
DBVOL=/dbs

ZONE=""
VOLUME=""
#
DATA1=""
INDEX1=""
ACTUAL1=""
TOTAL1=""
SCATTER1=""
#
# set the site name and zone
if   [ $SITE1 == "kn" ]; then
        if [ $HOSTNAME == "knlxpbstst01" ]; then
		SITE2="KNOXVILLE-Test"
	elif [ $HOSTNAME == "knlxpbs01" ]; then
		SITE2="KNOXVILLE"
	fi
        ZONE="eastern"
elif [ $SITE1 == "ai" ]; then
        SITE2="ANDERSON"
        ZONE="eastern"
elif [ $SITE1 == "ar" ]; then
        SITE2="ABILENE"
        ZONE="central"
elif [ $SITE1 == "ch" ]; then
	SITE2="CH-DumpNLoad"
	ZONE="eastern"
elif [ $SITE1 == "bc" ]; then
        SITE2="BROADCAST"
        ZONE="eastern"
elif [ $SITE1 == "bs" ]; then
        SITE2="KITSAP"
        ZONE="pacific"
elif [ $SITE1 == "cc" ]; then
        SITE2="CORPUS CHRISTI"
        ZONE="central"
elif [ $SITE1 == "ec" ]; then
        SITE2="EVANSVILLE"
        ZONE="central"
elif [ $SITE1 == "mc" ]; then
        if   [ $HOSTNAME == "mclxpbs01" ]; then
                SITE2="MEMPHIS-AM"
		elif [ $HOSTNAME == "mclxpbs02" ]; then
                SITE2="MEMPHIS-CM"
		elif [ $HOSTNAME == "mclxpbstst01" ]; then
                SITE2="MEMPHIS-AM-Test"
        elif [ $HOSTNAME == "mclxpbstst02" ]; then
                SITE2="MEMPHIS-CM-test"
        fi
        ZONE="central"
elif [ $SITE1 == "nd" ]; then
        SITE2="NAPLES"
        ZONE="eastern"
elif [ $SITE1 == "rr" ]; then
        SITE2="REDDING"
        ZONE="pacific"
elif [ $SITE1 == "ss" ]; then
        SITE2="SAN-ANGELO"
        ZONE="central"
elif [ $SITE1 == "su" ]; then
        SITE2="TREASURE COAST"
        ZONE="eastern"
elif [ $SITE1 == "vs" ]; then
        SITE2="VENTURA"
        ZONE="pacific"
elif [ $SITE1 == "wt" ]; then
        SITE2="WITCHITA FALLS"
        ZONE="central"
else
        SITE2="You booboo'd"
fi


FORMT="%-15s %20s %20s %20s %30s %20s %20s\n"
HEADER="%-15s %20s %15s %20s %20s %20s %20s\n"

OUTFILE=$DIR$HOSTNAME.$DATE
OUTFILE2=$DIR$HOSTNAME-2.$DATE

cat /dev/null > $OUTFILE
cat /dev/null > $OUTFILE2

echo -e "Database\tData\t\tIndex\t\tActual\t\tTotal\t\t\tScatter\tAI" >> $OUTFILE
#printf "$HEADER" "Database" "Data" "Index" "Actual" "Total" "Scatter" "AI" >> $OUTFILE

. /pbs/config/amfull

#*************************/DBS/AM/AM************************************************************
echo $SITE2-AM >> $OUTFILE
N='am'
DBANAME=$DIR$SITE2-am.$DATE
DB=$DBVOL/am/am
total=0
TOTAL1=0
TOTALAI=0

proutil $DB -C dbanalys > $DBANAME

DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')
TOTAL1=$( ls -l /dbs/am | grep am | awk '{total = total + $5}END{print total}')
TOTALAI=$( ls -l /ai/am | grep am | awk '{total = total + $5}END{print total}')

echo -e "  $N\t\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE
#printf "$HEADER" $N $DATA1 $INDEX1 $ACTUAL1 $TOTAL1 $SCATTER1 $TOTALAI >> $OUTFILE

#****************************/DBS/AM/ADDRESS****************************************************

DBANAME=$DIR$SITE-amaddress.$DATE
DB=$DBVOL/am/address
total=0
TOTAL1=0
N='address'
proutil $DB -C dbanalys > $DBANAME

DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')
TOTAL1=$( ls -l /dbs/am | grep address | awk '{total = total + $5}END{print total}')
TOTALAI=$( ls -l /ai/am | grep add | awk '{total = total + $5}END{print total}')

echo -e "  $N\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE
#printf "$HEADER" $N $DATA1 $INDEX1 $ACTUAL1 $TOTAL1 $SCATTER1  $TOTALAI >> $OUTFILE

#****************************/DBS/AM/HISTIRY****************************************************

DBANAME=$DIR$SITE-histroy.$DATE
DB=$DBVOL/am/history
total=0
TOTAL1=0
N='history'

proutil $DB -C dbanalys > $DBANAME

DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')
TOTAL1=$( ls -l /dbs/am | grep history | awk '{total = total + $5}END{print total}')
TOTALAI=$( ls -l /ai/am | grep history | awk '{total = total + $5}END{print total}')

echo -e "  $N\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE
#printf "$FORMAT" $N $DATA1 $INDEX1 $ACTUAL1 $TOTAL1 $SCATTER1 $TOTALAI >> $OUTFILE

#****************************/DBS/AM/CONTEXT****************************************************

DBANAME=$DIR$SITE-amcontext.$DATE
DB=$DBVOL/am/context
total=0
TOTAL1=0
N='context'

proutil $DB -C dbanalys > $DBANAME

DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')
TOTAL1=$( ls -l /dbs/am | grep context | awk '{total = total + $5}END{print total}')
TOTALAI=$( ls -l /ai/am | grep context | awk '{total = total + $5}END{print total}')

echo -e "  $N\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE

#****************************/DBS/AM/SERVICES****************************************************

DBANAME=$DIR$SITE-amservices.$DATE
DB=$DBVOL/am/services
total=0
TOTAL1=0
N='services'

proutil $DB -C dbanalys > $DBANAME

DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')
TOTAL1=$( ls -l /dbs/am | grep services | awk '{total = total + $5}END{print total}')
TOTALAI=$( ls -l /ai/am | grep services | awk '{total = total + $5}END{print total}')

echo -e " $N\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE

#"*********************************END OF AM****************************************************** 
#**********************************START OF CM****************************************************
#***********************************CM************************************************************

DBANAME=$DIR$SITE-cm.$DATE
DB=$DBVOL/cm/cm
total=0
TOTAL1=0
N='cm'

proutil $DB -C dbanalys > $DBANAME

echo $SITE2-CM >> $OUTFILE

DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')
TOTAL1=$( ls -l /dbs/cm | grep cm | awk '{total = total + $5}END{print total}')
TOTALAI=$( ls -l /ai/cm | grep cm | awk '{total = total + $5}END{print total}')

echo -e " $N\t\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE

#*************************************AR**********************************************************

DBANAME=$DIR$SITE-ar.$DATE
DB=$DBVOL/cm/ar
total=0
TOTAL1=0
N='ar'

proutil $DB -C dbanalys > $DBANAME



DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')
TOTAL1=$( ls -l /dbs/cm | grep ar | awk '{total = total + $5}END{print total}')
TOTALAI=$( ls -l /ai/cm | grep ar | awk '{total = total + $5}END{print total}')

echo -e " $N\t\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE

#******************************************CM ADDRESS**********************************************

DBANAME=$DIR$SITE-cmaddress.$DATE
DB=$DBVOL/cm/cmaddress
total=0
TOTAL1=0
N='address'

proutil $DB -C dbanalys > $DBANAME

DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')
TOTAL1=$( ls -l /dbs/cm | grep address | awk '{total = total + $5}END{print total}')
TOTALAI=$( ls -l /ai/cm | grep address | awk '{total = total + $5}END{print total}')

echo -e " $N\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE

#****************************************CM**CONTEXT***********************************************

DBANAME=$DIR$SITE-cmcontext.$DATE
DB=$DBVOL/cm/context
total=0
TOTAL1=0
N='context'

proutil $DB -C dbanalys > $DBANAME


DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')
TOTAL1=$( ls -l /dbs/cm | grep context | awk '{total = total + $5}END{print total}')
TOTALAI=$( ls -l /ai/cm | grep context | awk '{total = total + $5}END{print total}')

echo -e " $N\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE

#**************************************GL*************************************************

DBANAME=$DIR$SITE-gl.$DATE
DB=$DBVOL/cm/gl
total=0
TOTAL1=0
N='gl'

proutil $DB -C dbanalys > $DBANAME


DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')
TOTAL1=$( ls -l /dbs/cm | grep gl | awk '{total = total + $5}END{print total}')
TOTALAI=$( ls -l /ai/cm | grep gl | awk '{total = total + $5}END{print total}')

echo -e " $N\t\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE

#*************************************CM*SERVICES*************************************************

DBANAME=$DIR$SITE-cmservices.$DATE
case $HOSTNAME in
		vslxpbs01 | vslxpbstst01 | knlxpbs01 | eclxpbs01 )
				DB=$DBVOL/cm/services ;;
		mclxpbs01 | mclxpbs02  )
		DB=$DBVOL/cm/cmservices ;;
esac

total=0
TOTAL1=0
N='services'

proutil $DB -C dbanalys > $DBANAME

DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')
TOTAL1=$( ls -l /dbs/cm | grep services | awk '{total = total + $5}END{print total}')
TOTALAI=$( ls -l /ai/cm | grep services | awk '{total = total + $5}END{print total}')

echo -e " $N\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE

#*************************************TMC*********************************************************

DBANAME=$DIR$SITE-tmc.$DATE
DB=$DBVOL/cm/tmc
total=0
TOTAL1=0
N='tmc'

proutil $DB -C dbanalys > $DBANAME


DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')
TOTAL1=$( ls -l /dbs/cm | grep tmc | awk '{total = total + $5}END{print total}')
TOTALAI=$( ls -l /ai/cm | grep tmc | awk '{total = total + $5}END{print total}')

echo -e " $N\t\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE

#****************************************END OF CM************************************************
#****************************************IM******************************************************

echo "***************" >> $OUTFILE

DBANAME=$DIR$SITE-im.$DATE
DB=$DBVOL/im/im
total=0
TOTAL1=0
N='im'

proutil $DB -C dbanalys > $DBANAME

DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')

case $HOSTNAME in
    mclxpbs02 | ailxpbs01 | bclxpbs01 | wtlxpbs01 )
        TOTAL1=1  ;;
    *  )
        TOTAL1=$( ls -l /dbs/im | grep im | awk '{total = total + $5}END{print total}') ;
	TOTALAI=$( ls -l /ai/im | grep im | awk '{total = total + $5}END{print total}') ;;
esac

echo -e " $N\t\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE

#****************************************LM*******************************************************

DBANAME=$DIR$SITE-lm.$DATE
DB=$DBVOL/lm/lm
total=0
TOTAL1=0
N='lm'

proutil $DB -C dbanalys > $DBANAME


DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')

case $HOSTNAME in
    mclxpbs01 | bclxpbs01 | bslxpbs01 | cclxpbs01 | ndlxpbs01 )
	TOTAL1=1 ;;
    *  )
        TOTAL1=$( ls -l /dbs/lm | grep lm | awk '{total = total + $5}END{print total}');
	TOTALAI=$( ls -l /ai/lm | grep lm | awk '{total = total + $5}END{print total}')  ;;
esac

echo -e " $N\t\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE

#************************************PBS**********************************************************

DBANAME=$DIR$SITE-pbs.$DATE
DB=$DBVOL/pbs/pbs
total=0
TOTAL1=0
N='pbs'

proutil $DB -C dbanalys > $DBANAME

DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')
TOTAL1=$( ls -l /dbs/pbs | grep pbs | awk '{total = total + $5}END{print total}')
TOTALAI=$( ls -l /ai/pbs | grep pbs | awk '{total = total + $5}END{print total}')

echo -e " $N\t\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE
#*************************************WEBSTATE****************************************************

DBANAME=$DIR$SITE-webstate.$DATE
DB=$DBVOL/ffw/webstate
total=0
TOTAL1=0
N='webstate'

proutil $DB -C dbanalys > $DBANAME


DATA1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(1)$/')
INDEX1=$( cat $DBANAME | grep -w Totals |awk '{print $3}' | awk 'NR~/^(2)$/')
ACTUAL1=$( cat $DBANAME | grep -w Total |awk '{print $6}' | awk 'NR~/^(1)$/')
SCATTER1=$( cat $DBANAME | grep -w Totals |awk '{print $9}' | awk 'NR~/^(1)$/')
TOTAL1=$( ls -l /dbs/ffw | grep webstate | awk '{total = total + $5}END{print total}')
TOTALAI=$( ls -l /ai/ffw | grep webstate | awk '{total = total + $5}END{print total}')

echo -e "  $N\t$DATA1\t\t$INDEX1\t\t$ACTUAL1\t\t$TOTAL1\t\t$SCATTER1\t$TOTALAI" >> $OUTFILE

#**************************************************************************************************

awk 'BEGIN { format = "%-15s %7s %7s %7s %15s %5s %10s\n" }
             {  printf format, $1, $2, $3, $4, $5, $6, $7 }' $OUTFILE

echo  "END OF SCRIPT" >> $OUTFILE

#mail -s "DB Analys Report for $HOSTNAME" Ted.Moroz@scripps.com < $OUTFILE
mail -s "DB Analys Report for $HOSTNAME" stafford@commercialappeal.com < $OUTFILE

#ENDOFSCRIPT




