#!/bin/bash

#---MOP WORK PACKAGE TAG: WP053V3---
#---DESC:
#THIS SCRIPT PROVIDES SCREENSHOT FOR SECURITY CONTROL VALIDATION---

#---SCRIPT BY REUBEN A BOAKYE
#SIGNUM: EBOAREU---
   

#---CHECK IF GNOME-SCREENSHOT PACKAGE IS INSTALLED---
#---THIS IS THE PACKAGE NEEDED FOR THE SCREENSHOT TO BE TAKEN---

sc_validation2 () {
	filename="gnome-screenshot" 
	if rpm -qa | grep -i $filename
	then
		echo "`tput bold`Package is already installed"
	else 
		echo "`tput bold`Package not installed. Proceeding to install..."	
		sudo yum -y install $filename
	fi  

	#---/ETC/ FILES---

	nano /etc/passwd

	name=$(date '+%m_%y_%H_%M_%S')
	imgExtension=".png"
	imgName=$name$imgExtension
	#imgDirectory="/Pictures/"
	#imgSavePath=$imgDirectory$imgName
	gnome-screenshot -w --file="$imgName"

	nano /etc/shadow

	name=$(date '+%m_%y_%H_%M_%S')
	imgExtension=".png"
	imgName=$name$imgExtension
	#imgDirectory="/Pictures/"
	#imgSavePath=$imgDirectory$imgName
	gnome-screenshot -w --file="$imgName"
}

sc_validation2

