#!/bin/bash

# Clear screen
clear

# Exit on any error
set -e

UPDATE_FLAG=false
for arg in "$@"; do
  if [ "$arg" == "-u" ] || [ "$arg" == "--update" ]; then
    UPDATE_FLAG=true
    break
  fi
done

# Source utility functions
source brew-utils.sh
source mas-utils.sh

# # Source the package list
if [ ! -f "packages.conf" ]; then
  echo "Error: packages.conf not found!"
  exit 1
fi

source packages.conf

if ! command -v brew &>/dev/null; then
  # Install brew if not present
  echo "Installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "brew is already installed"
fi

if ! command mas version &>/dev/null; then
  # Install mas if not present
  echo "Installing mas..."
  brew install mas
else
  echo "mas is already installed"
fi

# Update system
if [ "$UPDATE_FLAG" == true ]; then
  echo "Updating system..."
  brew update
  mas upgrade
fi

# Install packages
echo "Installing brew packages..."
install_brew_pkgs "${BREW_PKGS[@]}"

# Install casks
echo "Installing brew casks..."
install_brew_pkgs "${BREW_CASKS[@]}"

# Install mas packages
echo "Installing mas packages..."
install_mas_pkgs "${MAS_PKGS[@]}"
