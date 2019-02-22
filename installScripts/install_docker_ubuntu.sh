#! /bin/bash
#https://docs.docker.com/install/linux/docker-ce/ubuntu/

sudo apt install -y curl
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-cache policy docker-ce
sudo apt-get install -y docker-ce
systemctl status docker
sudo usermod -aG docker jenkins

sudo curl -o /usr/bin/docker-compose -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" 
sudo chmod +x /usr/bin/docker-compose

echo "Successfully installed Docker."
echo "Status of Docker service is $(systemctl is-active docker)"
echo "Enabled Status of Docker service is $(systemctl is-enabled docker)"
