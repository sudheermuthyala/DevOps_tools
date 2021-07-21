#!/bin/bash

# Installing Sonaqube

R="\e[31m"
G="\e[32m"
N="\e[0m"
P="\e[35m"
LID=$(id -u)
LOG=/tmp/sonarqube.log

Sonar_Ver=$(curl -s https://binaries.sonarsource.com/Distribution/sonarqube/ | grep '.zip<' | tail -1 | sed -e 's/>/ /g' |xargs -n 1| grep ^sonarqub| awk -F '-' '{print$2}'| awk -F'.zip</a' '{print $1}')
SDURL="curl -s https://binaries.sonarsource.com/Distribution/sonarqube-${Sonar_Ver}.zip"
SFILENAME=$(echo ${SDURL} | awk -F / '{print $NF}')
SDIRNAME=$(echo ${SFILENAME} |sed -e 's/.zip/ /')

if [ $LID -ne 0 ] ;then
    echo -e "${R}You need to be root to perform this command.${N}"
    exit 1
fi
Os_checking() {
  ELV=$(rpm -q basesystem | sed -e 's/\./ /g' | xargs -n 1 | grep ^el)
  B_system=$(rpm -q basesystem)
  if [ $ELV != "el7" ]; then
      echo -e "\e[31merror ✗.. \e[0m OS Version not supported"
      PrintHead "${B_system} so this Script is capable for CentOs systems"
      Stat $? 
    else
      PrintHead "${B_system} so this Script is capable for CentOs systems"
      PrintHead "This script will Install mvn"
  fi
}

PrintHead() {
  echo "----------------------------"
  echo -e "\e[35m➜ INFO:: $1 \e[0m\n"
  
}

Stat(){
    if [ $1 -ne 0 ] ;then 
        echo -e "${R}✗${N}  $2 ${R}UNSUCCESSFUL${N}"
        echo -e "${R}✗${N}  Check ${R}$LOG${N}"
        exit
    else
        echo -e "${G}✓${N}  $2 ${G}SUCCESS${N}"
        echo "----------------------------"
    fi
}
# main progream


PrintHead "Installing epel-release "
yum install epel-release -y &>>${LOG}
Stat $? "Installing EPEL Packages ::"

PrintHead "Installing Java-11-Openjdk & Os-Utilities"
yum install java-11-openjdk unzip -y &>>${LOG}
Stat $? "Installing Java and Os-Utilities ::"

PrintHead "Creating "sonar" user"
id -u sonar 