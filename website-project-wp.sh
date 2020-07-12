#!bin/sh

#########################################
#
#		Copyright (c) AlexonbStudio for free(dom)
#		Date 12/07/2020 - 19:31 (BETA)
#########################################
domain=""
name=""
players="play"
pmmps="$players.$domain"
phpversionsUBU="7.4"
phpversionsDEB="7.3"

	apt install -y git


	chown -R ${SUDO_USER}:${SUDO_USER} /var/www/html/
	chown -R ${SUDO_USER}:${SUDO_USER} /var/www/html
	echo "EDIT THE FILE ON FOLDER [SITE.TLD]/configuration/sites.php\n"
	echo "WITH FTP OR SFTP\n"
	echo "$sites['name'] #Personal/Compagny name\n"
	echo "$sites['domain'] #your-domain.tld"
	echo "===================AUTO CONFIG WEBSITE====================="
	echo "do it: sh ./website-project-wp.sh domain=your-domain.tld name=Name-compagny"
	echo "Open your browser and access your domaine-name.tld | DONE!!!!:) "
	echo "Custom all <<Configuration>> & <<themes>> folder possible"
	
if [ $domain ] && [ $name ]; then
	apt install zip unzip mariadb-server php php-xml php-fpm php-cli php-curl php-mysql php-gd php-mbstring php-imagick php-intl php-xml php-zip php-cgi php-xmlrpc php-soap tidy php-tidy sqlite php-pear -y
	cd /var/www/${domain}
	git clone https://github.com/website-project-WP/free-wp.git
	echo "<?php
/
exemple $sites['show'];
exemple $sites['update']['rdf'];
exemple $sites['e-mail']['contact'];

*/
$sites = array(
	'name' => '$name',
	'domain' => '$domain', /domain: exemple.tld*/
	'protocol' => isset($_SERVER[\"HTTPS\"]) ? 'https' : 'http',
	'template' => 'default',
	'create' => array(),
	'update' => array(
		'rdf' => date('Y-m-d')
	),
	'copyright' => array(
		'frontend' => 'Copyright &copy; 2020-'.date('Y'), /show on template */
		'rdf' => 'Copyright &copy;' /show only template seo/txt/rdf*/
	),
	'head' => array(
		'robots' => 'noopd, noydir' /Only show on template header.php | robots meta*/
	),
	'default-timezone' => 'Etc/UTC' /Docs PHP variable date_default_timezone_set() */
);

$JE_sites = json_encode($sites);

#Secret hidden debug json

#####################################
#									#
#			DATABASE|ADODB			#
#									#
#####################################
/
$hostDB = 'localhost';
$nameDB = '';
$userDB = '';
$passwdDB = '';
$portDB = 3306;
*/

#####################################
#									#
#			Email|SMTP 				#
#									#
#####################################
/
$hostMAIL = 'mail.exemple.tld';
$userMAIL = 'user@exemple.tld';
$passwdMAIL = '****';
$portMAIL = 587;
*/


?>" > "/var/www/$domain/configuration/sites.php"
echo "<html>
	<head>
		<title>$name - Minecraft Bedrock server </title>
	</head>
	<body>
		<h1>Welcome Minecraft Bedrock server </h1>
		<h2>Play with Android/Apple/Windows/Xbox/Playstation </h2>
		<p><b>OUR SERVER (ipv4): $pmmps port: 19132</b><br>
		<b>OUR SERVER (ipv6): $pmmps port: 19133</b><br>
		Visite our website <a href=\"https://$domain\">$name</a> for more information<br>
		Thank to <a href=\"https://alexonbstudio.fr\" rel=\"dofollow\">AlexonbStudio</a></p>
	
	</body>
</html>" > /var/www/play/index.html
	rm -rf /var/www/${domain}/index.html
	chown -R ${SUDO_USER}:${SUDO_USER} /var/www/play/index.html
	chown -R ${SUDO_USER}:${SUDO_USER} /var/www/${domain}/
	chown -R ${SUDO_USER}:${SUDO_USER} /var/www/${domain}/configuration/sites.php
	if [ -z $phpversionsDEB != $phpversionsUBU ]; then
		echo "Debian 10 Version"
		systemctl enable php${phpversionsDEB}-fpm 
		/lib/systemd/systemd-sysv-install enable php${phpversionsDEB}-fpm
		mv php.ini /etc/php/${phpversionsDEB}/fpm/php.ini
		systemctl restart php${phpversionsDEB}-fpm 
	else
		echo "Ubuntu 20.04 Version"
		systemctl enable php${phpversionsUBU}-fpm
		/lib/systemd/systemd-sysv-install enable php${phpversionsUBU}-fpm 
		mv php-ubuntu.ini /etc/php/${phpversionsUBU}/fpm/php.ini
		systemctl restart php${phpversionsUBU}-fpm 
	fi
	
	chown -R $SUDO_USER:$SUDO_USER /var/www/play/
	cd /var/www/play/ && ./start.sh
fi
