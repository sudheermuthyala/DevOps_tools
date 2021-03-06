#!/bin/bash
# Installing sonar-scanner

cd /opt
curl -O https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip
unzip -o sonar-scanner-cli-4.6.2.2472-linux.zip
rm -rf sonar
mv sonar-scanner-cli-4.6.2.2472-linux sonar

ln -s /opt/sonar/bin/sonar-scanner  /bin/sonar-scanner

curl -s https://raw.githubusercontent.com/sudheermuthyala/DevOps_tools/main/sonar-scanner/sonar-quality-gate.sh >/bin/sonar-quality-gate.sh
chmod +x /bin/sonar-quality-gate.sh
