#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

Prepara(){
	echo -e "Atualizar Pacotes"
	sudo apt-get update
	echo -e "Atualizar Distro"
	sudo apt-get dist-upgrade
	echo -e "Instalar Pacotes Requeridos pelo OTServBR-Global"
	sudo apt-get install git cmake build-essential libluajit-5.1-dev ca-certificates curl zip unzip tar pkg-config
	echo -e "Finalizado"
}

vcpkg(){
	echo -e "Instalar Biblioteca C++ para Linux"
	echo -e "Inciando Clone do Github"
	git clone https://github.com/microsoft/vcpkg
	cd vcpkg
	./bootstrap-vcpkg.sh
	cd ..
	echo -e "Finalizado"
}

otserv(){
	echo -e "Instalar OTServBR"
	echo -e "Inciando Clone do Github"
	git clone --depth 1 https://github.com/opentibiabr/otservbr-global.git
	cd otservbr-global
	mkdir build && cd build
	echo -e "Finalizado"
}

compilevcpkg(){
    echo -e "Compilando Biblioteca C++ "
    cmake -DCMAKE_TOOLCHAIN_FILE=~/vcpkg/scripts/buildsystems/vcpkg.cmake ..
    make -j`nproc`
    echo -e "Finalizado"
    cd ~
    cd otservbr-global
    echo -e "Compilando OTServBR "
    cp -r build/bin/otbr .
    echo -e "Finalizado"
}

nginx(){
    echo -e "Instalando Nginx "
	sudo apt install nginx
    sudo service nginx start
    echo -e "Adicionando Regras no Firewall"
    sudo ufw app list
    echo -e "Finalizado"
}

mysql(){
    echo -e "Instalando MySQL "
	sudo apt install mysql-server
    sudo service mysql start
}

php(){
    echo -e "Instalando PHP "
    sudo apt install php php-curl php-fpm php-mysql php-xml php-zip
    sudo apt-get purge apache2*
    sudo apt-get autoremove
    cd /
    cd etc
    rm -r apache2
}

phpmyadmin(){
    echo -e "Instalando phpMyAdmin "
    sudo apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl
    sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
}

configmyamdin(){
    sudo apt install nano
    sudo nano /etc/nginx/sites-available/default
}

#echo -e "What you want to do ?(Default:1)"
echo "1) Começar a Instalação"  
# echo "2) Instalar Biblioteca C++ para Linux"
# echo "3) Instalar OTServBR"
# echo "4) Instalar OTServBR"

read -p "Selecione a operação que deseja realizar (Padrão: 1): " action; 

case $action in
	'1')
		Prepara
        vcpkg
        otserv
        compilevcpkg
        nginx
        mysql
        php
        phpmyadmin
        configmyamdin
		;;
esac
