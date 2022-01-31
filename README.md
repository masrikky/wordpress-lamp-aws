# Amazon Web Service - EC2 WordPress
---

This is guide to install WordPress on AWS EC2 Instance with LAMP stack.
I launch my EC2 Instance on **ap-southeast-3 region (Jakarta)**.

---
### Overview :

1. Sign in to your AWS account.
2. From **Console**, navigate to **Services**.
3. Select **Compute** from the drop down menu.
4. Choose EC2,
5. After you see EC2 Dashboard, you can scroll down and select **Launch instances** or you can select **Instance** from the left menu.
6. Select **Launch instances**.
7. Select your prefered **Operating Systems**, in this case i choose **Ubuntu Server 20.04 LTS**.
8. After you see "Choose an instance type", you can select t3.micro, this should be enough if you just plan to host your personal website.
9. You can select **Review and Launch** for fast forward, but we need to configure **Security Groups**, so select **Security Groups**
10. In **Security Groups**, open port for HTTP (port 80) and HTTPS (port 443).
11. If you just begin your AWS learning journey, you might see **generate key pairs**, if you have previous AWS key pairs you can use it here, otherwise you can generate new one, we'll use this key pair (private key that we store) to log in to our instance using SSH.
12. Install/download package (Apache, MySQL, few PHP packages, WordPress)
13. Configure your database
14. Install Wordpress
15. Done


---
### Entering the instance

1. Login using SSH `ssh -i "rikky_wp_ec2.pem" ubuntu@ec2-108-x-x-x.ap-southeast-3.compute.amazonaws.com`
	> **rikky_wp_ec2.pem**	is your private key
	> 
	> you can get **ec2-108-x-x-x.ap-southeast-3.compute.amazonaws.com** from your instance details, alternatively you can use IP address instead of Public IPv4 DNS. 
2. Enter as root user `sudo su`
3. Check for available update `apt upgrade && apt upgrade -y`
4. Install Apache `apt install apache2`
5. Install PHP Packages `apt install php libapache2-mod-php php-curl php-dom php-mbstring php-imagick php-zip php-gd`
6. 
7. Install MySQL `apt install mariadb-server`
8. Configure MySQL
     - Type : `mysql_secure_installation`.
     - Remove anonymous users? (Press y|Y for Yes, any other key for No) : **Y**
     - Disallow root login remotely? (Press y|Y for Yes, any other key for No) : **Y**
     - Remove test database and access to it? (Press y|Y for Yes, any other key for No) : **Y**
     - Reload privilege tables now? (Press y|Y for Yes, any other key for No) : **Y**
     - Enter MySQL : `mysql`
     - Create Database : `CREATE DATABASE wplampp`
     - Create User : `CREATE USER 'rikkywplampp'@'localhost' IDENTIFIED BY 'RinduKokSt@lk1ng';` change **rikkywplampp** with your prefered username, and change **RinduKokSt@lk1ng** with your prefered passsword (should be difficult to guest).
     - Grant privileges : `GRANT ALL PRIVILEGES ON wplampp.* TO 'rikkywplampp'@'localhost';`
     - Flush : `FLUSH PRIVILEGES;`
     - Exit MySQL : `exit`
9. Navigate to apache directory `cd /var/etc/www/html`
10. Download wordpress instalation package `wget https://wordpress.org/latest.tar.gz`
11. Extract **latest.tar.gz** : `tar -xzvf latest.tar.gz`
12. You can delete **latest.tar.gz** from this directory : `rm latest.tar.gz`
13. Enter wordpress directory : `cd wordpress`
14. Move all file and directory to previous directory : `mv * ..`
15. Go back and delete wordpress directory
16. Configure wordpress :
	- Rename **wp-config-sample.php** : `mv wp-config-sample.php wp-config.php`
	- Open **wp-config.php** (i use nano, vim is also okay), `nano wp-config.php`
	- Change DB_NAME value with **wplampp**
	- Change DB_USER value with **rikkywplampp**
	- Change DB_PASSWORD value with **RinduKokSt@lk1ng**
	- DB_HOST should be **localhost**
	- Everything okay, save and close this file.
17. Change file and directory permission
	> `chown -R www-data:www-data *`
	> 
	> `find * -type d -exec chmod 755 {} \;`
	>
	> `find * -type f -exec chmod 644 {} \;`
18. Open your browser and open this address : "http://108.x.x.x/wp-admin/install.php", IP Address should be replace with your EC2 IP
19. Follow wordpress instalation process, like select Language, Username, Password, Email.
20. Last, press **Install WordPress**

--- 
### Managing your WordPress
1. Login to your dashboard, should be "http://108.x.x.x/wp-admin/" or "http://108.x.x.x/login" to get login page.
2. Enter Username and Password.
3. Try to post or edit current one.

---
### Note
To make you easier to do this, you can clone this repo. And run lamp.sh shell script to install LAMPP stack.
I attach few screenshot in img folder.

- run lampp.sh : `bash lampp.sh`
- configure mysql and with above instructions
- install wordpress
- done

Anyway if you in hurry you can install WordPress from AWS Marketplace (is free to, you just for instances that you launch.