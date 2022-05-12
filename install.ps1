$work = @{
	tmp = '%AppData\Local\Temp'
	archive = 'hl521-minecraft-2022-05-11.zip'
	checksum = 'hl521-minecraft-2022-05-11.zip.sha512sum'
	minecraft = '%AppData\.minecraft'
}
powershell -command "& { iwr https://archives.hl521.me/zip/$work.archive -OutFile $work.archive }"
powershell -command "& { iwr https://archives.hl521.me/checksum/$work.checksum -OutFile $work.checksum }"
sha512 -c $work.tmp\$work.checksum
Write-Host "Placeholder for sha512sum verification"
mkdir $work.tmp\minecraft
Expand-Archive -LiteralPath '$work.tmp\$work.archive' -DestinationPath '$work.minecraft'
param($INPUT=$(throw "Would you like to install Forge? (Only do this if it needs to be updated, or isn't installed`n## Y/n ## -> "))
Switch(INPUT){
	y{
		java -jar forge-1.18.2-40.1.0-installer.jar
	}
	n{
		$(throw "Okay, continuing")
	}
	default{
		$(throw "Not understanding Input")
	}
}
cp $work.tmp\minecraft\mods\* $work.minecraft\mods\
cp $work.tmp\minecraft\shaderpacks\* $work.minecraft\shaderpacks\
cp $work.tmp\minecraft\resourcepacks\* $work.minecraft\resourcepacks\
rm -rv $tmp\minecraft
rm $work.tmp\$work.archive
rm $work.tmp\$work.checksum
