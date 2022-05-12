zip -r hl521-minecraft-$(date '+%Y-%m-%d'.zip * -x 'install.*' -x '*.tar.gz'
tar --exclude='install.*' --exclude='*.zip' -czvf hl521-minecraft-$(date '+%Y-%m-%d').tar.gz *
sha512sum hl521-minecraft-$(date '+%Y-%m-%d').zip > hl521-minecraft-$(date '+%Y-%m-%d').zip.sha512sum
sha512sum hl521-minecraft-$(date '+%Y-%m-%d').tar.gz > hl521-minecraft-$(date '+%Y-%m-%d').tar.gz.sha512sum
# Secure Copy Below
