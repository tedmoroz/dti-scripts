# unlock all db, note: pbs must be unlocked firsti
HOSTNAME=$(hostname)
SYSNAME=""
clear
echo
echo "VERIFY THE SYSTEM NAME - DUMMY!!!!!"
echo
echo "ENTER SYSTEM NAME"
read SYSNAME
#
echo "The system name should be the sameas the name you typed in"
echo
echo $HOSTNAME
echo $SYSNAME
if [ $HOSTNAME = $SYSNAME ]
then

	echo $HOSTNAME "=" $SYSNAME
	echo "You have 30 seconds to do a control C"
        echo "SLEEP 30 SECONDS" 
	sleep 30s
else
        echo "YOUR IN THE WRONG SYSTEM!!!!!!!!!!!!"
        echo "You Boo-Boo'd"
	exit
fi


# STOP the CRON on production servers before stoppiing the dbs
#
service crond stop
chkconfig nimbus off
chkconfig crond off

. /pbs/config/pbs
lockdb pbs
##

. /pbs/config/am
lockdb am
#

. /pbs/config/cm
lockdb cm
#

. /pbs/config/ffw
lockdb ffw
#

. /pbs/config/lm
lockdb lm
#
. /pbs/config/im
lockdb im

. /pbs/config/hm
lockdb hm

