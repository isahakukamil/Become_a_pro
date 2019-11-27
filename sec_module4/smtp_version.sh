#!/bin/bash

#---MOP WORK PACKAGE TAG: WP041V3---
#---DESC:
#THIS SCRIPT WILL PREVENT SMTP AND WEB SERVER
#VERSION DISCLOSURE---

#---SCRIPT BY REUBEN A. BOAKYE
#SIGNUM: EBOAREU---



#---Backup of file created with timestamp if file exists,
#and config file "sendmail.cf" is edited afterwards---

file=/etc/mail/sendmail.cf

if test -f "$file"; then
	timeStamp=$(date '+%m_%y_%H_%M_%S')
	fExtension=".cf"
	fExtension1=".log"
	backFile=/etc/mail/$timeStamp$fExtension
	logFile=/var/log/$timeStamp$fExtension1

	cp /etc/mail/sendmail.cf /etc/mail/$backFile
	
	sed -i '/.*SmtpGreetingMessage.*/c\SmtpGreetingMessage=$j' $file
	
	STATUS=`echo "$?"`
	if test -f "$logFile"; then
		if [ $STATUS -eq 0 ]; then
			echo "$USER $timeStamp Exit Status: Successfully Executed" >>$logFile
		else
			echo "$USER $timeStamp Exit Status: Failed to Execute." >>$logFile
			mv $backupfile $file
		fi
	else
		sudo touch $logFile
		if [ $STATUS -eq 0 ]; then
			echo "$USER $timeStamp Exit Status:Successfully Executed" >>$logFile
		else
			echo "$USER $timeStamp Exit Status:Failed to Execute." >>$logFile
			mv $backupfile $file
		fi
else 
	echo "***THE CONFIGURATION FILE DOES NOT EXIST!***"
fi
	
