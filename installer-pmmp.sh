#!bin/sh

#########################################
#
#		Copyright (c) AlexonbStudio
#		Date 11/07/2020 - 22:44 (BETA)
#
#########################################



 cd /var/www/play
wget https://jenkins.pmmp.io/job/PHP-7.3-Aggregate/lastSuccessfulBuild/artifact/PHP-7.3-Linux-x86_64.tar.gz

tar -zxvf PHP-7.3-Linux-x86_64.tar.gz && rm -rf PHP-7.3-Linux-x86_64.tar.gz
curl -O https://github.com/pmmp/PocketMine-MP/releases/download/3.14.1/PocketMine-MP.phar -O https://github.com/pmmp/PocketMine-MP/releases/download/3.14.1/start.sh

chmod +x PocketMine-MP.phar start.sh


echo "IS NOW START then STOP & EDIT the FILE will start on 10 second"
echo "Then Testéd after do <<stop>> commend line"
echo "when done success do this: <<screen>> & <<./start.sh>>"
echo '<html>
	<head>
		<title>Installer Crypt by AlexonbStudio</title>
	</head>
	<body>
		<h1>Installer Minecraft Bedrock PocketMine-MP</h1>
		<p>Scripting create by <a href="https://alexonbstudio.fr" rel="dofollow">
		AlexonbStudio</a></p>
	
	</body>
</html>' > index.html
chown -R $SUDO_USER:$SUDO_USER /var/www/play/*