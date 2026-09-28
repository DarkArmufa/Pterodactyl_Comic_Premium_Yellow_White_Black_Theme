#!/bin/bash

PANEL="/var/www/pterodactyl"

echo "Installing Comic Premium Theme..."

if [ ! -d "$PANEL" ]; then
 echo "Pterodactyl not found"
 exit 1
fi

cp -r theme/* "$PANEL/public/" 2>/dev/null

chown -R www-data:www-data "$PANEL"

cd "$PANEL"

php artisan optimize:clear
php artisan view:clear

systemctl restart nginx

if systemctl list-units --type=service | grep -q php8.3-fpm; then
 systemctl restart php8.3-fpm
fi

echo "Theme installed!"
