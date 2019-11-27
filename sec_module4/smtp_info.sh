#!/bin/bash

#---MOP WORK PACKAGE TAG: WP041V3---
#---DESC:
#THIS SCRIPT WILL PREVENT SMTP INFORMATION DISCLOSURE---

#---SCRIPT BY REUBEN A. BOAKYE
#SIGNUM: EBOAREU---



#---Backup of file created with timestamp if file exists
#and config file 'sendmail.cf' is edited afterwards---

file=/etc/mail/sendmail.cf

if test -f "$file"; then
	timestamp=$(date '+%m_%y_%H_%M_%S')
	fextension=".cf"
	fextension1=".log"
	backupfile=$timestamp$fextension
	logfile=$timestamp$fextension1
	
	cp /etc/mail/sendmail.cf /etc/mail/$backupfile
	
	sed -i '/.*O PrivacyOptions.*/c\O PrivacyOptions=goaway,restrictmailq,restrictqrun,noreceipts,restrictexpand,noetrn,nobodyreturn' $file

	STATUS=`echo "$?"`
	if [ $STATUS -eq 0 ]; then
		echo "Successfully Executed" >> /var/log/$logfile
	else
		echo "Failed to Execute." >> /var/log/$logfile
		mv /etc/mail/$backupfile $file
	fi
else 
	echo "***THE CONFIGURATION FILE DOES NOT EXIST!***"
fi


