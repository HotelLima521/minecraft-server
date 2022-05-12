#!/bin/sh

tmp = '/tmp/'
archive = 'hl521-minecraft-2022-05-10.tar.gz'
checksum = 'hl521-minecraft-2022-05-10.tar.gz.sha512sum'
minecraft = '~/.minecraft'
wget -c https://github.com/HotelLima521/minecraft-server/blob/main/$archive
wget -c https://github.com/HotelLima521/minecraft-server/blob/main/$archive
sha512sum -c $tmp/$checksum
notify-send "Placeholder for sha512sum verification"
mkdir minecraft
tar -xzf $tmp/hl521-minecraft-2022-05-10.tar.gz -C $tmp/minecraft
java -jar $tmp/forge-1.18.2-40.1.0-installer.jar
cp $tmp/mods/* $minecraft/mods/
rm -rv $tmp/minecraft
rm $tmp/$archive
rm $tmp/$checksum
