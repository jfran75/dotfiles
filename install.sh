#!/usr/bin/env bash

echo "RUNNING dotfiles repo install.sh"

echo "STEP 1: 💾 copying .gitconfig and .gitignore_global"
cp -r ./git/.gitconfig ~
cp -r ./git/config ~/.ssh/config


# echo "STEP 1: 💾 copying .gitconfig and .gitignore_global"
# cp -r ./git/.gitconfig ./git/.gitignore_global ~
DOTFILES_PATH="$HOME/.config/coderv2/dotfiles"
CODER_SERVER_PATH="/tmp/code-server/bin/code-server"
CODER_PATH="/opt/coder"

echo "🐚 Shell is $SHELL"
echo "STEP 2: 💾 copying shell configuration files e.g., bash, zsh"

if [ "$SHELL" == "/bin/bash" ]; then 
  cp ./shell/bash/.bashrc $HOME/.bashrc
  cp ./shell/bash/.bash_profile $HOME/.bash_profile  
elif [ "$SHELL" == "/usr/bin/zsh" ]; then
  cp ./shell/zsh/.zshrc $HOME/.zshrc
  cp ./shell/zsh/.p10k.zsh $HOME/.p10k.zsh
else
  echo "no unix shell dotfiles copied"
fi

echo "STEP 3: 💾 copying VS Code-related config files e.g., settings, keybindings, tasks"