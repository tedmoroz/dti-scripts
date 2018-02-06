# Set environment variables
#Top of scrip	$
#
DATE=$(date +%Y%m%d)
SITE1=$(echo $(hostname) | cut -c1-2)           #get the 1st 2 characters of the host name
SITE2=""
HOSTNAME=$(hostname)
DIR=/scripts/backups
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
# clean off old files
find ./-* -mtime +2 -exec rm -f {} \; > /dev/null 2>&1
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
	if [ $HOSTNAME == "ailxpbstst01" ]; then
        	SITE2="ANDERSON-Test"
        elif [ $HOSTNAME == "ailxpbs01" ]; then
                SITE2="ANDERSON"
        fi
        ZONE="eastern"
elif [ $SITE1 == "ar" ]; then
	if [ $HOSTNAME == "arlxpbstst01" ]; then
                SITE2="ABILENE-Test"
        elif [ $HOSTNAME == "arlxpbs01" ]; then
	        SITE2="ABILENE"
	fi
        ZONE="central"
elif [ $SITE1 == "bc" ]; then
	if [ $HOSTNAME == "bclxpbstst01" ]; then
                SITE2="BROADCAST-Test"
        elif [ $HOSTNAME == "bclxpbs01" ]; then
        	SITE2="BROADCAST"
	fi
        ZONE="eastern"
elif [ $SITE1 == "bs" ]; then
	if [ $HOSTNAME == "bslxpbstst01" ]; then
                SITE2="KITSAP-Test"
        elif [ $HOSTNAME == "bslxpbs01" ]; then
	        SITE2="KITSAP"
	fi
        ZONE="pacific"
elif [ $SITE1 == "cc" ]; then
	if [ $HOSTNAME == "cclxpbstst01" ]; then
                SITE2="CORPUS CHRISTI-Test"
        elif [ $HOSTNAME == "cclxpbs01" ]; then
	        SITE2="CORPUS CHRISTI"
	fi
        ZONE="central"
elif [ $SITE1 == "ec" ]; then
	if [ $HOSTNAME == "eclxpbstst01" ]; then
                SITE2="EVANSVILE-Test"
        elif [ $HOSTNAME == "eclxpbs01" ]; then
	        SITE2="EVANSVILLE"
	fi
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
	if [ $HOSTNAME == "ndlxpbstst01" ]; then
                SITE2="NAPLES-Test"
        elif [ $HOSTNAME == "ndlxpbs01" ]; then
	        SITE2="NAPLES"
	fi
        ZONE="eastern"
elif [ $SITE1 == "rr" ]; then
	if [ $HOSTNAME == "rrlxpbstst01" ]; then
                SITE2="REDDDING-Test"
        elif [ $HOSTNAME == "rrlxpbs01" ]; then
	        SITE2="REDDING"
	fi
        ZONE="pacific"
elif [ $SITE1 == "ss" ]; then
	if [ $HOSTNAME == "sslxpbstst01" ]; then
                SITE2="SAN ANGELO-Test"
        elif [ $HOSTNAME == "sslxpbs01" ]; then
	        SITE2="SAN-ANGELO"
	fi
        ZONE="central"
elif [ $SITE1 == "su" ]; then
	if [ $HOSTNAME == "sulxpbstst01" ]; then
                SITE2="Treasure COAST-Test"
        elif [ $HOSTNAME == "sulxpbs01" ]; then
        	SITE2="TREASURE COAST"
	fi
        ZONE="eastern"
elif [ $SITE1 == "vs" ]; then
	if [ $HOSTNAME == "vslxpbstst01" ]; then
                SITE2="VENTURA-Test"
        elif [ $HOSTNAME == "vslxpbs01" ]; then
	        SITE2="VENTURA"
	fi
        ZONE="pacific"
elif [ $SITE1 == "wt" ]; then
	if [ $HOSTNAME == "wtlxpbstst01" ]; then
                SITE2="WICHITA FALLS-Test"
        elif [ $HOSTNAME == "wtlxpbs01" ]; then
	        SITE2="WITCHITA FALLS"
	fi
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
mail -s "DB Analys Report for $HOSTNAME" laue@scripps.com < $OUTFILE

#ENDOFSCRIPT




