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

### install oh-my-zsh
echo "STEP 3.1: 💾 Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### install powerlevel10k
echo "STEP 3.2: 💾 Installing powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

### install oh-my-zsh PLUGINS
echo "STEP 3.3: 💾 Installing oh-my-zsh PLUGINS"
#### zsh-autosuggestions:
echo "STEP 3.4: 💾 Installing zsh-autosuggestions"
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#### zsh-syntax-highlighting:
echo "STEP 3.5: 💾 Installing zsh-syntax-highlighting"
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


