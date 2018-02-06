#!/bin/sh
# Set environment
IPADD=$(hostname --ip-address)
SITE1=$(echo $(hostname) | cut -c1-2)
FPATH="/scripts/"
DATE=`date +"%Y%m%d"`
TOD=$(echo $(date) | awk '{print $4}')
FILENAME=sysWatch-$DATE".log"
LOGFILE=$FPATH$FILENAME
#
cat /dev/null > $LOGFILE

if   [ $SITE1 == "kn" ]; then
        if   [ $HOSTNAME == "knlxpbs01" ]; then
                SITE="Knoxville"
        elif [ $HOSTNAME == "knlxpbstst01" ]; then
                SITE="KNOXVILLE-Test"
        fi
        ZONE="eastern"
elif [ $SITE1 == "ai" ]; then
        if   [ $HOSTNAME == "ailxpbs01" ]; then
                SITE="ANDERSON"
        elif [ $HOSTNAME == "ailxpbstst01" ]; then
                SITE="ANDERSON-Test"
        fi
        ZONE="eastern"
elif [ $SITE1 == "ar" ]; then
        if   [ $HOSTNAME == "arlxpbs01" ]; then
                SITE="ABILENE"
        elif [ $HOSTNAME == "arlxpbstst01" ]; then
                SITE="ABILENE-Test"
        fi
        ZONE="central"
elif [ $SITE1 == "bc" ]; then
        if   [ $HOSTNAME == "bclxpbs01" ]; then
                SITE="BROADCAST"
        elif [ $HOSTNAME == "bclxpbstst01" ]; then
                SITE="BROADCAST-Test"
        fi
        ZONE="eastern"
elif [ $SITE1 == "bs" ]; then
        if   [ $HOSTNAME == "bslxpbs01" ]; then
                SITE="KITSAP"
        elif [ $HOSTNAME == "bslxpbstst01" ]; then
                SITE="KITSAP-Test"
        fi
        ZONE="pacific"
elif [ $SITE1 == "cc" ]; then
        if   [ $HOSTNAME == "cclxpbs01" ]; then
                SITE="CORPUS CHRISTI"
        elif [ $HOSTNAME == "cclxpbstst01" ]; then
                SITE="CORPUS CHRISTI-Test"
        fi
        ZONE="central"
elif [ $SITE1 == "ec" ]; then
        if   [ $HOSTNAME == "eclxpbs01" ]; then
                SITE="EVANSVILLE"
        elif [ $HOSTNAME == "eclxpbstst01" ]; then
                SITE="EVANSVILLE-Test"
        fi
        ZONE="central"
elif [ $SITE1 == "mc" ]; then
        if   [ $HOSTNAME == "mclxpbs01" ]; then
                SITE="MEMPHIS-AM"
        elif [ $HOSTNAME == "mclxpbs02" ]; then
                SITE="MEMPHIS-CM"
        elif [ $HOSTNAME == "mclxpbstst01" ]; then
                SITE="MEMPHIS-AM-test"
        elif [ $HOSTNAME == "mclxpbstst02" ]; then
                SITE="MEMPHIS-CM-test"
        fi
        ZONE="central"
elif [ $SITE1 == "mj" ]; then
        if   [ $HOSTNAME == "mjlxpbs01" ]; then
                SITE="MILWAUKEE"
        fi
        ZONE="central"
elif [ $SITE1 == "nd" ]; then
        if   [ $HOSTNAME == "ndlxpbs01" ]; then
                SITE="NAPLES"
        elif [ $HOSTNAME == "ndlxpbstst01" ]; then
                SITE="NAPLES-Test"
        fi
        ZONE="eastern"
elif [ $SITE1 == "rr" ]; then
        if   [ $HOSTNAME == "rrlxpbs01" ]; then
                SITE="REDDING"
        elif [ $HOSTNAME == "rrlxpbstst01" ]; then
                SITE="REDDING-Test"
        fi
        ZONE="pacific"
elif [ $SITE1 == "ss" ]; then
        if   [ $HOSTNAME == "sslxpbs01" ]; then
                SITE="SAN-ANGELO"
        elif [ $HOSTNAME == "sslxpbstst01" ]; then
                SITE="SAN-ANGELO-Test"
        fi
        ZONE="central"
elif [ $SITE1 == "su" ]; then
        if   [ $HOSTNAME == "sulxpbs01" ]; then
                SITE="TREASURE-COAST"
        elif [ $HOSTNAME == "sulxpbstst01" ]; then
                SITE="TREASURE-COAST-Test"
        fi
        ZONE="eastern"
elif [ $SITE1 == "vs" ]; then
        if   [ $HOSTNAME == "vslxpbs01" ]; then
                SITE="VENTURA"
        elif [ $HOSTNAME == "vslxpbstst01" ]; then
                SITE="VENTURA-Test"
        fi
        ZONE="pacific"
elif [ $SITE1 == "wt" ]; then
         if   [ $HOSTNAME == "wtlxpbs01" ]; then
                SITE="WITCHITA-FALLS"
        elif [ $HOSTNAME == "wtlxpbstst01" ]; then
                SITE="WITCHITA-FALLS-Test"
        fi
        ZONE="central"
else
        SITE="You booboo'd"
fi
#####################################################################

echo "Remove log files in /scripts directory older then 2 days" >> ${LOGFILE}
echo "find $FPATH -mmin +2760 -name "*.log" -exec rm {} \; >> ${LOGFILE}"  >> ${LOGFILE}

#####################################################################

cat /dev/null > $LOGFILE                #clears the output file
echo  " $SITE "Sys-Watch.log"  $DATE"  "$TOD \n\r" >>$LOGFILE
echo "Logfile:" "$FILENAME"-"$TOD.log      " >> $LOGFILE
echo "IP Address $IPADD            " >> $LOGFILE
#
ls /proback >/dev/null 2>&1				#causes /proback to be mounted
echo "********************************************************************************************************" >> $LOGFILE
echo  " Display free disk space and mounts" >> $LOGFILE
echo  " Verify that /app, /dbs, /ai /opt /tmp /proback and the root directory "/" are mounted and have free space" >> $LOGFILE
echo "********************************************************************************************************" >> $LOGFILE
df -h  >> $LOGFILE
#
echo "********************************************************************************************************" >> $LOGFILE
echo " Display 15 minute load average if over 1.0" >> $LOGFILE
echo " Normal 15 minute load average is less than one (1). If less than one (1) nothing prints."  >> $LOGFILE
echo "********************************************************************************************************" >> $LOGFILE
uptime | awk '{if ($12 > 1.0) print "15-min avg: "$12}' >> $LOGFILE
#
echo "********************************************************************************************************" >> $LOGFILE
echo " Display iostat"  >> $LOGFILE
echo " Reports system I/O devices, (CPU) statistics, asynchronous input/output (AIO) and input/output statistics" >> $LOGFILE
echo " Note the %idle: percent cpu idle w/o a disk i/o request, %iowait:  percent cpu idle with a disk i/o request" >> $LOGFILE
echo "********************************************************************************************************" >> $LOGFILE
iostat >> $LOGFILE
#
echo "********************************************************************************************************" >> $LOGFILE
echo " Display performance statistics for all of the system cpu" >> $LOGFILE
echo " Note  icpu: # of logical processors, and intr/s: interupts per second" >> $LOGFILE
echo "********************************************************************************************************" >> $LOGFILE
mpstat -P ALL  >> $LOGFILE
#
echo "********************************************************************************************************" >> $LOGFILE
echo "Display vmstat" >> $LOGFILE
echo "si/o:mem swapped to disk,  bi/o: blocks in/out in= interupts"  >> $LOGFILE
echo "us: user time sy: system time id: idle time"  >> $LOGFILE
echo "r: # process waiting for run time b:# proc in unteruptable sleep w: # proc. swapped"  >> $LOGFILE
echo "********************************************************************************************************" >> $LOGFILE
vmstat >> $LOGFILE
#
#echo "************sar****************************************************************************************" >> $LOGFILE
#sar >> $LOGFILE
#
#echo "************top****************************************************************************************" >> $LOGFILE
#top -n 1 b  >> $LOGFILE
#
#echo "**********lpstat***************************************************************************************" >> $LOGFILE
#lpstat -t >> $LOGFILE
#
echo "**********"*****"***************************************************************************************" >> $LOGFILE
echo " Display all processes that have expired and not been respawned by init" >>$LOGFILE
echo "********************************************************************************************************" >> $LOGFILE
who -d -H  >> $LOGFILE
#
echo "********************************************************************************************************" >> $LOGFILE
echo " Display high cpu if greater than 5 or high memory usage if greater than 4" >> $LOGFILE
echo " Any output show higher than normal resource use. This information should be used to flag a potential problem."  >> $LOGFILE
echo " A sustained high cpu usage may indicates a hung process, a bad query, or other process that is stealing cpu cycles."  >> $LOGFILE
echo " Run ps-auxf | grep <pid> or <user> to monitor. The process may have ot be killed. commands are pkill -9 -u <user id>. "  >> $LOGFILE
echo "********************************************************************************************************" >> $LOGFILE
printf  "USER""\t""PID""\t""CPU""\t""MEM""\t""TERM""\t""TIME""\t""PROCESS""\n" >>$LOGFILE
ps auwx | awk '{if ($3 > 5 || $4 > 4) print $1,"\t"$2,"\t"$3,"\t"$4,"\t"$7,"\t"$10,"\t"$11 }' >>$LOGFILE
echo "********************************************************************************************************"  >> $LOGFILE
echo -e "            "  $HOSTNAME"-"$DATE >> $LOGFILE
#cat $LOGFILE
mail -s $HOSTNAME" System Status" lsn-newspapersystems.on-call@scripps.com < $LOGFILE
mail -s $HOSTNAME" System Status" albert.stafford@commercialappeal.com < $LOGFILE

