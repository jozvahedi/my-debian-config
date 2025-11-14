#!/bin/bash

# توقف اجرای اسکریپت در صورت بروز خطا
set -e

echo "🔹 Updating system..."
sudo apt update -y && sudo apt upgrade -y
echo "🔹 Installing required nerdfonts packages..."
source nerdfonts.sh

echo "🔹 Installing required packages..."
sudo apt-get install -y kitty zsh curl git wget

echo "🔹 Changing default shell to zsh..."
chsh -s $(which zsh)

echo "🔹 Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "🔹 Installing fzf..."
sudo apt-get install -y fzf

echo "🔹 Installing Zsh plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

echo "🔹 Installing eza..."
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

echo "🔹 Installing tldr..."
sudo apt install -y tldr

echo "🔹 Copying bash folder contents to home directory..."
if [ -d "./bash" ]; then
    cp -r ./bash/* ~/
    echo "✅ bash folder contents copied to home directory."
else
    echo "⚠️  No 'bash' folder found in current directory. Skipping copy step."
fi
sudo apt autoremove
#chmod +x setup.sh
echo "✅ Installation complete! Please restart your terminal or run 'zsh' to start using it."
