sudo su
apt update
apt install -y -d lxc lxc-templates
systemctl enable lxc
systemctl start lxc

apt -y purge gnupg
apt -y install --reinstall gnupg2
apt -y install dirmngr

sudo iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 80 -j DNAT --to-destination 10.0.3.121
sudo iptables -t nat -A PREROUTING -p tcp -i eth0 --dport 81 -j DNAT --to-destination 10.0.3.122
sudo iptables -L -t nat

echo 'kernel.unprivileged_userns_clone=1' >> /etc/sysctl.conf

echo 'export DOWNLOAD_KEYSERVER="hkp://keyserver.ubuntu.com"' >> ~/.bashrc
cp /etc/default/grub /etc/default/grub.bak
cd /etc/default/grub
curl -O 

#sudo echo 'systemd.legacy_systemd_cgroup_controller=yes' >> /etc/default/grub
#sudo echo GRUB_CMDLINE_LINUX_DEFAULT="net.ifnames=0 systemd.legacy_systemd_cgroup_controller=yes" >> /etc/default/grub
update-grub


vi ~/.config/lxc/default.conf

lxc.net.0.type = veth
lxc.net.0.flags = up
lxc.net.0.link = lxcbr0

lxc.apparmor.profile = unconfined
lxc.apparmor.allow_nesting = 1

lxc.start.auto = 1

yum update
yum -y -q install -y httpd httpd-devel httpd-tools

echo 'Listen 81' >> /etc/httpd/conf/httpd.conf
echo 'ServerName 127.0.0.1' >> /etc/httpd/conf/httpd.conf
mkdir -p /var/www/siteone/html
cd /var/www/siteone/html
curl -O https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/master/task-01/index/index.html

cd /etc/httpd/conf.d/
curl -O https://raw.githubusercontent.com/Vasiliy05/devops-hometasks/master/task-01/conf/siteone.conf
