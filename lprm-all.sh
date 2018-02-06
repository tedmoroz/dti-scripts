lpq -a | awk '{print $3}' > lprm-file.tmp

while read -r DATA
do

echo $DATA
lprm $DATA

done < lprm-file.tmp

lpq -a
