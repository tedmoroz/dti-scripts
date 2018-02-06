# Version 1.0  Bill Stafford created 20130610
# move prodel statements to the front and add rm flat files BMB 
#TODDAYS_DATE=`date +"%Y%m%d"`
#
. /pbs/config/cmfull
# Begin Delete Statements
#
echo "y" | $DLC/bin/prodel /dbs/am/address;
echo "y" | $DLC/bin/prodel /dbs/am/am;
echo "y" | $DLC/bin/prodel /dbs/am/context;
echo "y" | $DLC/bin/prodel /dbs/am/history;
echo "y" | $DLC/bin/prodel /dbs/am/services;
echo "y" | $DLC/bin/prodel /dbs/cm/ar;
echo "y" | $DLC/bin/prodel /dbs/cm/cm;
echo "y" | $DLC/bin/prodel /dbs/cm/cmaddress;
echo "y" | $DLC/bin/prodel /dbs/cm/context;
echo "y" | $DLC/bin/prodel /dbs/cm/cmservices;             
echo "y" | $DLC/bin/prodel /dbs/cm/gl;
echo "y" | $DLC/bin/prodel /dbs/cm/tmc;
echo "y" | $DLC/bin/prodel /dbs/im/im;
echo "y" | $DLC/bin/prodel /dbs/lm/lm;
echo "y" | $DLC/bin/prodel /dbs/pbs/pbs;
echo "y" | $DLC/bin/prodel /dbs/ffw/webstate;

