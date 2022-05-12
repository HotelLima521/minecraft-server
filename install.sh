#!/bin/sh
########################################################
tmp='/tmp'
archive='hl521-minecraft-2022-05-10.tar.gz'
checksum='hl521-minecraft-2022-05-10.tar.gz.sha512sum'
minecraft='~/.minecraft'
yellow='\e[0,33m';
boldyellow='\e[1;33m';
green='\e[0;92m';
boldgreen='\e[1;92m';
white='\e[0;37m';
cyan='\e[0;36m';
#boldorange='\e[1;31m';
#reset='\[0m';
########################################################
printf "${yellow}Checking for dependencies...\n"
sleep 1
printf "${cyan}Checking for Java...\n"
sleep 1
if type java
then
	printf "${cyan}Checking for Minecraft...\n"
	sleep 1
	if [ -d ~/.minecraft ]
	then
		printf "Checking for Forge...\n"
		sleep 1
		if [ -d ~/.minecraft/mods ] && [ -d ~/.minecraft/shaderpacks ] && [ -d ~/.minecraft/resourcepacks ]
		then
			printf "${green}Dependencies Check Good!\n${boldgreen}Installing the goods... :)${white}\n"
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
			printf "${boldyellow}Looks like Forge may not be installed...\n"
			sleep 1
			printf "${boldyellow}Would you like to install it?\n"
			printf "${cyan}## ${white}Y/n ${cyan}## ${white}-> "
			read INPUT
			case $INPUT in
				Y | y)
					java -jar $tmp/forge-1.18.2-40.1.0-installer.jar
					printf "${boldyellow}Re-run script now that forge is installed :)\n"
					sleep 5
				;;
				N | n)
					printf "${white}Okay, quitting.\n"
					sleep 2
				;;
				*)
					printf "${white}Not Understanding Input\n"
					sleep 2
				;;
			esac
		
		fi
	else
		printf "${boldyellow}Minecraft is not installed. Please install it to continue, then rerun the script. https://minecraft.net/${white}\n"
		sleep 2
	fi
else
	printf "${boldyellow}Java is not installed. Please rectify this issue. Suggest OpenJDK, install with your package manager.${white}\n"
	sleep 2
fi

