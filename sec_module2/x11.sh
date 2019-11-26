#!/bin/bash

#---MOP WORK PACKAGE TAG: WP022BISV3---
#---DESC:
#---SETTING X11 PROTOCOL FORWARDING---

#---SCRIPT BY REUBEN A. BOAKYE
#SIGNUM: EBOAREU---

#---All scripts run are logged into a single log file called "script.log"
#with file path /var/log/script.log---

file=/etc/ssh/sshd_config

if test -f "$file"; then
	timeStamp=$(date '+%m_%y_%H_%M_%S')
	fExtension1=".log"
	backupFile=/etc/ssh/sshd_x11_$timeStamp
	logName="script"
	logFile=/var/log/$logName$fExtension1

#This creates a backup of the configuration file.
	sudo cp $file $backupFile

	sed -i "s/.*x11Forwarding.*/x11Forwarding yes/g" $file

	STATUS= echo "$?"
	
#This tests if logfile is already created.
	if test -f "$logFile"; then 
		if [ "$STATUS" -eq 0 ]; then
			sudo echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
		else
			sudo echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
			sudo mv $backupfile $file
		fi
	else
		sudo touch $logFile
		if [ "$STATUS" -eq 0 ]; then
			sudo echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
		else
			sudo echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
			sudo mv $backupfile $file
		fi
	fi
	
	sudo service sshd restart
else 
	echo "***THE CONFIGURATION FILE DOES NOT EXIST!***"
fi

