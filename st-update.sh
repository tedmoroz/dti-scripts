. /pbs/config/cmfull
$DLC/bin/proutil -C dbipcs | grep Yes | awk '{print $5}'

for db in `$DLC/bin/proutil -C dbipcs | grep Yes | awk '{print $5}' | sed 's/\.db//'`
 do
 BASENAME=`basename $db`
 DIRNAME=`dirname $db`
 echo $DIRNAME 
 echo $BASENAME
cd $DIRNAME
 $DLC/bin/prostrct list $BASENAME
 done

