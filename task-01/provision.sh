sudo apt update
sudo apt upgrade
sudo apt install -y apache2 php

php -v

echo 'Listen 81' >> /etc/apache2/ports.conf

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