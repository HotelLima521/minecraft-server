$user = [System.Environment]::Username
$tmp = 'C:\Users\' + $user + '\AppData\Local\Temp'
$archive = 'hl521-minecraft-2022-05-11.zip'
$checksum = 'hl521-minecraft-2022-05-11.zip.sha512sum'
$minecraft = 'C:\Users\' + $user + '\AppData\Roaming\.minecraft'
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
$forge = 'forge-1.18.2-40.1.0-installer.jar'

Write-Host "Checking for dependencies..."
if(Get-Command java){
	if(test-path $minecraft){
		if((test-path $modsDest) -and (test-path $shaderpacksDest) -and (test-path $resourcepacksDest)){
			Invoke-Webrequest $zip -OutFile $archiveOut
			Invoke-Webrequest $sum -OutFile $checksumOut
			certutil -hashfile $checksumOut sha512
			Write-Host "Placeholder for sha512sum verification"
			mkdir $minecraftTmp
			Expand-Archive -LiteralPath $archiveOut -DestinationPath $minecraftTmp
			cd $minecraftTmp
			cp $modsSrc $modsDest
			cp $shaderpacksSrc $shaderpacksDest
			cp $resourcepacksSrc $resourcepacksDest
			rm -r -fo $minecraftTmp
			rm $archiveOut
			rm $checksumOut
		}
		else{
			Write-Warning -Message "Looks like Forge may not be installed..."
			sleep 1
			Write-Host "Would you like to install it?" -ForegroundColor Magenta
			sleep 1
			$userIn = Read-Host "## Y/n ##`n -> "
			if(($userIn -eq 'y') -or ($userIn -eq 'Y')){
				java -jar $forge
				Write-Host "Re-Run script now that forge is installed :)"
				sleep 5
			}
			else if(($userIn -eq 'n') -or ($userIn -eq 'N')){
					Write-Host "Okay, quitting." -ForegroundColor White
					sleep 2
			}
			else{
					Write-Error -message "Not understanding Input"
					sleep 2
			}
		}
	}
	else{
		Write-Error -Message "Minecraft is not installed. Please install to continue, then rerun the script. https://minecraft.net/"
	}
}
else{
	Write-Error -Message "Java Not installed. Please recitify this issue. Suggest Openjdk: https://docs.microsoft.com/en-us/java/openjdk/download/"
}
