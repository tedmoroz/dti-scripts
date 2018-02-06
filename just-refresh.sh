# Version 1.0  Bill Stafford created 20130610
# move prodel statements to the front and add rm flat files BMB 
#TODDAYS_DATE=`date +"%Y%m%d"`
SRC_PATH="/proback/central/cclxpbs01/"
DB_DATE="20150330"
#
#
. /pbs/config/cmfull
# Begin Delete Statements
#

#echo "y" | $DLC/bin/prodel /dbs/am/address;
#echo "y" | $DLC/bin/prodel /dbs/am/am;
#echo "y" | $DLC/bin/prodel /dbs/am/context;
#echo "y" | $DLC/bin/prodel /dbs/am/history;
#echo "y" | $DLC/bin/prodel /dbs/am/services;
echo "y" | $DLC/bin/prodel /dbs/cm/ar;
echo "y" | $DLC/bin/prodel /dbs/cm/cm;
echo "y" | $DLC/bin/prodel /dbs/cm/cmaddress;
echo "y" | $DLC/bin/prodel /dbs/cm/context;
echo "y" | $DLC/bin/prodel /dbs/cm/cmservices;             
echo "y" | $DLC/bin/prodel /dbs/cm/gl;
echo "y" | $DLC/bin/prodel /dbs/cm/tmc;
#echo "y" | $DLC/bin/prodel /dbs/im/im;
#echo "y" | $DLC/bin/prodel /dbs/lm/lm;
#echo "y" | $DLC/bin/prodel /dbs/pbs/pbs;
#echo "y" | $DLC/bin/prodel /dbs/ffw/webstate;

	

			. /pbs/config/amfull;					#set the envirinment to AM;
			#		
			# Prorest AM DB  destination from source
			#
			#echo "y" | prorest /dbs/am/am 		$SRC_PATH"AMnight."$DB_DATE -verbose;
			#echo "y" | prorest /dbs/am/address 	$SRC_PATH"AMaddressnight."$DB_DATE -verbose;
			#echo "y" | prorest /dbs/am/context 	$SRC_PATH"AMcontextnight."$DB_DATE -verbose;
			#echo "y" | prorest /dbs/am/history	$SRC_PATH"AMhistorynight."$DB_DATE -verbose;
			#echo "y" | prorest /dbs/am/services	$SRC_PATH"AMservicesnight."$DB_DATE -verbose;
			#			
			. /pbs/config/cmfull;                                             
			#
                        # Prorest CM DB  destination from source
                        #
			echo "y" | prorest /dbs/cm/cm          $SRC_PATH"CMnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/cmaddress   $SRC_PATH"CMaddressnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/context     $SRC_PATH"CMcontextnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/ar          $SRC_PATH"CMarnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/cmservices  $SRC_PATH"CMservicesnight."$DB_DATE -verbose;
			echo "y" | prorest /dbs/cm/gl          $SRC_PATH"CMglnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/tmc         $SRC_PATH"CMtmcnight."$DB_DATE -verbose;
                        
			. /pbs/config/im;							#set the environment to im;
			#echo "y" | prorest /dbs/im/im		$SRC_PATH"imnight."$DB_DATE -verbose;
                        #
			. /pbs/config/lm;					   		#set the environment to lm;
			#echo "y" | prorest /dbs/lm/lm          $SRC_PATH"lmnight."$DB_DATE -verbose;
 			#
                        . /pbs/config/ffw;                                               #set the environment to ffw/webstate;
			#echo "y" | prorest /dbs/ffw/webstate   $SRC_PATH"webstatenight."$DB_DATE -verbose;
			#
			. /pbs/config/pbs		                                 #set the environment to ffw/webstate;
			#echo "y" | prorest /dbs/pbs/pbs        $SRC_PATH"pbsnight."$DB_DATE -verbose;
