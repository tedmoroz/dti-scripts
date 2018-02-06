# Version 1.0  Bill Stafford created 20130610
# move prodel statements to the front and add rm flat files BMB 

# Set Progress environment
. /pbs/config/cmfull

# Set envrionment variables
TODDAYS_DATE=`date +"%Y%m%d"`
DB_PATH="/var/autofs/nfs/proback/"
SRC_PATH=""
v1="/"
v2="."
v3="night"
ZONE=""
SYSTEM_NAME=""
DB_DATE=""
#
#
# Begin Delete Statements
#
#echo "y" | $DLC/bin/prodel /dbs-2/am/address1;
#echo "y" | $DLC/bin/prodel /dbs-2/am/am1;
#echo "y" | $DLC/bin/prodel /dbs-2/am/context1;
#echo "y" | $DLC/bin/prodel /dbs-2/am/history1;
#echo "y" | $DLC/bin/prodel /dbs-2/am/services1;
#############################################
echo "y" | $DLC/bin/prodel /dbs-2/cmtest1/ar1;
echo "y" | $DLC/bin/prodel /dbs-2/cmtest1/cm1;
echo "y" | $DLC/bin/prodel /dbs-2/cmtest1/cmaddress1;
echo "y" | $DLC/bin/prodel /dbs-2/cmtest1/cmcontext1;
echo "y" | $DLC/bin/prodel /dbs-2/cmtest1/services1;             
echo "y" | $DLC/bin/prodel /dbs-2/cmtest1/cmservices1;
echo "y" | $DLC/bin/prodel /dbs-2/cmtest1/gl1;
echo "y" | $DLC/bin/prodel /dbs-2/cmtest1/tmc1;
#####################################################
#echo "y" | $DLC/bin/prodel /dbs-2/im/im;
#echo "y" | $DLC/bin/prodel /dbs-2/lm/lm;
#echo "y" | $DLC/bin/prodel /dbs-2/pbs/pbs;
#echo "y" | $DLC/bin/prodel /dbs-2/ffw/webstate;
#

echo "Select the SYSTEM NAME  of the source: \n"
select SYSTEM_NAME in ailxpbstst01 arlxpbstst01 bslxpbstst01 cclxpbstst01 eclxpbstst01 knlxpbstst01 mclxpbstst01 mclxpbstst02 ndlxpbstst01 rrlxpbstst01 sslxpbstst01 sulxpbstst01 vslxpbstst01 wtlxpbstst01 Exit 

do
	case $SYSTEM_NAME in
		arlxpbstst01 | rrlxpbstst01 | sslxpbstst01 | sulxpbstst01 | eclxpbstst01 | knlxpbstst01 )
	       		case $SYSTEM_NAME in	
				arlxpbstst01 | eclxpbstst01 | sslxpbstst01 )
					ZONE="central";;
				rrlxpbstst01)
					ZONE="pacific";;
				sulxpbstst01 | knlxpbstst01)
					ZONE="eastern";;
			esac	
		
			SRC_PATH=$DB_PATH$ZONE$v1$SYSTEM_NAME$v1;  			#verify the correct source directly;
			cd $SRC_PATH; pwd; ls;
			read -p "Enter the source date:  " DB_DATE;echo $DB_DATE; 	#get backup date;
			echo $SRC_PATH"CMnight."$DB_DATE; 				#delete this line- testing only;
			#
			#. /pbs/config/am;     						#set the envirinment to AM;
			#		
			#prorest AM DB  destination from source
			#
			#echo "y" | prorest /dbs-2/am/am 		$SRC_PATH"AMnight."$DB_DATE;
			#echo "y" | prorest /dbs-2/am/address 	$SRC_PATH"AMaddressnight."$DB_DATE;
			#echo "y" | prorest /dbs-2/am/context 	$SRC_PATH"AMcontextnight."$DB_DATE; 
			#echo "y" | prorest /dbs-2/am/history	$SRC_PATH"AMhistorynight."$DB_DATE;
			#echo "y" | prorest /dbs-2/am/services	$SRC_PATH"AMservicesnight."$DB_DATE;
			#			
			. /pbs/config/cmfull;                                               #set the environment to CM;
			#
                        #prorest CM DB  destination from source
                        #
			echo "y" | prorest /dbs-2-2/cmtest1/          $SRC_PATH"CMnight."$DB_DATE -verbose;
                        #echo "y" | prorest /dbs-2/cmtest1/cmaddress   $SRC_PATH"CMaddressnight."$DB_DATE -verbose;
                        #echo "y" | prorest /dbs-2/cmtest1/context     $SRC_PATH"CMcontextnight."$DB_DATE -verbose;
                        #echo "y" | prorest /dbs-2/cmtest1/ar          $SRC_PATH"CMarnight."$DB_DATE -verbose;
                        #echo "y" | prorest /dbs-2/cmtest1/cmservices  $SRC_PATH"CMservicesnight."$DB_DATE -verbose;
			#echo "y" | prorest /dbs-2/cmtest1/gl          $SRC_PATH"CMglnight."$DB_DATE -verbose;
                        #echo "y" | prorest /dbs-2/cmtest1/tmc         $SRC_PATH"CMtmcnight."$DB_DATE -verbose;
                        #
			#. /pbs/config/im;							#set the environment to im;
			#echo "y" | prorest /dbs-2/im/im		$SRC_PATH"imnight."$DB_DATE;
                        #
			#. /pbs/config/lm;					   		#set the environment to lm;
			#echo "y" | prorest /dbs-2/lm/lm          $SRC_PATH"lmnight."$DB_DATE;
 			#
                        #. /pbs/config/ffw;                                               #set the environment to ffw/webstate;
			#echo "y" | prorest /dbs-2/ffw/webstate   $SRC_PATH"webstatenight."$DB_DATE;
			#
			#. /pbs/config/pbs		                                 #set the environment to ffw/webstate;
			#echo "y" | prorest /dbs-2/pbs/pbs        $SRC_PATH"pbsnight."$DB_DATE;
;;
		bslxpbstst01 | cclxpbstst01 | ndlxpbstst01)
			 case $SYSTEM_NAME in
                                cclxpbstst01)
                                        ZONE="central";;
                                bslxpbstst01)
                                        ZONE="pacific";;
                                ndlxpbstst01)
                                        ZONE="eastern";;
                        esac
			SRC_PATH=$DB_PATH$ZONE$v1$SYSTEM_NAME$v1;                       #verify the correct source directly;
                        cd $SRC_PATH; pwd; ls;
                        read -p "Enter the source date:  " DB_DATE;echo $DB_DATE;       #get backup date;
                        echo $SRC_PATH"CMnight."$DB_DATE;                               #delete this  line- testing only;
                        #
                        #. /pbs/config/am;                                               #set the envirinment to AM;
                        #
                        #prorest AM DB  destination from source
                        #
                        #echo "y" | prorest /dbs-2/am/am           $SRC_PATH"AMnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/address      $SRC_PATH"AMaddressnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/context      $SRC_PATH"AMcontextnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/history      $SRC_PATH"AMhistorynight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/services     $SRC_PATH"AMservicesnight."$DB_DATE;
                        #
                        . /pbs/config/cm;                                               #set the environment to CM;
			#
                        #prorest CM DB  destination from source
                        #
                        echo "y" | prorest /dbs-2/cmtest1/cm          $SRC_PATH"CMnight."$DB_DATE -verbose; 
                        echo "y" | prorest /dbs-2/cmtest1/cmaddress   $SRC_PATH"CMaddressnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs-2/cmtest1/context     $SRC_PATH"CMcontextnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs-2/cmtest1/ar          $SRC_PATH"CMarnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs-2/cmtest1/cmservices  $SRC_PATH"CMservicesnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs-2/cmtest1/gl          $SRC_PATH"CMglnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs-2/cmtest1/tmc         $SRC_PATH"CMtmcnight."$DB_DATE -verbose;
                        #
                        #. /pbs/config/im;                                                #set the environment to im;
                        #echo "y" | prorest /dbs-2/im/im           $SRC_PATH"imnight."$DB_DATE;
                        #
                        #. /pbs/config/lm;                                               #set the environment to lm;
                        #echo "y" | prorest /dbs-2/lm/lm          $SRC_PATH"lmnight."$DB_DATE;
                        #
                        #. /pbs/config/ffw;	                                         #set the environment to ffw/webstate;
                        #echo "y" | prorest /dbs-2/ffw/webstate   $SRC_PATH"webstatenight."$DB_DATE;
                        #
                        #. /pbs/config/pbs                                                #set the environment to ffw/webstate;
                        #echo "y" | prorest /dbs-2/pbs/pbs        $SRC_PATH"pbsnight."$DB_DATE;
;;
			#
		ailxpbstst01 | wtlxpbstst01)
			case $SYSTEM_NAME in
                                wtlxpbstst01)
                                        ZONE="central";;
                                ailxpbstst01)
                                        ZONE="eastern";;
                        esac
        		#
			 SRC_PATH=$DB_PATH$ZONE$v1$SYSTEM_NAME$v1;                       #verify the correct source directly;
                        cd $SRC_PATH; pwd; ls;
                        read -p "Enter the source date:  " DB_DATE;echo $DB_DATE;        #get backup date;
                        echo $SRC_PATH"CMnight."$DB_DATE;                                #delete this line- testing only;
                        #
                        #. /pbs/config/am;                                                #set the envirinment to AM;
                        #
                        #prorest AM DB  destination from source
                        #
                        #echo "y" | prorest /dbs-2/am/am           $SRC_PATH"AMnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/address      $SRC_PATH"AMaddressnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/context      $SRC_PATH"AMcontextnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/history      $SRC_PATH"AMhistorynight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/services     $SRC_PATH"AMservicesnight."$DB_DATE;
                        #
                        . /pbs/config/cm;                                               #set the environment to CM;
                        #
                        #prorest CM DB  destination from source
                        #
                        echo "y" | prorest /dbs-2/cmtest1/cm          $SRC_PATH"CMnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/cmtest1/cmaddress   $SRC_PATH"CMaddressnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/cmtest1/context     $SRC_PATH"CMcontextnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/cmtest1/ar          $SRC_PATH"CMarnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/cmtest1/cmservices  $SRC_PATH"CMservicesnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/cmtest1/gl          $SRC_PATH"CMglnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/cmtest1/tmc         $SRC_PATH"CMtmcnight."$DB_DATE;
                        #
                        #. /pbs/config/im;                                               #set the environment to im;
                        #
                        #. /pbs/config/lm;                                                #set the environment to lm;
                        #echo "y" | prorest /dbs-2/lm/lm          $SRC_PATH"lmnight."$DB_DATE;
                        #
			#. /pbs/config/ffw;                                      #set the environment to ffw/webstate;
                        #echo "y" | prorest /dbs-2/ffw/webstate   $SRC_PATH"webstatenight."$DB_DATE;
                        #
                        #. /pbs/config/pbs                                                #set the environment to ffw/webstate;
                        #echo "y" | prorest /dbs-2/pbs/pbs        $SRC_PATH"pbsnight."$DB_DATE;
;;
		vslxpbstst01 )
                        case $SYSTEM_NAME in
                                vslxpbstst01)
                                        ZONE="pacific";;
                        esac
                       #
			SRC_PATH=${DB_PATH}${ZONE}${v1}vslxpbs01${v1};                       #verify the correct source directly;
                        cd $SRC_PATH; pwd; ls;

                        read -p "Enter the source date:  " DB_DATE;echo $DB_DATE;        #get backup date;
                        echo $SRC_PATH"CMnight."$DB_DATE;                                #delete this line- testing only;
                        #
                        #. /pbs/config/am;                                                #set the envirinment to AM;
                        #
                        #prorest AM DB  destination from source
                        #
                        #echo "y" | prorest /dbs-2/am/am1           $SRC_PATH"AMnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/address1      $SRC_PATH"AMaddressnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/context1     $SRC_PATH"AMcontextnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/history1      $SRC_PATH"AMhistorynight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/services1     $SRC_PATH"AMservicesnight."$DB_DATE;
                        #
                        . /pbs/config/cm;                                                #set the environment to CM;
                        #
                        #prorest CM DB  destination from source
                        #
                        echo "y" | prorest /dbs-2/cmtest1/cm1          $SRC_PATH"CMnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/cmtest1/cmaddress1   $SRC_PATH"CMaddressnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/cmtest1/cmcontext1     $SRC_PATH"CMcontextnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/cmtest1/ar1          $SRC_PATH"CMarnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/cmtest1/cmservices1   $SRC_PATH"CMservicesnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/cmtest1/gl1          $SRC_PATH"CMglnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/cmtest1/tmc1         $SRC_PATH"CMtmcnight."$DB_DATE;
                        #
                        #. /pbs/config/im;                                                #set the environment to im;
                        #echo "y" | prorest /dbs-2/im/im           $SRC_PATH"imnight."$DB_DATE;
                        #
                        #. /pbs/config/lm;                                                #set the environment to lm;
                        #echo "y" | prorest /dbs-2/lm/lm          $SRC_PATH"lmnight."$DB_DATE;
                        #
                        #. /pbs/config/ffw;                                               #set the environment to ffw/webstate;
                        #echo "y" | prorest /dbs-2/ffw/webstate   $SRC_PATH"webstatenight."$DB_DATE;
                        #
                        #. /pbs/config/pbs                                                #set the environment to ffw/webstate;
                        #echo "y" | prorest /dbs-2/pbs/pbs        $SRC_PATH"pbsnight."$DB_DATE;
;;
		 mclxpbstst01)
                        case $SYSTEM_NAME in
                                mclxpbstst01)
                                        ZONE="central";;
                        esac
                       #
			 SRC_PATH=$DB_PATH$ZONE$v1$SYSTEM_NAME$v1;                       #verify the correct source directly;
                        cd $SRC_PATH; pwd; ls;

                        read -p "Enter the source date:  " DB_DATE;echo $DB_DATE;        #get backup date;
                        echo $SRC_PATH"CMnight."$DB_DATE;                                #delete this line- testing only;
                        #
                        . /pbs/config/am;                                                #set the envirinment to AM;
                        #
                        #prorest AM DB  destination from source
                        #
                        echo "y" | prorest /dbs-2/am/am           $SRC_PATH"AMnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/am/address      $SRC_PATH"AMaddressnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/am/context      $SRC_PATH"AMcontextnight."$DB_DATE;
                        echo "y" | prorest /dbs-2/am/history      $SRC_PATH"AMhistorynight."$DB_DATE;
                        echo "y" | prorest /dbs-2/am/services     $SRC_PATH"AMservicesnight."$DB_DATE;
                        #
                        #. /pbs/config/cm;                                                #set the environment to CM;
                        #
                        #prorest CM DB  destination from source
                        #
                        #echo "y" | prorest /dbs-2/cmtest1/cm          $SRC_PATH"CMnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/cmtest1/cmaddress   $SRC_PATH"CMaddressnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/cmtest1/context     $SRC_PATH"CMcontextnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/cmtest1/ar          $SRC_PATH"CMarnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/cmtest1/services    $SRC_PATH"CMservicesnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/cmtest1/gl          $SRC_PATH"CMglnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/cmtest1/tmc         $SRC_PATH"CMtmcnight."$DB_DATE;
                        #
                        . /pbs/config/im;                                                #set the environment to im;
                        echo "y" | prorest /dbs-2/im/im           $SRC_PATH"imnight."$DB_DATE;
                        #
                        #. /pbs/config/lm;                                                #set the environment to lm;
                        #echo "y" | prorest /dbs-2/lm/lm          $SRC_PATH"lmnight."$DB_DATE;
                        #
                        #. /pbs/config/ffw;                                               #set the environment to ffw/webstate;
                        #echo "y" | prorest /dbs-2/ffw/webstate   $SRC_PATH"webstatenight."$DB_DATE;
                        #
                        #. /pbs/config/pbs                                                #set the environment to ffw/webstate;
                        #echo "y" | prorest /dbs-2/pbs/pbs        $SRC_PATH"pbsnight."$DB_DATE;
;;
		 mclxpbstst02)
                        case $SYSTEM_NAME in
                                mclxpbstst02)
                                ZONE="central";;
                        esac
                       #
			 SRC_PATH=$DB_PATH$ZONE$v1$SYSTEM_NAME$v1;                       #verify the correct source directly;
                        cd $SRC_PATH; pwd; ls;

                        read -p "Enter the source date:  " DB_DATE;echo $DB_DATE;        #get backup date;
                        echo $SRC_PATH"CMnight."$DB_DATE;                                #delete this line- testing only;
                        #
                        #. /pbs/config/am;                                                #set the envirinment to AM;
                        #
                        #prorest AM DB  destination from source
                        #
                        #echo "y" | prorest /dbs-2/am/am           $SRC_PATH"AMnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/address      $SRC_PATH"AMaddressnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/context      $SRC_PATH"AMcontextnight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/history      $SRC_PATH"AMhistorynight."$DB_DATE;
                        #echo "y" | prorest /dbs-2/am/services     $SRC_PATH"AMservicesnight."$DB_DATE;
                        #
                        . /pbs/config/cm;                                                #set the environment to CM;
                        #
                        #prorest CM DB  destination from source
                        #
                        echo "y" | prorest /dbs-2/cmtest1/cm          $SRC_PATH"CMnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs-2/cmtest1/cmaddress   $SRC_PATH"CMaddressnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs-2/cmtest1/context     $SRC_PATH"CMcontextnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs-2/cmtest1/ar          $SRC_PATH"CMarnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs-2/cmtest1/services    $SRC_PATH"CMservicesnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs-2/cmtest1/gl          $SRC_PATH"CMglnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs-2/cmtest1/tmc         $SRC_PATH"CMtmcnight."$DB_DATE -verbose;
                        #
                        #. /pbs/config/im;                                                #set the environment to im;
                        #echo "y" | prorest /dbs-2/im/im           $SRC_PATH"imnight."$DB_DATE;
                        #
                        . /pbs/config/lm;                                                #set the environment to lm;
                        echo "y" | prorest /dbs-2/lm/lm          $SRC_PATH"lmnight."$DB_DATE -verbose;
                        #
                        #. /pbs/config/ffw;                                               #set the environment to ffw/webstate;
                        #echo "y" | prorest /dbs-2/ffw/webstate   $SRC_PATH"webstatenight."$DB_DATE;
                        #
                        #. /pbs/config/pbs                                                #set the environment to ffw/webstate;
                        #echo "y" | prorest /dbs-2/pbs/pbs        $SRC_PATH"pbsnight."$DB_DATE;
;;
                Exit|Quit|exit|quit|e|q|E|Q)
                        exit;;


		*)
			echo "Invalid server choice. Please rerun the script and choose a valid server."
                        echo "1) ailxpbstst01 2) arlxpbstst01 3) bslxpbstst01 4) cclxpbstst01 5) ndlxpbstst01"
                        echo "6) rrlxpbstst01 7) sslxpbstst01 8) sulxpbstst01 9) vslxpbstst01 10) wtlxpbstst01"
                        exit;;

	esac
done


