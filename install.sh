#!/bin/sh

tmp='/tmp'
archive='hl521-minecraft-2022-05-11.tar.gz'
checksum='hl521-minecraft-2022-05-11.tar.gz.sha512sum'
minecraft='~/.minecraft'
Yel='\e[0,33m';
BYel='\e[1;33m';
Whi='\e[0;37m';
Cya='\e[0;36m';
printf "${Yel}Checking for dependencies..."
sleep 1
printf "${Cya}Checking for Java..."
sleep 1
if [java] then
	printf "${Cya}Checking for Minecraft..."
	sleep 1
	if [ -d ~/.minecraft ] then
		printf "${Cya}Checking for Forge..."
		sleep 1
		if [ -d ~/.minecraft/mods ] && [ -d ~/.minecraft/shaderpacks ] && [ -d ~/.minecraft/resourcepacks ] then
			printf "Dependencies Check Good!\nInstalling the goods... :)"
			wget -c https://archives.hl521.me/tarball/$archive https://archives.hl521.me/checksums/$checksum
			sha512sum -c $tmp/$checksum
			mkdir minecraft
			tar -xzf $tmp/$archive -C $tmp/minecraft
			cp $tmp/minecraft/mods/* $minecraft/mods/
			cp $tmp/minecraft/shaderpacks/* $minecraft/shaderpacks/
			cp $tmp/minecraft/resourcepacks/* $minecraft/resourcepacks/
			rm -rv $tmp/minecraft
			rm $tmp/$archive
			rm $tmp/$checksum
		else
			printf "${BYel}Looks like Forge may not be installed..."
			sleep 1
			printf "${BYel}Would you like to install it?"
			printf "${Cya}## ${Whi}Y/n ${Cya}## ${Whi}-> "
			read INPUT
			case $INPUT in
				Y | y)
					java -jar $tmp/forge-1.18.2-40.1.0-installer.jar
					printf "Re-run script now that forge is installed :)"
					sleep 5
				;;
				N | n)
					printf "Okay, quitting."
					sleep 2
				;;
				*)
					printf "Not Understanding Input"
					sleep 2
				;;
			esac
		
		fi
	else
		printf "Minecraft is not installed. Please install it to continue, then rerun the script. https://minecraft.net/"
		sleep 2
	fi
else
	printf "Java is not installed. Please rectify this issue. Suggest OpenJDK, install with your package manager."
	sleep 2
fi

