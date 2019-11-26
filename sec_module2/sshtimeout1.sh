#!/bin/bash

#---MOP WORK PACKAGE TAG: WP021BISV3---
#---DESC:
#---CONFIGURING SSH SESSION TIMEOUT---

#---SCRIPT BY REUBEN A. BOAKYE
#SIGNUM: EBOAREU---

#---MAIN CONFIG COMMAND OBTAINED FROM NODE HARDENING CPI---

#---All scripts run are logged into a single log file called "script.log"
#with file path /var/log/script.log---

file=/etc/ssh/sshd_config

if test -f "$file"; then
	timeStamp=$(date '+%m_%y_%H_%M_%S')
	fExtension1=".log"
	backupFile=/etc/ssh/ssh_config_$timeStamp
	logName="script"
	logFile=/var/log/$logName$fExtension1

#This creates a backup of the configuration file.
	sudo cp $file $backupFile
	
	echo "Please enter the desired timeout parameters to effect changes"
	echo "ClientAliveInterval:"
	read interval
	echo "ClientAliveCountMax:"
	read count

	sudo sed -i 's/.*ClientAliveInterval.*/ClientAliveInterval $interval/g' $file
	sudo sed -i 's/.*ClientAliveCountMax.*/#ClientAliveCountMax $count/g' $file

	STATUS= echo "$?"
	
#This tests if logfile is already created.
	if test -f "$logFile"; then 
		if [ "$STATUS" -eq 0 ]; then
			echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
		else
			echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
			sudo mv $backupfile $file
		fi
	else
		sudo touch $logFile
		if [ "$STATUS" -eq 0 ]; then
			echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
		else
			echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
			sudo mv $backupfile $file
		fi
	fi
else 
	echo "***THE CONFIGURATION FILE DOES NOT EXIST!***"
fi

