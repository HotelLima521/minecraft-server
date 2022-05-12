$user = [System.Environment]::Username
$tmp = 'C:\Users\' + $user + '\AppData\Local\Temp'
$archive = 'hl521-minecraft-2022-05-11.zip'
$checksum = 'hl521-minecraft-2022-05-11.zip.sha512sum'
$minecraft = 'C:\Users\' + $user + '\AppData\.minecraft'
$url = 'https://archives.hl521.me/'
$zip = $url + 'zip/' + $archive
$sum = $url + 'checksums/' + $checksum
$archiveOut = $tmp + '\' + $archive
$checksumOut = $tmp + '\' + $checksum
$minecraftTmp = $tmp + '\minecraft\'
$modsSrc = $tmp + '\minecraft\mods\*'
$shaderpacksSrc = $tmp + '\minecraft\shaderpacks\*'
$resourcepacksSrc = $tmp + '\minecraft\resourcepacks\*'
$modsDest = $minecraft + '\mods\'
$shaderpacksDest = $minecraft + '\shaderpacks\'
$resourcePacksDest = $minecraft + '\resourcepacks\'
$winget = 'https://github.com/microsoft/winget-cli/archive/refs/tags/v1.2.10271.zip'
$wingetOut = $tmp + '\winget.zip'
$wingetTmp = $tmp + '\winget\'
$forge = 'forge-1.18.2-40.1.0-installer.jar'

Write-Host "Checking for dependencies..."
if(Get-Command java){
	if(test-path $minecraft){
		if(test-path $modsDest -and test-path $shaderpacksDest -and test-path $resourcepacksDest){
			Invoke-Webrequest $winget -Outfile $wingetOut
			Invoke-Webrequest $zip -OutFile $archiveOut
			Invoke-Webrequest $sum -OutFile $checksumOut
			certutil -hashfile $checksumOut sha512
			Write-Host "Placeholder for sha512sum verification"
			mkdir $minecraftTmp
			Expand-Archive -LiteralPath $wingetOut -DestinationPath $wingetTmp
			Expand-Archive -LiteralPath $archiveOut -DestinationPath $minecraftTmp
			cd $minecraftTmp
			#param($INPUT=$(throw "Would you like to install Forge? (Only do this if it needs to be updated, or isn't installed`n## Y/n ## -> "))
			#Switch($INPUT){
			#	'y' {
			#		
			#		Start-Job -ScriptBlock {
			#			check 	& java -jar forge-1.18.2-40.1.0-installer.jar
			#		}
			#	}
			#	'n' {
			#		$(throw "Okay, continuing")
			#	}
			#	default{
			#		$(throw "Not understanding Input")
			#	}
			#}
			cp $modsSrc $modsDest
			cp $shaderpacksSrc $shaderpacksDest
			cp $resourcepacksSrc $resourcepacksDest
			rm -r -fo $minecraftTmp
			rm $archiveOut
			rm $checksumOut
		}
	}
	else{
		Write-Host "Minecraft is not installed. Please install to continue, then rerun the script. https://minecraft.net/"
	}
}
else{
	Write-Host "Java Not installed. Please recitify this issue. Suggest Openjdk: https://docs.microsoft.com/en-us/java/openjdk/download/"
}
