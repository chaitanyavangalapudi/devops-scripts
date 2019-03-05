#! /bin/bash

echo "Note: Run the script ./install_nexus_ubuntu.sh as root by running 'sudo su -' with password as input\n\n\n"

#install below utilities before proceed further
#sudo vim wget net-tools java-1.8.0-openjdk.x86_64

cd /opt
sudo wget http://download.sonatype.com/nexus/3/latest-unix.tar.gz
#sudo wget https://sonatype-download.global.ssl.fastly.net/nexus/3/nexus-3.15.2-01-unix.tar.gz
sudo tar -xvf latest-unix.tar.gz
ln -s /opt/nexus-3.15.2-01 /opt/nexus
sudo useradd -m -s /bin/bash nexus
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work
sudo chmod a+x /opt/nexus/bin/nexus

export NEXUS_HOME="/opt/nexus"
export PATH=$PATH:$NEXUS_HOME/bin

sed -i -e s/^run_as_user=.*/run_as_user=\'nexus\'/  /opt/nexus/bin/nexus
cp /opt/nexus/etc/nexus-default.properties /opt/nexus/etc/nexus.properties
sed -i -e s/^nexus-context-path=.*/nexus-context-path=\\/nexus/  /opt/nexus/etc/nexus.properties
sed -i -"s/#PIDDIR="."/PIDDIR="/var/run"/"; /opt/nexus/bin/nexus

#Edit /opt/nexus/bin/nexus.vmoptions based on your VM requirements
#-Xms1200M
#-Xmx1200M
#-XX:MaxDirectMemorySize=2G

mkdir /home/nexus/main-repo
#Set owner user and group
chown -R nexus:nexus /home/nexus/main-repo
sed -i -e s/^nexus-work=.*/nexus-work=\\/home\\/nexus\\/main-repo/  /opt/nexus/conf/nexus.properties


sudo tee -a /etc/systemd/system/nexus.service << END
[Unit]

Description=Nexus service

After=network.target


[Service]

Type=forking

ExecStart=/opt/nexus/bin/nexus start

ExecStop=/opt/nexus/bin/nexus stop

User=nexus

Restart=on-abort


[Install]

WantedBy=multi-user.target

END

sudo systemctl daemon-reload

sudo systemctl enable nexus.service

sudo systemctl start nexus.service

firewall-cmd --zone=public --permanent --add-port=8081/tcp
firewall-cmd --reload

echo "\n\n\nNOTE: Change password for nexus user by running 'passwd nexus'\n"
echo "Access nexus at below URL : http://localhost:8081/nexus"
echo "Netstat of Nexus is \n\n"
netstat -ntulp | grep 8081
echo "\n\nStatus of Nexus Process is :\n\n\n"

systemctl status nexus.service
