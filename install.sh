#!/bin/sh

tmp='/tmp'
archive='hl521-minecraft-2022-05-11.tar.gz'
checksum='hl521-minecraft-2022-05-11.tar.gz.sha512sum'
minecraft='~/.minecraft'
BYel='\e[1;33m';
Whi='\e[0;37m';
Cya='\e[0;36m';
wget -c https://archives.hl521.me/tarball/$archive https://archives.hl521.me/checksums/$checksum
sha512sum -c $tmp/$checksum
notify-send "Placeholder for sha512sum verification"
mkdir minecraft
tar -xzf $tmp/$archive -C $tmp/minecraft
printf "Would you like to install the Forge Client? ${BYel}(Only do this if it needs to be updated, or you don't currently have it)\n${Cya}## ${Whi}Y/n ${Cya}## ${Whi}-> "
read INPUT
case $INPUT in
	Y | y)
		java -jar $tmp/forge-1.18.2-40.1.0-installer.jar
		;;
	N | n)
		echo -n "Okay, continuing with install..."
		sleep 1
		;;
	*)
		echo -n "Not Understanding Input"
		;;
esac
cp $tmp/mods/* $minecraft/mods/
rm -rv $tmp/minecraft
rm $tmp/$archive
rm $tmp/$checksum
