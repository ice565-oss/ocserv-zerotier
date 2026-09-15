#!/bin/sh

# Создаем TUN устройство для работы VPN
if [ ! -c /dev/net/tun ]; then
    mkdir -p /dev/net
    mknod /dev/net/tun c 10 200
    chmod 600 /dev/net/tun
fi

exec "$@"
