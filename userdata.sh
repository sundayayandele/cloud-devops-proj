#! /bin/bash
sudo su -
hostname jenkinssrv
yum install java-1.8* -y 
echo "JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.292.b10-0.e18_3.x86_64 
PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME" >> ~/.bash_profile
yum -y install wget git 
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum -y install jenkins
systemctl start jenkins
systemctl enable jenkins
chkconfig jenkins on
yum module remove container-tools -y
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo -y
sed -i s/7/8/g /etc/yum.repos.d/docker-ce.repo -y 
yum install docker-ce -y
systemctl enable docker


