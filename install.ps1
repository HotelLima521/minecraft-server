$work = @{
	tmp = '%AppData\Local\Temp'
	archive = 'hl521-minecraft-2022-05-10.zip'
	checksum = 'hl521-minecraft-2022-05-10.zip.sha512sum'
	minecraft = '%AppData\.minecraft'
}
powershell -command "& { iwr https://github.com/HotelLima521/minecraft-server/blob/main/$work.archive -OutFile $work.archive }"
powershell -command "& { iwr https://github.com/HotelLima521/minecraft-server/blob/main/$work.checksum -OutFile $work.checksum }"
sha512 -c $work.tmp\$work.checksum
Write-Host "Placeholder for sha512sum verification"
mkdir minecraft
Expand-Archive -LiteralPath '$tmp\hl521-minecraft-2022-05-10.zip' -DestinationPath '$tmp\minecraft'
java -jar forge-1.18.2-40.1.0-installer.jar
cp $work.tmp\mods\* $work.minecraft\mods\
rm -rv $tmp\minecraft
rm $work.tmp\$work.archive
rm $work.tmp\$work.checksum
