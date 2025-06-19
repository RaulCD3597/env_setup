#!/bin/bash

REPO_URL="https://github.com/RaulCD3597/dotfiles"
REPO_NAME="$HOME/.dotfiles"

is_stow_installed() {
  brew ls "stow" &>/dev/null
}

if ! is_stow_installed; then
  echo "Install stow first"
  exit 1
fi

# Check if the repository already exists
if [ -d "$REPO_NAME" ]; then
  echo "Repository '$REPO_NAME' already exists. Skipping clone"
else
  git clone "$REPO_URL" "$REPO_NAME"
fi

# Check if the clone was successful
if [ $? -eq 0 ]; then
  cd "$REPO_NAME"
  stow nvim
  stow zshrc
  stow ghostty
  stow tmux
  # stow bat
else
  echo "Failed to clone the repository."
  exit 1
fi
