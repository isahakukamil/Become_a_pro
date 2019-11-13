#!/bin/bash

#---MOP WORK PACKAGE TAG: WP041V3---
#---DESC:
#THIS SCRIPT WILL PREVENT SMTP INFORMATION DISCLOSURE---

#---SCRIPT BY REUBEN A. BOAKYE---



#---Backup of file created with timestamp if file exists
#and file sendmail.cf is edited afterwards---

file=/etc/mail/sendmail.cf

if test -f "$file"; then
	timestamp=$(date '+%m_%y_%H_%M_%S')
	fextension=".cf"
	cp /etc/mail/sendmail.cf /etc/mail/$timestamp$fextension
	
	sed -i '/.*O PrivacyOptions.*/c\O PrivacyOptions=goaway,restrictmailq,restrictqrun,noreceipts,restrictexpand,noetrn,nobodyreturn' /etc/mail/sendmail.cf

fi
	
