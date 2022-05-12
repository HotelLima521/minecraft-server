#zip -r hl521-minecraft-$(date '+%Y-%m-%d'.zip * -x 'install.*' -x '*.tar.gz'
zip -r hl521-minecraft-2022-05-10.zip * -x 'install.*' -x '*.tar.gz' -x 'mods_test'
#tar --exclude='install.*' --exclude='*.zip' -czvf hl521-minecraft-$(date '+%Y-%m-%d').tar.gz *
tar --exclude='install.*' --exclude='*.zip' --exclude='mods_test' -czvf hl521-minecraft-2022-05-10.tar.gz *
sha512sum hl521-minecraft-2022-05-10.zip > hl521-minecraft-2022-05-10.zip.sha512sum
#sha512sum hl521-minecraft-$(date '+%Y-%m-%d').zip > hl521-minecraft-$(date '+%Y-%m-%d').zip.sha512sum
sha512sum hl521-minecraft-2022-05-10.tar.gz > hl521-minecraft-2022-05-10.tar.gz.sha512sum
#sha512sum hl521-minecraft-$(date '+%Y-%m-%d').tar.gz > hl521-minecraft-$(date '+%Y-%m-%d').tar.gz.sha512sum
# Secure Copy Below
