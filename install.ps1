$user = $env:username
$tmp = 'C:\Users\' + $user + '\AppData\Local\Temp'
$archive = 'hl521-minecraft-2022-05-11.zip'
$checksum = 'hl521-minecraft-2022-05-11.zip.sha512sum'
$minecraft = 'C:\Users\' + $user + '\AppData\.minecraft'
$url = 'https://archives.hl521.me/'
$zip = $url + 'zip/' + $archive
$sum = $url + 'checksums/' + $checksum

Invoke-Webrequest $zip -OutFile $tmp + $archive 
Invoke-Webrequest $sum -OutFile $tmp + $checksum
sha512 -c $tmp + $checksum
Write-Host "Placeholder for sha512sum verification"
mkdir $tmp + '\minecraft'
Expand-Archive -LiteralPath $tmp + $archive -DestinationPath $minecraft
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
cp $tmp + '\minecraft\mods\*' $minecraft + '\mods\'
cp $tmp + '\minecraft\shaderpacks\*' $minecraft + '\shaderpacks\'
cp $tmp + '\minecraft\resourcepacks\*' $minecraft +'\resourcepacks\'
rm -rv $tmp + '\minecraft'
rm $tmp + $archive
rm $tmp + $checksum
