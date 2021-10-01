#!/bin/bash
echo "configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
search jd.com
nameserver 192.168.100.2 #esclavo
nameserver 192.168.100.4 #maestro
nameserver 192.168.1.50  #firewall
TEST

echo "Instalando paquetes"
sudo yum install vim -y 
sudo yum install bind-utils bind-libs bind-* -y

echo "Creando usuario"
useradd aristi
passwd aristi:aristi
mkdir -p /var/sftp/jd
chown root:root /var/sftp/
chmod 755 /var/sftp/
chown aristi:aristi /var/sftp/jd/

echo "Copiando archivos"
cp /vagrant/esclavo/named.conf /etc/named.conf
cp /vagrant/esclavo/sshd_config /etc/ssh/sshd_config

service restart named
systemctl restart sshd


