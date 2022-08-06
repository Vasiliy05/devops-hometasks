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

cd /etc/default/
curl -O https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/feature-02/task-02/conf-lxc/lxc-net
systemctl restart lxc-net

lxc-create -n html-site -f /root/.config/lxc/root.conf --template download -- --dist centos --release 8-Stream --arch amd64
lxc-start html-site
lxc-ls -f
lxc-attach html-site
yum update
yum -y -q install -y httpd httpd-devel httpd-tools

mkdir -p /var/www/siteone/html
cd /var/www/siteone/html
curl -O https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/master/task-01/index/index.html

cd /etc/httpd/conf.d/
curl -O https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/master/task-01/conf/siteone.conf

exit

#lxc-create -n php-site -f /home/vagrant/.config/lxc/root.conf --template download -- --dist centos --release 8-Stream --arch amd64
#yum update
#yum -y -q install -y httpd httpd-devel httpd-tools
#
#echo 'Listen 81' >> /etc/httpd/conf/httpd.conf
#echo 'ServerName 127.0.0.1' >> /etc/httpd/conf/httpd.conf
#
#mkdir -p /var/www/sitetwo/html
#cd /var/www/sitetwo/html
#curl -O
#
#cd /etc/httpd/conf.d/