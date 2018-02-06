DATE=`date +"%Y%m%d"`
HOSTNAME=$(hostname)
N_PATH="/scripts/log/"
CM_SUM_LOGNAME="CM-LogSummary-"$HOSTNAME"-"$DATE
AM_SUM_LOGNAME="AM-LogSummary-"$HOSTNAME"-"$DATE
#
#rpm -qa --queryformat '%{installtime} (%{installtime:date}) %{name}\n' |sort -n>> $UserName/$HostName-RPMUpdates-$DATE
#
#
cd /app/pbs/Install/log
./summarize_log am > /dev/null 2>&1
mv /tmp/am.log.summary $N_PATH$AM_SUM_LOGNAME
#
./summarize_log cm > /dev/null 2>&1
mv /tmp/cm.log.summary $N_PATH$CM_SUM_LOGNAME
#
chmod 777  $N_PATH$CM_SUM_LOGNAME
chmod 777  $N_PATH$AM_SUM_LOGNAME
gzip $N_PATH$CM_SUM_LOGNAME
gzip $N_PATH$AM_SUM_LOGNAME
# 
mail -s "CM logSummary" -a $N_PATH$CM_SUM_LOGNAME".gz" stafford@commercialappeal.com  > /dev/null 2>&1
mail -s "AM logSummary" -a $N_PATH$AM_SUM_LOGNAME".gz" stafford@commercialappeal.com  > /dev/null 2>&1#
#
#/app/pbs/Install/log/summarize_log_cm
#/app/pbs/Install/log/summarize_log_am
#/app/pbs/Install/log/summarize_log
#/app/pbs/Install/log/summarize_log.tar
#/app/pbs/Install/tools/summarize_log
