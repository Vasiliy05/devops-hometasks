sudo su
apt update
apt install -y lxc lxc-templates curl
systemctl enable lxc
systemctl start lxc

apt -y purge gnupg
apt -y install --reinstall gnupg2
apt -y install dirmngr

iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 80 -j DNAT --to-destination 10.0.3.121
iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 81 -j DNAT --to-destination 10.0.3.122
iptables -L -t nat

echo 'kernel.unprivileged_userns_clone=1' >> /etc/sysctl.conf

echo 'export DOWNLOAD_KEYSERVER="hkp://keyserver.ubuntu.com"' >> ~/.bashrc
. .bashrc

cp /etc/default/grub /etc/default/grub.bak

cd /etc/default/
curl -O https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/feature-02/task-02/conf-lxc/grub
update-grub

mkdir -p ~/.config/lxc/
cd ~/.config/lxc/
curl -O  https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/feature-02/task-02/conf-lxc/root.conf

touch /etc/lxc/lxc-usernet
cd /etc/lxc
curl -O https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/feature-02/task-02/conf-lxc/lxc-usernet

#cd /etc/default/
#curl -O https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/feature-02/task-02/conf-lxc/lxc-net
#systemctl restart lxc-net

lxc-create -n static_site -f /root/.config/lxc/root.conf --template download -- --dist centos --release 8-Stream --arch amd64 --keyserver hkp://keyserver.ubuntu.com
lxc-ls -f

#cd /var/lib/lxc/static_site/rootfs/etc/sysconfig/network-scripts/
#curl -O https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/feature-02/task-02/static_site/ifcfg-eth0

lxc-start static_site
lxc-ls -f
lxc-attach static_site
yum update
yum -y -q install -y httpd httpd-devel httpd-tools

mkdir -p /var/www/siteone/html
cd /var/www/siteone/html
curl -O https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/feature-02/task-02/static_site/index.html

cd /etc/httpd/conf.d/
curl -O https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/feature-02/task-02/static_site/siteone.conf

systemctl disable firewalld
service firewalld stop
setenforce 0
systemctl restart httpd
exit

#lxc-create -n dinamic -f /home/vagrant/.config/lxc/root.conf --template download -- --dist centos --release 8-Stream --arch amd64 --keyserver hkp://keyserver.ubuntu.com

#cd /var/lib/lxc/dinamic/rootfs/etc/sysconfig/network-scripts/
#curl -O https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/feature-02/task-02/dinamic_site/ifcfg-eth0

#lxc-start dinamic
#lxc-ls -f
#lxc-attach dinamic

#yum update
#yum -y -q install -y httpd httpd-devel httpd-tools
#
#echo 'Listen 81' >> /etc/httpd/conf/httpd.conf
#echo 'ServerName 127.0.0.1' >> /etc/httpd/conf/httpd.conf
#
#mkdir -p /var/www/sitetwo/html
#cd /var/www/sitetwo/html
#curl -O https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/feature-02/task-02/dinamic_site/index.php
#
#cd /etc/httpd/conf.d/
#curl -O https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/feature-02/task-02/dinamic_site/sitetwo.conf

#systemctl disable firewalld
#service firewalld stop
#setenforce 0
#systemctl restart httpd
#exit