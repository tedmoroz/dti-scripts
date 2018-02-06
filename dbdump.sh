#!/bin/sh

# Shutdown Webspeed and Database Processes

. /pbs/config/cm
/pbs/bin/cm -G
/pbs/bin/cmo -G
/pbs/bin/hm -G
/pbs/bin/lockdb cm
/psb/bin/lockdb am
/pbs/bin/lockdb ffw
/pbs/bin/lockdb lm
#/pbs/bin/lockdb im   # added BMB 20130610
/pbs/bin/lockdb pbs
/pbs/bin/unlockdb cm
/psb/bin/unlockdb am
/pbs/bin/unlockdb ffw
/pbs/bin/unlockdb lm
#/pbs/bin/unlockdb im  # added BMB 20130610
/pbs/bin/unlockdb pbs


# Start Dumps

/progress/dbdump.job -db /dbs/im/im -dir /progress/im imfull
/progress/dbdump.job -db /dbs/lm/lm -dir /progress/lm lmfull
/progress/dbdump.job -db /dbs/ffw/webstate -dir /progress/ffw ffwfull
/progress/dbdump.job -db /dbs/pbs/pbs -dir /progress/pbs pbsfull


/progress/dbdump.job -db /dbs/cm/ar -dir /progress/cm/ar cmfull
/progress/dbdump.job -db /dbs/cm/tmc -dir /progress/cm/tmc cmfull
/progress/dbdump.job -db /dbs/cm/cmservices -dir /progress/cm/cmservices cmfull
/progress/dbdump.job -db /dbs/cm/context -dir /progress/cm/context cmfull
/progress/dbdump.job -db /dbs/cm/gl -dir /progress/cm/gl cmfull
/progress/dbdump.job -db /dbs/cm/cmaddress -dir /progress/cm/cmaddress cmfull
/progress/dbdump.job -db /dbs/cm/cm -dir /progress/cm/cm cmfull

/progress/dbdump.job -db /dbs/am/am -dir /progress/am/am amfull
/progress/dbdump.job -db /dbs/am/address -dir /progress/am/address amfull
/progress/dbdump.job -db /dbs/am/services -dir /progress/am/services amfull
/progress/dbdump.job -db /dbs/am/context -dir /progress/am/context amfull
/progress/dbdump.job -db /dbs/am/history -dir /progress/am/history amfull
