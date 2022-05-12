$user = [System.Environment]::Username
$tmp = 'C:\Users\' + $user + '\AppData\Local\Temp'
$archive = 'hl521-minecraft-2022-05-10.zip'
$checksum = 'hl521-minecraft-2022-05-10.zip.sha512sum'
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

Invoke-Webrequest $zip -OutFile $archiveOut
Invoke-Webrequest $sum -OutFile $checksumOut
certutil -hashfile $checksumOut sha512
Write-Host "Placeholder for sha512sum verification"
mkdir $minecraftTmp
Expand-Archive -LiteralPath $archiveOut -DestinationPath $minecraft
param($INPUT=$(throw "Would you like to install Forge? (Only do this if it needs to be updated, or isn't installed`n## Y/n ## -> "))
Switch($INPUT){
	'y' {
		
		Start-Job -ScriptBlock {
  			& java -jar forge-1.18.2-40.1.0-installer.jar
		}
	}
	'n' {
		$(throw "Okay, continuing")
	}
	default{
		$(throw "Not understanding Input")
	}
}
cp $modsSrc $modsDest
cp $shaderpacksSrc $shaderpacksDest
cp $resourcepacksSrc $resourcepacksDest
rm -rv $minecraftTmp
rm $archiveOut
rm $checksumOut
