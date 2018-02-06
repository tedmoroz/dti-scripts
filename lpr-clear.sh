# enables all disables printers then restarts cups service

LprENABLE_LOG=/scripts/lprEnable.log

cat /dev/null > $LprENABLE_LOG

awk 'NR >3' /etc/printcap | awk -F"|" '{print $1}' | while read -r DATA;
do
	echo $DATA >> $LprENABLE_LOG
	cupsenable $DATA
done 
echo $USER >> $LprENABLE_LOG
echo $(date) >> $LprENABLE_LOG




