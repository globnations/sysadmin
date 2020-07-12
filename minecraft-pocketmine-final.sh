#!bin/sh
#########################################
#
#		Copyright (c) AlexonbStudio for free(dom)
#		Date 10/07/2020 - 19:31 (beta)
#		This script require VPS & more
#########################################
clear



# Update
apt-get update && apt-get upgrade -y
apt update && apt upgrade -y
apt-get install software-properties-common && add-apt-repository universe

# Install PKG
apt install -y curl openssl nginx certbot python3-certbot-nginx clamav clamav-daemon fail2ban net-tools screen ufw

# Enable fonction systemctl
########		SERVER WEB		########
systemctl enable nginx 
 /lib/systemd/systemd-sysv-install enable nginx

########		ANTIVIRUS		########
systemctl enable clamav-freshclam 
 /lib/systemd/systemd-sysv-install enable clamav-freshclam

########		FAILTOBAN		########
systemctl enable fail2ban
 /lib/systemd/systemd-sysv-install enable fail2ban

# Enable exemple: systemctl restart nginx 
echo "\n\nSystemctl using easier recommandation\n\n"
systemctl enable nginx 
 /lib/systemd/systemd-sysv-install enable nginx
systemctl enable clamav-freshclam 
 /lib/systemd/systemd-sysv-install enable clamav-freshclam
systemctl enable fail2ban 
 /lib/systemd/systemd-sysv-install enable fail2ban
echo "\n\nThe notice recommand\n\n"
echo "\n\n How to use, exemple: systemctl restart nginx \n\n"



##################################################################

echo '==========			BEGIN RESOLV CONFIG (Cloudflare DNS+Anti-malware)			=========='

echo "\n\n\n
#Cloudflare DNS+Anti-malware \n 
nameserver 1.1.1.2 \n 
nameserver 1.0.0.2 \n 
nameserver 2606:4700:4700::1112 \n 
nameserver 2606:4700:4700::1002" >> /etc/resolv.conf  
echo '==========			END RESOLV CONFIG (Cloudflare DNS+Anti-malware)			=========='


##################################################################

echo '==========			BEGIN HOSTNAME+HOST CONFIG			=========='


	echo "##########			HELP STARTER			##########\n\n"
	echo "\n\nStep 1) ./minecraft-pocketmine-final.sh domain=alexonbstudio.tld #default domain\n\n"
	echo "\n\nStep 2) ./minecraft-pocketmine-final.sh ipv4local=x.x.x.x domain=alexonbstudio.tld #ipv4local domain hosts\n\n"
	echo "\n\nStep 3) ./minecraft-pocketmine-final.sh ipv6local=x:x:::x:x domain=alexonbstudio.tld #ipv6local domain hosts\n\n"
	echo "\n\n##########			HELP END			##########"

# special 
domain=""
ipv4local=""
ipv6local=""
myipv4public=""
myipv6public=""
mailinetrn="mail"
players="play"
www="www"
mailsslsdomain="$mailinetrn.$domain"
playerdomain="$players.$domain"
domainname="$www.$domain"

	
if [ $ipv4local ] && [ $domain ]; then

	echo "${ipv4local} $playerdomain ${domain} $mailsslsdomain \n 
	#127.0.0.1 $playerdomain ${domain} $mailsslsdomain \n" >> /etc/hosts
			
fi

if [ $ipv6local ] && [ $domain ]; then

	echo "${ipv6local} $playerdomain ${domain} $mailsslsdomain \n 
	#::1 $playerdomain ${domain} $mailsslsdomain \n" >> /etc/hosts
			
fi	

echo '==========			END HOSTNAME+HOST CONFIG			=========='


##################################################################

echo '==========			BEGIN SECURITY FAIL2BAN			=========='

#cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local



#fail2ban-client reload
echo '==========			END SECURITY FAIL2BAN			=========='

##################################################################

echo '==========			BEGIN SECURITY FIREWALL UFW			=========='
# Vider les tables actuelles
iptables -t filter -F

# Vider les règles personnelles
iptables -t filter -X

# deleted old & reset firewall
ufw reset 

#secure policy
#ufw default deny incoming
#ufw default deny outgoing


# SSH
ufw allow 22/tcp
#ufw limit 22/tcp
#ufw reject auth

# HTTP(S)
#ufw allow 80/tcp
#ufw allow 443/tcp
ufw allow proto tcp from any to any port 80,443 

echo "Minecraft firewall ipV4 BOTH activated TCP/UDP"
ufw allow 192132


echo "Minecraft firewall ipV6 BOTH activated TCP/UDP"
ufw allow 192133 proto ipv6

	echo "##########			HELP STARTER			##########\n\n"
	echo "INFO knwon your ipv4/ipv6 on https://ip.lafibre.info/\n\n"
	echo "\n\n ./minecraft-pocketmine-final.sh myipv4public=x.x.x.x #ipv4local domain hosts\n\n"
	echo "\n\n ./minecraft-pocketmine-final.sh myipv6public=x:x:::x:x #ipv6local domain hosts\n\n"
	echo "\n\n##########			HELP END			##########"

if [ $myipv4public ]; then
	# Exceptional myip ssh access
	echo "Only Your own IPv4 can access: ${myipv4public}"
	ufw allow from ${myipv4public} to any port 22 proto tcp
	ufw reload
fi
if [ $myipv6public ]; then
	# Exceptional myip ssh access
	echo "Only Your own IPv6 can access: ${myipv6public}"
	ufw allow from ${myipv6public} to any port 22 proto tcp
	ufw reload
fi


# loopback
ufw allow lo

# NAT
ufw allow nat

# DNS
ufw allow 53

# EMAIL
ufw allow proto tcp from any to any port 25,587,993

# ICMP (Ping)
ufw allow icmp

ufw logging on 

ufw enable

echo '==========			END SECURITY FIREWALL UFW			=========='

##################################################################

echo '==========			BEGIN SECURITY SYSTEM		=========='

chown root:root passwd shadow group gshadow
chmod 644 passwd group
chmod 400 shadow gshadow


chmod g-w /home/${SUDO_USER} /home/${USER}
chmod o-rwx /home/${SUDO_USER} /home/${USER}

echo '==========			END SECURITY SYSTEM			=========='

##################################################################

echo '==========			BEGIN SECURITY FIREWALL UFW			=========='



echo '==========			END SECURITY FIREWALL UFW			=========='

##################################################################

if [ $domain ]; then
	hostnamectl set-hostname ${playerdomain}
	
	rm -rf /var/www/html/*
	echo "<html><head><meta http-equiv=\"refresh\" content=\"10;URL=https://alexonbstudio.fr\"></head><body><a href=\"//alexonbstudio.fr\">AlexonbStudio</a></body></html>" > /var/www/html/index.html
	echo '==========			BEGIN NGINX CONFIG			=========='
	mkdir -p /var/www/${players} 
	echo "<html><head><meta http-equiv=\"refresh\" content=\"10;URL=https://alexonbstudio.fr\"></head><body><a href=\"//alexonbstudio.fr\">AlexonbStudio</a></body></html>" > /var/www/${players}/index.html
	echo "server {
			listen 80;
			listen [::]:80;
			root /var/www/$players;
			index index.php index.html;

			server_name $playerdomain;
			
			location ~ \.php$ {
			       include snippets/fastcgi-php.conf;
			
			       # With php-fpm (or other unix sockets):
			       fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
			#       # With php-cgi (or other tcp sockets):
			#       fastcgi_pass 127.0.0.1:9000;
			}
			
			location / {
					try_files $uri $uri/ =404;
			}

			#DENY HTACCESS
			location ~ /\.ht {
				   deny all;
			}
	}" > /etc/nginx/sites-available/${playerdomain} 
	cp /etc/nginx/sites-available/${playerdomain} /etc/nginx/sites-enabled/${playerdomain} 
	mkdir -p /var/www/${domain} 
	echo "<html><head><meta http-equiv=\"refresh\" content=\"10;URL=https://alexonbstudio.fr\"></head><body><a href=\"//alexonbstudio.fr\">AlexonbStudio</a></body></html>" > /var/www/${domain}/index.html
	echo "server {
			listen 80;
			listen [::]:80;
			root /var/www/$domain;
			index index.php index.html;

			server_name $domain;

			location ~ \.php$ {
			       include snippets/fastcgi-php.conf;
			
			       # With php-fpm (or other unix sockets):
			       fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
			#       # With php-cgi (or other tcp sockets):
			#       fastcgi_pass 127.0.0.1:9000;
			}
			
			location / {
					try_files $uri $uri/ =404;
			}

			#DENY HTACCESS
			location ~ /\.ht {
				   deny all;
			}
	}" > /etc/nginx/sites-available/${domain} 
	cp /etc/nginx/sites-available/${domain} /etc/nginx/sites-enabled/${domain} 
	mv /etc/nginx/nginx-pmmp.conf /etc/nginx/nginx.conf 
	echo '==========			END NGINX CONFIG			=========='
	systemctl restart nginx
	echo '==========			BEGIN CERTBOT AUTO		=========='
	certbot -d ${domain} -d ${playerdomain} -d ${mailsslsdomain}
	openssl x509 -noout -dates -in ${certpmmp}
	echo '==========			END CERTBOT AUTO			=========='
	echo '==========			BEGIN CRONTAB			=========='

	(crontab -l 2>>/dev/null; echo "@weekly rm -rf /var/log/nginx/*.log \n
	@monthly rm -rf /var/log/apt/*.log \n
	@monthly rm -rf /var/log/clamav/*.log \n
	@monthly rm -rf /var/log/journal/*.log \n
	@monthly rm -rf /var/log/letsencrypt/*.log \n
	@weekly apt update && apt upgrade -y \n
	@weekly apt-get update && apt-get upgrade -y \n
	@daily systemctl stop clamav-freshclam && freshclam --quiet && systemctl start clamav-freshclam \n
	@monthly certbot -d $domain -d $playerdomain -d $mailsslsdomain --force-renewal --quiet") | crontab -

	echo '==========			END CRONTAB			=========='
	echo '==========			BEGIN EMAIL SECURE			=========='

	curl -LO lukesmith.xyz/emailwiz.sh

	echo '==========			END EMAIL SECURE			=========='
	if [ $ipv4local ]; then
		echo "${ipv4local}" >> /etc/postfix/dkim/trustedhosts
	fi
	if [ $ipv6local ]; then
		echo "${ipv6local}" >> /etc/postfix/dkim/trustedhosts
	fi
fi



##################################################################


# Sept install Complet Minecraft Bedrock PocketMine-MP

echo 'Now we download and install for you Minecraft Bedrock PocketMine-MP 3.14.1'
echo 'do it: sh ./installer-pmmp.sh'

################################ HELPER
if [ $domain ]; then
	echo "ipV4-server A $domain
	ipV4-server A $domainname
	ipV4-server A $playerdomain
	ipV4-server A $mailsslsdomain
	ipV4-server A $domain

	ipV6-server AAAA $domain
	ipV6-server AAAA $domainname
	ipV6-server AAAA $playerdomain
	ipV6-server AAAA $mailsslsdomain
	ipV6-server AAAA $domain

	" > /home/${SUDO_USER}/dns_minecraft_pocketmine

	chown -R ${SUDO_USER}:${SUDO_USER} /home/${SUDO_USER}/dns_minecraft_pocketmine
	cat /home/${SUDO_USER}/dns_minecraft_pocketmine
fi







