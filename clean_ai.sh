#!/bin/sh
# Set environment variables
DATE=`date +"%Y%m%d%H:%M:$S"`
SITE1=$(echo $(hostname) | cut -c1-2)           #get the 1st 2 characters of the host name
HOSTNAME=$(hostname)
SYSTEM_NAME=$(hostname)
BACKUPVOL="/proback/"
ZONE=""
#                                               # set the sitea name and zone
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
                SITE="SAN ANGELO"
        elif [ $HOSTNAME == "sslxpbstst01" ]; then
                SITE="SAN ANGELO-Test"
        fi
        ZONE="central"
elif [ $SITE1 == "su" ]; then
	if   [ $HOSTNAME == "sulxpbs01" ]; then
                SITE="TREASURE COAST"
        elif [ $HOSTNAME == "sulxpbstst01" ]; then
                SITE="TREASURE COAST-Test"
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
                SITE="WITCHITA FALLS"
        elif [ $HOSTNAME == "wtlxpbstst01" ]; then
                SITE="WITCHITA FALLS-Test"
        fi        
        ZONE="central"
else
        SITE="You booboo'd"
fi
#
#
BACKUPDIR=$BACKUPVOL$ZONE/$HOSTNAME
TOD=DAY
BACKUPDATE=`eval date +%Y%m%d`
LOGFILE-A=${BACKUPDIR}/${TOD}.$BACKUPDATE.log
LOGFILE-A2=${BACKUPDIR}/${TOD}2.$BACKUPDATE.log
#
echo "Site: ${SITE} Hostname: $HOSTNAME" >> ${LOGFILE-A2}
echo "" >> ${LOGFILE-A}
date '+DATE: %m/%d/%y%nTIME:%H:%M:%S' >> ${LOGFILE-A}
echo "Logfile: ${BACKUPDIR}/${TOD}.${BACKUPDATE}.log" >> ${LOGFILE-A}
echo "Writing backups to: ${BACKUPDIR}" >> ${LOGFILE-A}

#################################################################################################
#			 Remove files in backup directory older then 2 days			#
#################################################################################################

echo "Remove files in backup directory older then 2 days" >> ${LOGFILE-A}
echo "find ${BACKUPDIR} -mmin +2760 -not -name "*.log" -exec rm {} \; >> ${LOGFILE-A}"  >> ${LOGFILE-A}
find ${BACKUPDIR} -mmin +2760 -not -name "*.log" -exec rm {} \;  >> ${LOGFILE-A}
find ${BACKUPDIR} -name "*.log" -mtime +457 -exec rm {} \;  >> ${LOGFILE-A}
date '+DATE: %m/%d/%y%nTIME:%H:%M:%S' >> ${LOGFILE-A}


