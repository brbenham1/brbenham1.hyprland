#!/bin/bash

# Set the target directory
TARGET_DIR="$HOME/.config"

# Array of application directories
apps=("hypr" "waybar")

# Iterate through the array
echo "Creating symbolic links..."
for app in "${apps[@]}"; do
  # Find files in the application directory
  find "$app" -type f | while read file; do
    # Generate the target file path
    target_file="$TARGET_DIR/${file}"

    # Only proceed if the target file does not exist
    if [ ! -e "$target_file" ]; then
      # Create the target file's directory if it doesn't exist
      mkdir -p "$(dirname "$target_file")"

      # Create the symbolic link
      ln -s "$(pwd)/$file" "$target_file"
      echo "Created symbolic link for $file"
    fi
  done
done
echo "Done!"

# Check for stale symlinks in the target directory
echo "Checking for stale symlinks in $TARGET_DIR..."
for app in "${apps[@]}"; do
  find "$TARGET_DIR/$app" -type l | while read symlink; do
    if [ ! -e "$symlink" ]; then
      echo "Stale symlink found: $symlink"
      # Remove the stale symlink
      rm "$symlink"
    fi
  done
done
echo "Done!"
