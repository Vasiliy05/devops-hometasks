sudo su
mysql
echo "================================================================================"
echo ">>> Installing MySQL"
echo "================================================================================"
yum install -y mysql mysql-server mysql-devel
systemctl enable mysqld.service
systemctl restart mysqld.service
echo "================================================================================"
echo ">>> DATABASES MySQL"
echo "================================================================================"
mysql -u root -e "SHOW DATABASES";

#apache
echo "================================================================================"
echo ">>> Installing Apache"
echo "================================================================================"
yum -y -q install -y httpd httpd-devel httpd-tools
systemctl enable httpd
systemctl start httpd

php
echo "================================================================================"
echo ">>> Installing PHP 7.4"
echo "================================================================================"
yum -y install yum-utils epel-release wget
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install -y php7.4-xml
yum --enablerepo=remi-php74 install -y php php-bz2 php-mysql php-curl php-gd php-intl php-common php-mbstring php-xml

yum-config-manager --enable remi-php74
yum -y update
yum -y install php php-cli php-common php-fpm php-mysqlnd php-zip php-devel php-gd php-mbstring php-curl php-xml php-pear php-bcmath php-json

echo "================================================================================"
echo ">>> Installing PHP VERSION:"
echo "================================================================================"
php -v

echo 'Listen 81' >> /etc/httpd/conf/httpd.conf

mkdir /etc/httpd/sites-available /etc/httpd/sites-enabled
echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf

systemctl restart httpd

#create dir siteone
mkdir -p /var/www/siteone/html
#cp /home/vagrant/index/index.html /var/www/siteone/html
#cp /home/vagrant/conf/siteone.conf /etc/httpd/sites-available/
# setup hosts file
INHTML=$(cat <<EOF
<html>
  <head>
    <title>Success!</title>
  </head>
  <body>
    You Vagrantfile is fine if you can see this message.
  </body>
</html>
EOF
)
echo "${INHTML}" > /var/www/siteone/html/index.html

CONFHTML=$(cat <<EOF
<VirtualHost *:81>
    ServerAdmin webmaster@localhost
	DocumentRoot /var/www/siteone/html
    ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF
)
echo "${CONFHTML}" > /etc/httpd/sites-available/siteone.conf

#create dir sitetwo
mkdir -p /var/www/sitetwo/html
#cp /home/vagrant/index/index.php /var/www/sitetwo/html
#cp /home/vagrant/conf/sitetwo.conf /etc/httpd/sites-available/
INPHP=$(cat <<EOF
<html>
  <head>
    <title>Site is running PHP version <?= phpversion(); ?></title>
  </head>
  <body>
    <?php
      $limit = rand(1, 1000);
      for ($i=0; $i<$limit; $i++){
        echo "<p>Hello, world!</p>";
      }
    ?>
  </body>
</html>
EOF
)
echo "${INPHP}" > /var/www/sitetwo/html/index.html

CONFPHP=$(cat <<EOF
<VirtualHost *:81>
    ServerAdmin webmaster@localhost
	DocumentRoot /var/www/sitetwo/html
    ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF
)
echo "${CONFPHP}" > /etc/httpd/sites-available/sitetwo.conf

#active siteone and sitetwo
ln -s /etc/httpd/sites-available/siteone.conf /etc/httpd/sites-enabled/siteone.conf
ln -s /etc/httpd/sites-available/sitetwo.conf /etc/httpd/sites-enabled/sitetwo.conf

# restart apache
systemctl restart apache2