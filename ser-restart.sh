#
cd /etc/vmware-tools
./services.sh restart
./services.sh status

service cups restart

. /home/130450/lpr-enable.sh

service vsftpd restart

service httpd restart

service crond restart

service sendmail restart

service nfs restart

#chkconfig nimbus on
chkconfig crond on

service crond status
#service nimbus status
chkconfig crond on
#chkconfig nimbus on

chkconfig --list | grep cron
chkconfig --list | grep nimbus

mount -a

ls /proback
df -h

