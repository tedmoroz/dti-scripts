#cat/etc/passwd | awk -F":" '{print $1}' | sort > XX-users.txt
#                                
while read -r DATA;
do
	echo $DATA
	passwd -u $DATA

done  < ec-users.txt

