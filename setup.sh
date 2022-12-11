#!/bin/ash

echo "========== Alpine Linux Setup  ================"

echo "====================> Add sudo & create new user (jsj)"
apk add sudo
adduser -g "Bradley Taunt" jsj
adduser jsj wheel

echo "====================> Running setup-xorg-base"
setup-xorg-base

echo "====================> Installing helpful packages"
apk add dbus xdg-desktop-portal xdg-desktop-portal-wlr pipewire linux-firmware wireless-tools iwd util-linux 
apk add pciutils usbutils coreutils binutils findutils grep iproute2 
apk add pulseaudio pulseaudio-alsa pavucontrol pamixer playerctl bluez mako 
apk add python3 network-manager-applet kanshi clipman gnome-tweaks gnome-keyring micro vim font-misc-misc font-awesome
apk add curl zsh light gawk grim slurp feh
apk add bash bash-doc bash-completion
apk add udisks2 udisks2-doc
apk add mesa-dri-gallium
apk add wofi

echo "====================> Installing sway and custom packages"
apk add eudev
setup-devd udev
apk add nwg-launchers-bar
apk add sway sway-doc xwayland 
apk add swaylock swaylockd swaybg swayidle 
apk add ttf-dejavu elogind polkit-elogind autotiling 
apk add qutebrowser thunar azote
apk add foot
apk add seatd

echo "====================> Add user jsj to proper groups"
adduser jsj input
adduser jsj video

echo "====================> Update main config files"
cp -r ./jsj/sway /home/jsj/.config/
cp -r ./jsj/waybar /home/jsj/.config/
cp -r ./jsj/foot /home/jsj/.config/
cp -r ./jsj/qutebrowser /home/jsj/.config/
cp -r ./jsj/nwg-drawer /home/jsj/.config/
cp -r ./jsj/nwg-launchers /home/jsj/.config/
cp -r ./jsj/nwg-look /home/jsj/.config/
cp -r ./jsj/wofi /home/jsj/.config/
cp -r ./jsj/mimeapps.list /etc/xdg/
cat ./jsj/.profile >> /home/jsj/.profile

echo "====================> Include default wallpaper"
cp -r ./jsj/wallpaper /home/jsj/

echo "====================> Configuring services to launch at boot"
rc-update add seatd
rc-service seatd start
adduser jsj seat
rc-service dbus start
rc-update add dbus
rc-service iwd start
rc-update add iwd

echo "====================> Optional: Connect to a wifi hotspot"
#iwctl station wlan0 connect bchhh

echo "====================>  Setup complete"
echo "You can now reboot your machine."
