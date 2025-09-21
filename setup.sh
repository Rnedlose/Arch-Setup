#!/bin/bash

set -e # Exit on any error

echo "Starting Arch Linux package installation..."

echo "Updating system..."
sudo pacman -Syu --noconfirm

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~

echo "Installing packages from official repositories and the AUR..."
yay -S --noconfirm \
  swayfx \
  autotiling \
  neovim \
  ripgrep \
  base-devel \
  waybar \
  rofi \
  starship \
  fastfetch \
  btop \
  bat \
  eza \
  zoxide \
  zsh \
  tmux \
  wl-clipboard \
  unzip \
  glib2 \
  fzf \
  bluez \
  bluez-utils \
  pipewire \
  pipewire-pulse \
  pipewire-alsa \
  pipewire-jack \
  wireplumber \
  iwd \
  gum \
  pamixer \
  lazygit \
  lazydocker \
  dconf-editor \
  libnotify \
  tree \
  vim \
  alacritty \
  kitty \
  nautilus \
  imv \
  mpd \
  yazi \
  ttf-jetbrains-mono-nerd \
  ttf-cascadia-mono-nerd \
  docker \
  vlc \
  file-roller \
  obs-studio \
  papirus-icon-theme \
  stow \
  ly \
  swayosd \
  warp-terminal \
  cliphist \
  bluetui \
  wiremix \
  impala \
  mise \
  yaru-theme \
  spotify \
  discord \
  obsidian \
  google-chrome \
  swww \
  swaync \
  localsend \
  github-cli \
  sunsetr-bin

echo "All packages have been installed successfully!"

git clone https://github.com/LazyVim/starter ~/.config/nvim

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme.git ~/Tokyo-Night-GTK-Theme
cd Tokyo-Night-GTK-Theme/themes
./install.sh -c dark -t default --tweaks storm -l
gsettings set org.gnome.desktop.interface gtk-theme 'Tokyonight-Dark-Storm'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'

git clone https://github.com/Rnedlose/dotfiles.git ~/dotfiles
echo "Ensuring clean directories for stow..."
echo "Setting symlinks with stow..."
cd ~/dotfiles
stow .

sudo systemctl enable ly.service
sudo systemctl start ly.service

echo "Rebooting now"

sudo reboot now
