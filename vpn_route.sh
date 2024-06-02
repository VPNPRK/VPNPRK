#!/bin/sh

# Сетевой интерфейс для выхода в интернет
DEV='enp0s8'

# Значение подсети
PRIVATE=172.16.0.0/24

if [ -z "$DEV" ]; then
DEV="$(ip route | grep default | head -n 1 | awk '{print $5}')"
fi
# Маршрутизация транзитных IP-пакетов
sudo sysctl net.ipv4.ip_forward=1
# Проверка блокировки перенаправленного трафика iptables
sudo iptables -I FORWARD -j ACCEPT

# Преобразование адресов (NAT)

sudo iptables -t nat -I POSTROUTING -s $PRIVATE -o $DEV -j MASQUERADE
