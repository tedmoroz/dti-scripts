# unlock all db, note: pbs must be unlocked firsti
#
chmod -R 777 /dbs/*
chmod -R 777 /ai/*
#
. /pbs/config/pbs
unlockdb pbs
pbs -s
#

. /pbs/config/lm
unlockdb lm
lm -s
#

. /pbs/config/im
unlockdb im
im -s
#

. /pbs/config/ffw
unlockdb ffw
ffw -s
#

. /pbs/config/am
unlockdb am
am -s
#
. /pbs/config/cm
unlockdb cm
cm -s
#
#
. /pbs/config/hm
unlockdb hm
hm -s
#
. /pbs/config/cmfull
$DLC/bin/proutil -C dbipcs | grep Yes
#
# DB files locked - look for .lk files and remove, then start db
#
#to remove shared memory - proutil pbs -C dbipcs
# a list of memory segments comes up, take the ID of the one that say "no". 
#grep for process id to kill  - ipcs -p | grep <id> and get cpid#  -kill cpid#
#
proutil = cd $DLC  /app/pcs102Bq/bin
$DLC/bin/wtbman -i cmo_cmo -start
$DLC/bin/nsman -i NS1 -query

