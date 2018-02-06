HOSTNAME=$(hostname)

echo $HOSTNAME

case $HOSTNAME in
        vslxpbs01 | vslxpbstst01 | knlxpbs01 | eclxpbs01 )
                echo "DB=$DBVOL/cm/services" ;;
        mclxpbs01 | mclxpbs02  )
        echo "DB=$DBVOL/cm/cmservices" ;;
esac

