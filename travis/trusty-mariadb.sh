#!/bin/bash

VER=$1

case "$VER" in
	'5.5' | '10.1' | '10.2')
		;;
	*)
		echo "Unsupport version \"$VER\"" > /dev/stdout
		exit 1
esac

apt-get -y install software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
add-apt-repository 'deb [arch=amd64,i386] http://sfo1.mirrors.digitalocean.com/mariadb/repo/${VER}/ubuntu trusty main'
apt-get -y update
apt-get install -y mariadb-server

exit 0
