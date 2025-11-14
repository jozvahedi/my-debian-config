#!/bin/bash
# Uninstall script for i3-gaps Debian setup

echo "Starting uninstallation of i3-gaps environment..."
sleep 2

# Disable and stop services
sudo systemctl disable ly.service 2>/dev/null
sudo systemctl stop ly.service 2>/dev/null
sudo systemctl disable cups 2>/dev/null
sudo systemctl stop cups 2>/dev/null
sudo systemctl disable bluetooth 2>/dev/null
sudo systemctl stop bluetooth 2>/dev/null
sudo systemctl disable avahi-daemon 2>/dev/null
sudo systemctl stop avahi-daemon 2>/dev/null
sudo systemctl disable acpid 2>/dev/null
sudo systemctl stop acpid 2>/dev/null

# Remove Ly display manager (if installed)
sudo rm -rf /usr/local/bin/ly /etc/systemd/system/ly.service /etc/ly

# Remove i3-gaps
sudo rm -rf /usr/local/bin/i3 /usr/local/share/i3 /usr/local/share/xsessions/i3.desktop

# Remove cloned repos
rm -rf ~/Downloads/i3-gaps ~/Downloads/ly

# Remove configuration (optional)
read -p "Do you want to remove your ~/.config/i3 and related configs? (y/n): " resp
if [[ $resp == "y" ]]; then
    rm -rf ~/.config/i3 ~/.config/kitty ~/.config/rofi ~/.config/dunst ~/.config/picom ~/.config/xfce4
    echo "Config folders removed."
fi

# Remove installed packages
sudo apt remove -y \
xorg xbacklight xbindkeys xvkbd xinput xorg-dev \
python3-pip \
intel-microcode \
network-manager-gnome \
lxappearance \
thunar xfce4-settings xfce4-power-manager xfce4-terminal \
dialog mtools dosfstools avahi-daemon acpi acpid gvfs-backends \
kitty \
pulseaudio alsa-utils pavucontrol volumeicon-alsa \
neofetch htop \
exa \
cups bluez blueman \
firefox-esr feh \
meson dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev i3status \
dmenu sxhkd numlockx rofi dunst libnotify-bin picom unzip geany simple-scan \
micro \
fonts-font-awesome fonts-powerline fonts-ubuntu fonts-liberation2 fonts-liberation fonts-terminus fonts-cascadia-code

# Clean up
sudo apt autoremove -y
sudo apt clean
sudo apt autoclean

echo "-------------------------------------------------"
echo "i3-gaps and related packages have been uninstalled."
echo "If Ly was installed, it has been removed too."
echo "-------------------------------------------------"
