#!/bin/bash

set -euo pipefail

systemctl enable nginx

rm -rf /var/www/html
cp -rTp "${RECIPE_DIR}/html" /var/www/html
chown -R www-data:www-data /var/www/html



wget https://github.com/theAndreas/raspberrypi-kernel64-rt/raw/1.20230405-1/deb-package/raspberrypi-kernel_1.20230405-1_arm64.deb
dpkg -r --force-depends raspberrypi-kernel
dpkg -i ./raspberrypi-kernel_1.20230405-1_arm64.deb
cp /boot/kernel8.img /boot/firmware/kernel8.img
apt-mark hold raspberrypi-kernel

echo "kernel=kernel8.img" >> /boot/config.txt
