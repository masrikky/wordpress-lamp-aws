apt upgrade && apt upgrade -y
apt install apache2 -y
apt install php libapache2-mod-php php-curl php-dom php-mbstring php-imagick php-zip php-gd -y
apt install mariadb-server -y
wget https://wordpress.org/latest.tar.gz -P /var/www/html/
tar -xzvf /var/www/html/latest.tar.gz
mv /var/www/html/wordpress/* /var/www/html/
find /var/www/html/* -type d -exec chmod 755 {} \;
find /var/www/html/* -type f -exec chmod 644 {} \;
systemctl restart apache2
systemctl restart mariadb