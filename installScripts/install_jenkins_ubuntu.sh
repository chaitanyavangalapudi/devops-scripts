#! /bin/bash

wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb http://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list

sudo apt-get update
sudo apt-get install -y jenkins
sudo systemctl start jenkins
sudo usermod -s /bin/bash jenkins
systemctl status jenkins

echo "Successfully executed the script"
echo "Status of Jenkins service is $(systemctl is-active jenkins)"
echo "Enabled Status of Jenkins service is $(systemctl is-enabled jenkins 2>/dev/null)"
echo "PLEASE SET THE PASSWORD FOR JENKINS USER BY TYPING : passwd jenkins"
