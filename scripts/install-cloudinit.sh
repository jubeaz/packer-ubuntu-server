#!/usr/bin/bash -x

#sudo apt-get -y update
sudo apt-get -y purge cloud-init
rm  /var/log/cloud*
rm -r /var/lib/cloud
rm -r /etc/cloud/cloud.cfg.d/*

sudo apt-get -y install cloud-init

systemctl enable cloud-init-local.service
systemctl enable cloud-init.service
systemctl enable cloud-config.service
systemctl enable cloud-final.service

echo " >>>>>>>>>>>> ${HTTPSRV}"
cp /etc/cloud/cloud.cfg /etc/cloud/cloud.cfg.save
/usr/bin/curl -o /etc/cloud/cloud.cfg http://${HTTPSRV}/cloud/cloud.cfg

cat /etc/cloud/cloud.cfg
rm /etc/netplan/*

