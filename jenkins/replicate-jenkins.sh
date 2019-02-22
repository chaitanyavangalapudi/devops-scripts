#! /bin/bash
if [[ -z "${JENKINS_HOME}" ]]; then
   JENKINS_HOME=/var/lib/jenkins
fi
echo "Jenkins HOME is $JENKINS_HOME"
cp -r *.xml init.groovy.d jenkins.properties $JENKINS_HOME
cp secrets/* $JENKINS_HOME/secrets/

for d in users/* ;
do 
   cp -r "$d" "$JENKINS_HOME/$d";
done

#Create directory for any job which doesn't exist already
for d in jobs/* ;
do
  directory=$JENKINS_HOME/$d
  echo $directory
  if [ ! -d "$directory" ]; then mkdir -p "$directory" ; fi
done

#Create config.xml for each job so that we don't disturb other existing directories for each job
for d in jobs/*/config.xml ;
do
  configfile=$d
  echo $configfile
  cp  "$d" "$JENKINS_HOME/$d";
done
