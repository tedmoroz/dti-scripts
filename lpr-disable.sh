# disables all disables printers then restarts cups service

while read -r DATA
do
	echo "Disabling printer  " $DATA
	cupsdisable $DATA

done < tc-disable-lpr2.txt

service cups restart



