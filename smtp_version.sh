#!/bin/bash

#---MOP WORK PACKAGE TAG: WP041V3---
#---DESC:
#THIS SCRIPT WILL PREVENT SMTP AND WEB SERVER
#VERSION DISCLOSURE---

#---SCRIPT BY REUBEN A. BOAKYE---



#---Backup of file created with timestamp if file exists,
#and file "sendmail.cf" is edited afterwards---

file=/etc/mail/sendmail.cf

if test -f "$file"; then
	timestamp=$(date '+%m_%y_%H_%M_%S')
	fextension=".cf"
	cp /etc/mail/sendmail.cf /etc/mail/$timestamp$fextension
	
	sed -i '/.*SmtpGreetingMessage.*/c\SmtpGreetingMessage=$j' /etc/mail/sendmail.cf

fi
	
