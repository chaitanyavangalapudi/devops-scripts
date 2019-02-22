#! /usr/bin/bash
#https://docs.docker.com/install/linux/docker-ce/centos/
#docker-CE is not supported for RHEL

yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum-config-manager --enable docker-ce-edge

yum-config-manager --enable docker-ce-testing

yum makecache fast

#yum list docker-ce --showduplicates | sort -r
#yum install -y docker-ce

yum install -y --setopt=obsoletes=0 docker-ce-18.03.1.ce-1.el7.centos docker-ce-selinux-18.03.1.ce-1.el7.centos

systemctl start docker
systemctl enable docker 

sudo usermod -aG docker jenkins

curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)"  > /usr/bin/docker-compose

chmod +x /usr/bin/docker-compose

#systemctl status docker

echo "Successfully installed docker."
echo "Status of Docker service is $(systemctl is-active docker)"
echo "Enabled Status of Docker service is $(systemctl is-enabled docker)"
