#!/bin/bash

# This Script is to install NGINX and ModSecurity onto Alma Linux or CentOS/Fedora Based Systems.

############################################

#Functions
update () { yes | dnf check-update && sudo dnf update && yum check-update && sudo yum update; }



#Update the System

echo "Would you like to update the system? (y/n/e)"

read -n1 yesorno
echo " "

if [ "$yesorno" = y ]; then
	update
elif [ "$yesorno" = n ]; then
	echo "Skipping Update..."
elif [ "$yesorno" = e ]; then
	echo "Goodbye!"
	exit 1
else
	echo "Not a valid answer. Exiting..."
	exit 1
fi

#Install NGINX

echo "Would you like to Install NGINX? (y/n/e)"

read -n1 yesorno
echo " "

if [ "$yesorno" = y ]; then
	yes | sudo yum install epel-release
	yes | sudo yum install nginx
	sudo systemctl start nginx
	sudo systemctl status nginx
	sudo systemctl enable nginx
	read -n1 -p "Is a firewall active?" firewall
		if [ "$firewall" = y ]; then
			sudo firewall-cmd --permanent --zone=public --add-service=http
			sudo firewall-cmd --permanent --zone=public --add-service=https
			sudo firewall-cmd --reload
			echo "Visit http://server_domain_name_or_IP"
elif [ "$yesorno" = n ]; then
	echo "Skipping NGINX Install..."
elif [ "$yesorno" = e ]; then
	echo "Goodbye!"
	exit 1
else
	echo "Not a valid answer. Exiting..."
	exit 1
fi

echo "Installer Complete!"
