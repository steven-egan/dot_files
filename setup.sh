#!/bin/bash

echo "'stow'ing dotfiles..."
cp ./local/bin/tmux-sessionizer ~/.local/bin/tmux-sessionizer
stow .
## Some tools expect the config in ~/.config/zsh
ln -s ~/.config/zsh/.zshrc ~/.zshrc

# Check if the OS is macOS
if [[ "$(uname)" == "Darwin" ]]; then
  echo "Running on macOS ✅"

  # Check if Homebrew is installed
  if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  else
    echo "Homebrew already installed ✅"
  fi

  # Update Homebrew
  echo "Updating Homebrew..."
  brew update

  # Install from Brewfile
  BREWFILE_PATH="$HOME/Brewfile"

  if [[ -f "$BREWFILE_PATH" ]]; then
    echo "Installing packages from Brewfile..."
    brew bundle --file="$BREWFILE_PATH"
  else
    echo "No Brewfile found at $BREWFILE_PATH"
    echo "You can generate one with:"
    echo "  brew bundle dump --file=~/Brewfile --describe --force"
  fi

  echo "✅ Setup complete"
fi
echo "Setup complete"
