# enables all disables printers then restarts cups service

awk 'NR >3' /etc/printcap | awk -F"|" '{print $1}' | while read -r DATA;
do
	echo "Enabling printer  " $DATA
	cupsenable $DATA
done 

service cups restart



