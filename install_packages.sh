#!/bin/bash

# Create necessary directories
mkdir -p ~/.local/bin ~/.config/chezmoi ~/SourceCode

# Update package list
sudo apt update && export DEBIAN_FRONTEND=noninteractive

# Install starship prompt
sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- --yes

# Install fzf (with keybindings)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/SourceCode/fzf
~/SourceCode/fzf/install --all --key-bindings --completion --update-rc

# Install zsh-fast-syntax-highlighting
git clone --depth 1 https://github.com/zdharma-continuum/fast-syntax-highlighting ~/SourceCode/zsh-fast-syntax-highlighting

# Install zsh-autosuggestions
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git ~/SourceCode/zsh-autosuggestions

# Install bat
curl -LO https://github.com/sharkdp/bat/releases/download/v0.18.3/bat-v0.18.3-x86_64-unknown-linux-gnu.tar.gz
tar -xzf bat-v0.18.3-x86_64-unknown-linux-gnu.tar.gz
mv bat-v0.18.3-x86_64-unknown-linux-gnu/bat ~/.local/bin/

# Install delta
curl -LO https://github.com/dandavison/delta/releases/download/0.16.5/delta-0.16.5-x86_64-unknown-linux-gnu.tar.gz
tar -xzf delta-0.16.5-x86_64-unknown-linux-gnu.tar.gz
mv delta-0.16.5-x86_64-unknown-linux-gnu/delta ~/.local/bin/

# Install thefuck
sudo apt install -y thefuck --no-install-recommends

# Add configuration to .zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
echo 'source ~/SourceCode/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh' >> ~/.zshrc
echo 'source ~/SourceCode/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
echo 'eval $(thefuck --alias)' >> ~/.zshrc
echo 'export PATH=$PATH:~/.local/bin' >> ~/.zshrc

# Add command history configuration to .zshrc
SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.shell_history"
echo "$SNIPPET" >> "/home/$USERNAME/.zshrc"

# cleanup
sudo apt-get autoremove
sudo apt-get clean -y
sudo rm -rf /var/lib/apt/lists/*
rm -rf bat-v0.18.3-x86_64-unknown-linux-gnu* delta-0.16.5-x86_64-unknown-linux-gnu*
