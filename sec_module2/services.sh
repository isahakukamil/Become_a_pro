#!/bin/bash

#---MOP WORK PACKAGE TAG: WP021V3---
#---DESC:
#---THIS SCRIPT WILL DISABLE UNSECURED SERVICES---
#---SCRIPT BY REUBEN A. BOAKYE---
#---SIGNUM: EBOAREU---

#---MAIN CONFIG COMMAND OBTAINED FROM NODE HARDENING CPI---

#---All scripts run are logged into a single log file called "scripts.log"
#with file path /var/log/script.log---

services () {
	timeStamp=$(date '+%m_%y_%H_%M_%S')
	logName="script"
	fExtension=".log"
	logFile=/var/log/$logName$fExtension

	sudo chkconfig --list
	echo "Please provide the name of the service you wish to turn off, from among the list displayed above:"
	read source
	sudo chkconfig $source off
	STATUS=`echo "$?"`
	if test -f "$logFile"; then 
		if [ $STATUS -eq 0 ]; then
			sudo echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
		else 			
			sudo echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
		fi
	else
		sudo touch $logFile
		if [ $STATUS -eq 0 ]; then
			sudo echo "$USER $timeStamp Exit_Status: Successfully Executed" >> $logFile
		else
			sudo echo "$USER $timeStamp Exit_Status: Failed to Execute." >> $logFile
		fi
	fi
}

services
