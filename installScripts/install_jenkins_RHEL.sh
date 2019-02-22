#! /usr/bin/bash

yum -y install wget

yum -y install java-1.8.0-openjdk

wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo

rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

yum -y install jenkins

service jenkins start

chkconfig jenkins on

usermod -s /bin/bash jenkins

#service jenkins status
echo "Jenkins successfully installed"
echo "Status of Jenkins service is $(systemctl is-active jenkins)"
echo "Enabled Status of Jenkins service is $(systemctl is-enabled jenkins 2>/dev/null)"
echo "PLEASE SET THE PASSWORD FOR JENKINS USER BY TYPING : passwd jenkins"
