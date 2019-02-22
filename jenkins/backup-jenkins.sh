#!/bin/bash

if [[ -z "${JENKINS_HOME}" ]]; then
   JENKINS_HOME=/var/lib/jenkins
fi
echo "Jenkins HOME is $JENKINS_HOME"
cd $JENKINS_HOME
echo `pwd`
#Backup all important files to Jenkins_BKUP directory except excluded ones
mkdir -p Jenkins_BKUP
rsync -rv --exclude={plugins,Jenkins_BKUP,caches,.*,logs,fingerprints} . Jenkins_BKUP
#git config --global user.name "jenkins"
#git config --global user.email jenkins@mycompany.com
#git init
#Then do git clone to check out latest code
#change your git id below substitute myusername with your git id. It will prompt for
#password. Enter your git hub password
#git clone https://myusername@github.com/myrepo/jenkins-config.git
