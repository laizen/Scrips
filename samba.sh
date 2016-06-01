#!/bin/bash
echo "PADRAO PI TESTE"
#Autor: Pedro Matias
#DATA: 13/02/2014

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
GRAY='\033[0;37m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

echo "Scrip para configuracao inicial do sistema." "`sleep 0.3`"
echo "Carregando informacoes ""`sleep 0.5`"
# echo -e ${RED}"[ OK ]"${NC}"`sleep 0.3`"
echo -e ${GREEN}"Update do Sistema"${NC}"`sleep 0.3`"
apt-get -q -y update
echo -e ${GREEN}"Upgrade do Sistema"${NC}"`sleep 0.3`"
apt-get -q -y upgrade
echo -e ${GREEN}"Instalando Splitvt"${NC}"`sleep 0.3`"
apt-get -q -y install splitvt
echo -e ${GREEN}"Instalando Htop"${NC}"`sleep 0.3`"
apt-get -q -y install htop
echo -e ${GREEN}"Instalando Manager NTFS"${NC}"`sleep 0.3`"
apt-get -q -y install ntfs-3g
echo -e ${GREEN}"Instalando SAMBA"${NC}"`sleep 0.3`"
apt-get -q -y install samba
cd /
echo -e ${RED}"Criando Configuração do SAMBA"${NC}"`sleep 0.3`"
cp /etc/samba/smb.conf /home/
rm /etc/samba/smb.conf
{
echo '[global]'
echo '		server string = %h server'
echo '		map to guest = Bad User'
echo '		obey pam restrictions = Yes'
echo '		pam password change = Yes'
echo '		passwd program = /usr/bin/passwd %u'
echo '		passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .'
echo '		unix password sync = Yes'
echo '		syslog = 0'
echo '		log file = /var/log/samba/log.%m'
echo '		max log size = 1000'
echo '		client signing = required'
echo '		dns proxy = No'
echo '		usershare allow guests = Yes'
echo '		panic action = /usr/share/samba/panic-action %d'
echo '		idmap config * : backend = tdb'
echo ''
echo '[Disk1]'
echo '		path = /media/usb0'
echo '		valid users = pedro'
echo '		read only = No'
echo '		create mask = 0775'
echo '		directory mask = 0775'
echo '[Disk2]'
echo '		path = /media/usb1'
echo '		valid users = pedro'
echo '		read only = No'
echo '		create mask = 0775'
echo '		directory mask = 0775'
echo '[Disk3]'
echo '		path = /media/usb2'
echo '		valid users = pedro'
echo '		read only = No'
echo '		create mask = 0775'
echo '		directory mask = 0775'
} >/etc/samba/smb.conf
echo -e ${RED}"Criando Usuário para o SAMBA"${NC}"`sleep 0.5`"
nome= "samba"
senha="123456"
useradd -M -D $nome -p $senha
(echo "$senha"; echo "$senha") | smbpasswd -s -a $nome
echo ${BLUE}"FIM"${NC}
