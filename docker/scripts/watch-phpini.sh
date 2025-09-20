#!/bin/bash
# مانیتور تغییرات php.ini و ری‌استارت php-apache کانتینر
#install tools
#sudo apt-get install inotify-tools -y
#chmod +x watch-phpini.sh
PHP_INI="./php/ini/php.ini"
CONTAINER="php"

echo "⏳ Monitoring $PHP_INI for changes..."
while inotifywait -e modify $PHP_INI; do
    echo "🔄 php.ini changed, restarting $CONTAINER..."
    docker restart $CONTAINER
done
