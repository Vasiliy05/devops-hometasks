sudo apt update
sudo apt upgrade
sudo apt install -y apache2 

sudo apt -y install lsb-release apt-transport-https ca-certificates wget
sudo wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/php.list

sudo apt update
sudo apt -y install php7.4

php -v
#create dir siteone
mkdir -p /var/www/siteone/html
cp /home/vagrant/index/index.html /var/www/siteone/html
cp /home/vagrant/conf/siteone.conf /etc/apache2/sites-available/

#create dir sitetwo
mkdir -p /var/www/sitetwo/html
cp /home/vagrant/index/index.php /var/www/sitetwo/html
cp /home/vagrant/conf/sitetwo.conf /etc/apache2/sites-available/

#active siteone and sitetwo
sudo a2ensite siteone.conf
sudo a2ensite sitetwo.conf
sudo a2dissite 000-default.conf

# restart apache
systemctl restart apache2