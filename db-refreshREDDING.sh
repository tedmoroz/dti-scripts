# Version 1.0  Bill Stafford created 20130610
# move prodel statements to the front and add rm flat files BMB 
TODDAYS_DATE=`date +"%Y%m%d"`
DB_PATH="/var/autofs/nfs/proback2/"
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
. /pbs/config/cmfull
#
echo "y" | $DLC/bin/prodel /dbs/am/address;
echo "y" | $DLC/bin/prodel /dbs/am/am;
echo "y" | $DLC/bin/prodel /dbs/am/context;
echo "y" | $DLC/bin/prodel /dbs/am/history;
echo "y" | $DLC/bin/prodel /dbs/am/services;
####################################################
echo "y" | $DLC/bin/prodel /dbs/cm/ar;
echo "y" | $DLC/bin/prodel /dbs/cm/cm;
echo "y" | $DLC/bin/prodel /dbs/cm/cmaddress;
echo "y" | $DLC/bin/prodel /dbs/cm/cmservices;
echo "y" | $DLC/bin/prodel /dbs/cm/context;
echo "y" | $DLC/bin/prodel /dbs/cm/gl;
echo "y" | $DLC/bin/prodel /dbs/cm/tmc;
####################################################
echo "y" | $DLC/bin/prodel /dbs/im/im;
echo "y" | $DLC/bin/prodel /dbs/lm/lm;
echo "y" | $DLC/bin/prodel /dbs/pbs/pbs;
echo "y" | $DLC/bin/prodel /dbs/ffw/webstate;

echo "Select the SYSTEM NAME  of the source: \n"
select SYSTEM_NAME in ailxpbs01 arlxpbs01 ent-mocbslxpbs01 cclxpbs01 mclxpbs01 mclxpbs02 mjlxpbs01 ndlxpbs01 rrlxpbs01 sslxpbs01 sulxpbs01 vslxpbs01 wtlxpbs01 knlxpbs01 eclxpbs01 Exit 

do
	case $SYSTEM_NAME in
		arlxpbs01 | rrlxpbs01 | sslxpbs01 | sulxpbs01 | knlxpbs01 | eclxpbs01 | mclxpbs01 | mclxpbs02)
	       		case $SYSTEM_NAME in	
				arlxpbs01 | sslxpbs01 | eclxpbs01 | mclxpbs01 | mclxpbs02 | mjlxpbs01)
					ZONE="central";;
				rrlxpbs01)
					ZONE="pacific";;
				sulxpbs01 | knlxpbs01)
					ZONE="eastern";;
			esac	
		
			SRC_PATH=$DB_PATH$ZONE$v1$SYSTEM_NAME$v1;  			#verify the correct source directly;
			cd $SRC_PATH; pwd; ls;
			read -p "Enter the source date:  " DB_DATE;echo $DB_DATE; 	#get backup date;
			echo $SRC_PATH"CMnight."$DB_DATE; 				#delete this line- testing only;

			echo "BP" $SRC_PATH"AMnight."$DB_DATE
			read x

			#
			. /pbs/config/am;     						#set the envirinment to AM;
			#		
			#prorest AM DB  destination from source
			#
			echo "y" | prorest /dbs/am/am 		$SRC_PATH"AMnight."$DB_DATE -verbose;
			echo "y" | prorest /dbs/am/address 	$SRC_PATH"AMaddressnight."$DB_DATE -verbose;
			echo "y" | prorest /dbs/am/context 	$SRC_PATH"AMcontextnight."$DB_DATE -verbose; 
			echo "y" | prorest /dbs/am/history	$SRC_PATH"AMhistorynight."$DB_DATE -verbose;
			echo "y" | prorest /dbs/am/services	$SRC_PATH"AMservicesnight."$DB_DATE -verbose;
			#			
			. /pbs/config/cm;                                               #set the environment to CM;
			#
                        #prorest CM DB  destination from source
                        #
			echo "y" | prorest /dbs/cm/cm          $SRC_PATH"CMnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/cmaddress   $SRC_PATH"CMaddressnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/context     $SRC_PATH"CMcontextnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/ar          $SRC_PATH"CMarnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/cmservices  $SRC_PATH"CMservicesnight."$DB_DATE -verbose;
			echo "y" | prorest /dbs/cm/gl          $SRC_PATH"CMglnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/tmc         $SRC_PATH"CMtmcnight."$DB_DATE -verbose;
                        #
			. /pbs/config/im;							#set the environment to im;
			echo "y" | prorest /dbs/im/im		$SRC_PATH"imnight."$DB_DATE -verbose;
                        #
			. /pbs/config/lm;					   		#set the environment to lm;
			echo "y" | prorest /dbs/lm/lm          $SRC_PATH"lmnight."$DB_DATE -verbose;
 			#
                        . /pbs/config/ffw;                                               #set the environment to ffw/webstate;
			echo "y" | prorest /dbs/ffw/webstate   $SRC_PATH"webstatenight."$DB_DATE -verbose;
			#
			. /pbs/config/pbs		                                 #set the environment to ffw/webstate;
			echo "y" | prorest /dbs/pbs/pbs        $SRC_PATH"pbsnight."$DB_DATE -verbose;;

		ent-mocbslxpbs01 | cclxpbs01 | ndlxpbs01)
			 case $SYSTEM_NAME in
                                cclxpbs01)
                                        ZONE="central";;
                                ent-mocbslxpbs01)
                                        ZONE="pacific";;
                                ndlxpbs01)
                                        ZONE="eastern";;
                        esac
			SRC_PATH=$DB_PATH$ZONE$v1$SYSTEM_NAME$v1;                       #verify the correct source directly;
                        cd $SRC_PATH; pwd; ls;
                        read -p "Enter the source date:  " DB_DATE;echo $DB_DATE;       #get backup date;
                        echo $SRC_PATH"CMnight."$DB_DATE;                               #delete this  line- testing only;
                        #
                        . /pbs/config/am;                                               #set the envirinment to AM;
                        #
                        #prorest AM DB  destination from source
                        #
                        echo "y" | prorest /dbs/am/am           $SRC_PATH"AMnight."$DB_DATE;
                        echo "y" | prorest /dbs/am/address      $SRC_PATH"AMaddressnight."$DB_DATE;
                        echo "y" | prorest /dbs/am/context      $SRC_PATH"AMcontextnight."$DB_DATE;
                        echo "y" | prorest /dbs/am/history      $SRC_PATH"AMhistorynight."$DB_DATE;
                        echo "y" | prorest /dbs/am/services     $SRC_PATH"AMservicesnight."$DB_DATE;
                        #
                        . /pbs/config/cm;                                               #set the environment to CM;
			#
                        #prorest CM DB  destination from source
                        #
                        echo "y" | prorest /dbs/cm/cm          $SRC_PATH"CMnight."$DB_DATE;
                        echo "y" | prorest /dbs/cm/cmaddress   $SRC_PATH"CMaddressnight."$DB_DATE;
                        echo "y" | prorest /dbs/cm/context     $SRC_PATH"CMcontextnight."$DB_DATE;
                        echo "y" | prorest /dbs/cm/ar          $SRC_PATH"CMarnight."$DB_DATE;
                        echo "y" | prorest /dbs/cm/cmservices  $SRC_PATH"CMservicesnight."$DB_DATE;
                        echo "y" | prorest /dbs/cm/gl          $SRC_PATH"CMglnight."$DB_DATE;
                        echo "y" | prorest /dbs/cm/tmc         $SRC_PATH"CMtmcnight."$DB_DATE;
                        #
                        . /pbs/config/im;                                                #set the environment to im;
                        echo "y" | prorest /dbs/im/im           $SRC_PATH"imnight."$DB_DATE;
                        #
                        #. /pbs/config/lm;                                               #set the environment to lm;
                        #echo "y" | prorest /dbs/lm/lm          $SRC_PATH"lmnight."$DB_DATE;
                        #
                        . /pbs/config/ffw;	                                         #set the environment to ffw/webstate;
                        echo "y" | prorest /dbs/ffw/webstate   $SRC_PATH"webstatenight."$DB_DATE;
                        #
                        . /pbs/config/pbs                                                #set the environment to ffw/webstate;
                        echo "y" | prorest /dbs/pbs/pbs        $SRC_PATH"pbsnight."$DB_DATE;;

			#
		ailxpbs01 | wtlxpbs01 | mjlxpbs01)
			case $SYSTEM_NAME in
                                wtlxpbs01)
                                        ZONE="central";;
                                ailxpbs01)
                                        ZONE="eastern";;
				mjlxpbs01)
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
                        echo "y" | prorest /dbs/am/am           $SRC_PATH"AMnight."$DB_DATE;
                        echo "y" | prorest /dbs/am/address      $SRC_PATH"AMaddressnight."$DB_DATE;
                        echo "y" | prorest /dbs/am/context      $SRC_PATH"AMcontextnight."$DB_DATE;
                        echo "y" | prorest /dbs/am/history      $SRC_PATH"AMhistorynight."$DB_DATE;
                        echo "y" | prorest /dbs/am/services     $SRC_PATH"AMservicesnight."$DB_DATE;
                        #
                        . /pbs/config/cm;                                               #set the environment to CM;
                        #
                        #prorest CM DB  destination from source
                        #
                        echo "y" | prorest /dbs/cm/cm          $SRC_PATH"CMnight."$DB_DATE;
                        echo "y" | prorest /dbs/cm/cmaddress   $SRC_PATH"CMaddressnight."$DB_DATE;
                        echo "y" | prorest /dbs/cm/context     $SRC_PATH"CMcontextnight."$DB_DATE;
                        echo "y" | prorest /dbs/cm/ar          $SRC_PATH"CMarnight."$DB_DATE;
                        echo "y" | prorest /dbs/cm/cmservices  $SRC_PATH"CMservicesnight."$DB_DATE;
                        echo "y" | prorest /dbs/cm/gl          $SRC_PATH"CMglnight."$DB_DATE;
                        echo "y" | prorest /dbs/cm/tmc         $SRC_PATH"CMtmcnight."$DB_DATE;
                        #
                        #. /pbs/config/im;                                               #set the environment to im;
                        #
                        . /pbs/config/lm;                                                #set the environment to lm;
                        echo "y" | prorest /dbs/lm/lm          $SRC_PATH"lmnight."$DB_DATE;
                        #
			. /pbs/config/ffw;                                      #set the environment to ffw/webstate;
                        echo "y" | prorest /dbs/ffw/webstate   $SRC_PATH"webstatenight."$DB_DATE;
                        #
                        . /pbs/config/pbs                                                #set the environment to ffw/webstate;
                        echo "y" | prorest /dbs/pbs/pbs        $SRC_PATH"pbsnight."$DB_DATE;;

		vslxpbs01)
                        case $SYSTEM_NAME in
                                vslxpbs01)
                                        ZONE="pacific";;
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
                        echo "y" | prorest /dbs/am/am           $SRC_PATH"AMnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/am/address      $SRC_PATH"AMaddressnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/am/context      $SRC_PATH"AMcontextnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/am/history      $SRC_PATH"AMhistorynight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/am/services     $SRC_PATH"AMservicesnight."$DB_DATE -verbose;
                        #
                        . /pbs/config/cm;                                                #set the environment to CM;
                        #
                        #prorest CM DB  destination from source
                        #
                        echo "y" | prorest /dbs/cm/cm          $SRC_PATH"CMnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/cmaddress   $SRC_PATH"CMaddressnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/context     $SRC_PATH"CMcontextnight."$DB_DATE -verboe;
                        echo "y" | prorest /dbs/cm/ar          $SRC_PATH"CMarnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/cmservices    $SRC_PATH"CMservicesnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/gl          $SRC_PATH"CMglnight."$DB_DATE -verbose;
                        echo "y" | prorest /dbs/cm/tmc         $SRC_PATH"CMtmcnight."$DB_DATE -verbose;
                        #
                        . /pbs/config/im;                                                #set the environment to im;
                        echo "y" | prorest /dbs/im/im           $SRC_PATH"imnight."$DB_DATE -verbose;
                        #
                        . /pbs/config/lm;                                                #set the environment to lm;
                        echo "y" | prorest /dbs/lm/lm          $SRC_PATH"lmnight."$DB_DATE -verbose;
                        #
                        . /pbs/config/ffw;                                               #set the environment to ffw/webstate;
                        echo "y" | prorest /dbs/ffw/webstate   $SRC_PATH"webstatenight."$DB_DATE -verbose;
                        #
                        . /pbs/config/pbs                                                #set the environment to ffw/webstate;
                        echo "y" | prorest /dbs/pbs/pbs        $SRC_PATH"pbsnight."$DB_DATE -verbose;;

                Exit|Quit|exit|quit|e|q|E|Q)
                        exit;;


		*)
			echo "Invalid server choice. Please rerun the script and choose a valid server."
                        echo "1) ailxpbs01 2) arlxpbs01 3) ent-mocbslxpbs01 4) cclxpbs01 5) ndlxpbs01"
                        echo "6) rrlxpbs01 7) sslxpbs01 8) sulxpbs01 9) vslxpbs01 10) wtlxpbs01 11)knlxpbs01 12)mjlxpbs01"
                        exit;;

	esac
done


