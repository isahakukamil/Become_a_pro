#!/bin/bash

#---MOP WORK PACKAGE TAG: WP021BISV3---
#---DESC:
#---CONFIGURING SSH SESSION TIMEOUT---

#---MAIN CONFIG COMMAND OBTAINED FROM NODE HARDENING CPI---

#---All scripts run are logged into a single log file called "script.log"
#with file path /var/log/script.log---


sshtimeout () {
  echo "Please enter your ID and address of primary IO to be logged onto the primary IO as tspSecAdmin user:"

  echo "ID:"
  read value

  echo "Address:"
  read address

  sudo ssh $value@$address

  echo "NOTE: PLEASE ACT ACCORDING TO THE PRINTOUT OF THE SCRIPT TO ACTUALIZE THE SETTING"
  echo "Please provide the desired timeout threshold in seconds:"
  read time

  sudo set_session_timeout.sh -t \ $time


  echo "Please enter your ID and address of secondary IO to be logged onto the primary IO as tspSecAdmin user:"

  echo "ID:"
  read value

  echo "Address:"
  read address

  sudo ssh $value@$address

  echo "NOTE: PLEASE ACT ACCORDING TO THE PRINTOUT OF THE SCRIPT TO ACTUALIZE THE SETTING"
  echo "Please provide the desired timeout threshold in seconds:"
  read time

  sudo set_session_timeout.sh -t \ $time
}

sshtimeout




