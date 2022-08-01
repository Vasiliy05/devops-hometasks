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
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
yum module list php
yum module enable php:7.4 -y
yum install -y php php-cli php-common 

echo "================================================================================"
echo ">>> Installing PHP VERSION:"
echo "================================================================================"
php -v

echo 'Listen 81' >> /etc/httpd/conf/httpd.conf
echo 'ServerName 127.0.0.1' >> /etc/httpd/conf/httpd.conf

#mkdir /etc/httpd/sites-available /etc/httpd/sites-enabled
#echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf

#create dir siteone
mkdir -p /var/www/siteone/html
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

# setup hosts file siteone
CONFHTML=$(cat <<EOF
<VirtualHost *:81>
    ServerAdmin webmaster@localhost
	DocumentRoot /var/www/siteone/html
    #ErrorLog ${APACHE_LOG_DIR}/error.log
	#CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF
)
echo "${CONFHTML}" >  /etc/httpd/conf.d/siteone.conf

#create dir sitetwo
mkdir -p /var/www/sitetwo/html
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
echo "${INPHP}" > /var/www/sitetwo/html/index.php

# setup hosts file sitetwo
CONFPHP=$(cat <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@localhost
	DocumentRoot /var/www/sitetwo/html
    #ErrorLog ${APACHE_LOG_DIR}/error.log
	#CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF
)
echo "${CONFPHP}" >  /etc/httpd/conf.d/sitetwo.conf

#active siteone and sitetwo
#ln -s /etc/httpd/sites-available/siteone.conf /etc/httpd/sites-enabled/siteone.conf
#ln -s /etc/httpd/sites-available/sitetwo.conf /etc/httpd/sites-enabled/sitetwo.conf

chown -R apache.apache /var/www/
chmod -R 755 /var/www
service firewalld stop

# restart apache
systemctl restart httpd