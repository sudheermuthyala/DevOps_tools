#!/bin/bash
#varibles

R="\e[31m"
G="\e[32m"
N="\e[0m"
P="\e[35m"
LID=$(id -u)
LOG=/tmp/mvn.log
Mvn_Ver=$(curl -s  https://maven.apache.org/download.cgi | grep "Downloading"| awk '{print $5}' | awk -F '<' '{print $1}')

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
Os_checking
PrintHead "Installing Java"
yum install java-1.8.0-openjdk-devel unzip  -y &>>$LOG
Stat $? "Installing java is ::"

PrintHead "Downloading latest maven-${Mvn_Ver}"
cd /opt/
curl -s https://downloads.apache.org/maven/maven-3/${Mvn_Ver}/binaries/apache-maven-${Mvn_Ver}-bin.zip -o /tmp/apache-maven-${Mvn_Ver}-bin.zip
Stat $? "Downloading maven-${Mvn_Ver}"

PrintHead "Moving mvn command to /bin/mvn"
unzip -o /tmp/apache-maven-${Mvn_Ver}-bin.zip &>>$LOG
mv apache-maven-${Mvn_Ver} maven   &>>$LOG 
ln -s /opt/maven/bin/mvn  /bin/mvn &>>$LOG
Stat $? "mvn command is added to /bin is ::"

PrintHead 'check with "mvn" command'






