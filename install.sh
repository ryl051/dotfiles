#!/bin/bash
# install.sh
# This script creates symlinks for .bashrc, .vimrc, and the nvim configuration folder.
# It backs up any existing files/folders before linking.
# Make sure your dotfiles repository is located at ~/dotfiles

DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d%H%M%S)"

# Files and directories to symlink
FILES=(.bashrc .vimrc)

# Create backup directory
mkdir -p "$BACKUP_DIR"
echo "Backing up existing dotfiles to $BACKUP_DIR"

# Backup and symlink dotfiles in home directory
for file in "${FILES[@]}"; do
    if [ -e "$HOME/$file" ] || [ -L "$HOME/$file" ]; then
        echo "Moving existing $file to backup folder"
        mv "$HOME/$file" "$BACKUP_DIR/"
    fi
    echo "Creating symlink for $file"
    ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
done

# Handle the nvim configuration folder
NVIM_SOURCE="$DOTFILES_DIR/nvim"
NVIM_DEST="$HOME/.config/nvim"

# Ensure the parent directory exists
mkdir -p "$(dirname "$NVIM_DEST")"

if [ -e "$NVIM_DEST" ] || [ -L "$NVIM_DEST" ]; then
    echo "Moving existing nvim configuration to backup folder"
    mv "$NVIM_DEST" "$BACKUP_DIR/"
fi

echo "Creating symlink for nvim configuration"
ln -sf "$NVIM_SOURCE" "$NVIM_DEST"

echo "Dotfiles symlink process completed."

