while read -r DATA;
do
	echo $DATA
	passwd -l $DATA

done < ks-users.txt
pam_tally2 -r
