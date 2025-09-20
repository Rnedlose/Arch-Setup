#!/bin/bash

set -e # Exit on any error

echo "Starting Arch Linux package installation..."

# Update system first
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install yay AUR helper if not already installed
if ! command -v yay &>/dev/null; then
  echo "Installing yay AUR helper..."
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ~
else
  echo "yay is already installed, skipping..."
fi

# Install packages from official repositories
echo "Installing packages from official repositories and the AUR..."
yay -S --noconfirm \
  swayfx \
  sway-scrathpad-git \
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
  sunsetr-bin

echo "All packages have been installed successfully!"

# Installing LazyVim
mv ~/.config/nvim{,.bak}
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
git clone https://github.com/LazyVim/starter ~/.config/nvim

# Install tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing tmux plugin manager..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "tmux plugin manager already installed, skipping..."
fi

# Install tokyonight gtk theme
if [ ! -d "$HOME/Tokyo-Night-GTK-Theme" ]; then
  echo "Installing Tokyo-Night-GTK-Theme..."
  git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme.git ~/Tokyo-Night-GTK-Theme
  cd Tokyo-Night-GTK-Theme/themes
  ./install.sh -c dark -t default --tweaks storm -l
  gsettings set org.gnome.desktop.interface gtk-theme 'Tokyonight-Dark-Storm'
  gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Dark'
else
  echo "Theme already installed, skipping..."
fi

# dotfiles
if [ ! -d "$HOME/dotfiles" ]; then
  echo "Cloning dotfiles..."
  git clone https://github.com/Rnedlose/dotfiles.git ~/dotfiles
  echo "Ensuring clean directories for stow..."
  rm -rf ~/.config/hypr ~/.config/kitty 2>/dev/null || true
  echo "Setting symlinks with stow..."
  cd ~/dotfiles
  if stow .; then
    echo "Stow completed successfully."
  else
    echo "Warning: Stow encountered issues, you need to run it manually."
fi

sudo systemctl enable ly.service
sudo systemctl start ly.service

echo "You should probably reboot now..."
