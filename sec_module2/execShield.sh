#!/bin/bash

#---MOP WORK PACKAGE TAG: WP025V3---
#---DESC:
#---ENABLE EXECSHIELD BUFFER OVERFLOW PROTECTION---

#---SCRIPT BY REUBEN A. BOAKYE---
#---SIGNUM: EBOAREU---

#---All scripts run are logged into a single log file called "script.log"
#with file path /var/log/script.log---

execShield () {
	file=/etc/sysctl.conf

	if test -f "$file"; then
		timeStamp=$(date '+%m_%y_%H_%M_%S')
		fExtension=".conf"
		fExtension1=".log"
		backupFile=/etc/sysctl_$timeStamp$fExtension
		logName="script"
		logFile=/var/log/$logName$fExtension1

	#This creates a backup of the configuration file.
		sudo cp $file $backupFile

		sed -i "s/.*kernel.exec-shield.*/kernel.exec-shield = 1/g" $file

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
	#Reload settings from all configuration files	
		sudo sysctl --system
	else 
		echo "***THE CONFIGURATION FILE DOES NOT EXIST!***"
	fi
}

execShield
