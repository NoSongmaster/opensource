#!/bin/bash
set -e

# Step1:
# Deployment dependency
#yum install -y smartmontools dmidecode

# Step2:
# Download package
install_path='/var/opt/darkagent'
wget -O darkagent.tar.gz -q http://172.16.138.129/zengfu/goOfflineAgent/repository/master/archive.tar.gz
mkdir -p $install_path
tar -xzf darkagent.tar.gz -C $install_path --strip-components 1
rm -f darkagent.tar.gz

# Step3:
# Start service
cd $install_path
/bin/bash ${install_path}/bin/service.sh stop
/bin/bash ${install_path}/bin/service.sh start

# Step4:
# Join Host init.d 
cp ${install_path}/bin/darkagent /etc/rc.d/init.d/
chmod +x /etc/rc.d/init.d/darkagent
chkconfig --add darkagent
chkconfig darkagent on

