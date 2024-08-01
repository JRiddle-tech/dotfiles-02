#!/bin/bash

home_dir='/home/'"$username"

# Add additional repositories
apt install software-properties-common -y
apt-add-repository non-free -y
apt-add-repository contrib -y
dpkg --add-architecture amd64

# Get Enpass repo key
echo "deb https://apt.enpass.io/ stable main" > \
  /etc/apt/sources.list.d/enpass.list
wget -O - https://apt.enpass.io/keys/enpass-linux.key | tee /etc/apt/trusted.gpg.d/enpass.asc
apt update

apt install xorg i3 pulseaudio alsa-utils gimp inkscape xfce4-settings yaru-theme-gtk firefox-esr alacritty thunar vim git unzip shotwell celluloid gvfs-backends samba cifs-utils smbclient rofi i3blocks kbdd feh picom xinput maim xclip xdotool libsdl2-2.0-0 libsdl2-dev libsdl2-image-2.0-0 libsdl2-image-dev libsdl2-ttf-2.0-0 libsdl2-ttf-dev libsdl2-mixer-2.0-0 libsdl2-mixer-dev gtk2-engines-murrine gtk2-engines-pixbuf rhythmbox xautolock htop libavcodec-extra playerctl gnome-disk-utility gufw libreoffice libreoffice-gtk3 printer-driver-hpcups hplip gamemode openvpn openssl openresolv transmission-gtk rsync timeshift pavucontrol gdb flatpak galculator mousepad python3.11-venv thunar-archive-plugin neovim -y
apt install --no-install-recommends xfce4-session -y
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.vscodium.codium -y
flatpak install flathub com.discordapp.Discord -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub md.obsidian.Obsidian -y
apt autoremove dmenu libreoffice-math libreoffice-draw libreoffice-draw libreoffice-impress libreoffice-base -y

# Copy all configurations
mkdir -p "$home_dir"/.local/share/
mkdir "$home_dir"/.config/
mkdir -p "$home_dir"/Pictures/screenshots
cp -r .scripts/ "$home_dir"
sudo cp -r /usr/share/themes/Yaru /usr/share/themes/Yaru-dark /usr/share/themes/Yaru-sage /usr/share/themes/Yaru-sage-dark ~/.local/share/themes/
cp .bashrc "$home_dir"/
cp .vimrc "$home_dir"/
cp settings.desktop /usr/share/applications/

flatpak override --filesystem=xdg-data/themes
flatpak override --filesystem=xdg-data/icons
flatpak override --env=GTK_THEME=Yaru-sage-dark
flatpak override --env=ICON_THEME=Papirus-Dark

chown -R "$username":"$username" "$home_dir"/.local
chown -R "$username":"$username" "$home_dir"/.config
chown -R "$username":"$username" "$home_dir"/Pictures/screenshots

timedatectl set-local-rtc 0

xdg-settings set default-web-browser firefox-esr.desktop
xdg-mime default thunar.desktop inode/directory


echo "Reboot your computer to apply the changes!"
