                                
while read -r DATA;
do
	echo $DATA
	passwd -u $DATA

done < vc-users.txt
pam_tally2 -r

