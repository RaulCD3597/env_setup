#!/bin/bash

# Function to check if a package is installed
is_installed() {
  brew ls "$1" &>/dev/null
}

# Function to install packages if not already installed
install_brew_pkgs() {
  local packages=("$@")
  local to_install=()

  for pkg in "${packages[@]}"; do
    if ! is_installed "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    echo "Installing: ${to_install[*]}"
    brew install "${to_install[@]}"
  fi
}

# Function to install casks if not already installed
install_brew_casks() {
  local casks=("$@")
  local to_install=()

  for cask in "${casks[@]}"; do
    if ! is_installed "$cask"; then
      to_install+=("$cask")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    echo "Installing: ${to_install[*]}"
    brew install --cask "${to_install[@]}"
  fi
}
