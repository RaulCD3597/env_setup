#!/bin/bash

# Function to install packages if not already installed
install_mas_pkgs() {
  local packages=("$@")
  local installed=($(mas list | awk '{print $1}'))
  local to_install=()

  for pkg in "${packages[@]}"; do
    found=false
    for ipkg in "${installed[@]}"; do
      if [[ "$pkg" == "$ipkg" ]]; then
        found=true
        break
      fi
    done
    if ! $found; then
      to_install+=("$pkg")
    fi
  done

  for pkg in "${to_install}"; do
    echo "Installing: ${pkg}"
    mas install "${pkg}"
  done
}
