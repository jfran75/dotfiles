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

### fonts
echo "STEP 3: 💾 Installing default fonts"
mkdir -p /home/${USER}/.local/share/fonts/
cd /home/${USER}/.local/share/fonts/
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -O /home/${USER}/.local/share/fonts/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -O /home/${USER}/.local/share/fonts/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -O /home/${USER}/.local/share/fonts/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -O /home/${USER}/.local/share/fonts/MesloLGS%20NF%20Bold%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -O /home/${USER}/.local/share/fonts/MesloLGS%20NF%20Bold%20Italic.ttf
wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Regular/FiraMonoNerdFont-Regular.otf -O /home/${USER}/.local/share/fonts/FiraMonoNerdFont-Regular.otf
wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Regular/FiraMonoNerdFontMono-Regular.otf -O /home/${USER}/.local/share/fonts/FiraMonoNerdFontMono-Regular.otf
wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Regular/FiraMonoNerdFontPropo-Regular.otf -O /home/${USER}/.local/share/fonts/FiraMonoNerdFontPropo-Regular.otf
wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFont-Regular.ttf  -O /home/${USER}/.local/share/fonts/FiraCodeNerdFont-Regular.ttf
wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFontMono-Regular.ttf  -O /home/${USER}/.local/share/fonts/FiraCodeNerdFontMono-Regular.ttf
wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/FiraCodeNerdFontPropo-Regular.ttf  -O /home/${USER}/.local/share/fonts/FiraCodeNerdFontPropo-Regular.ttf
fc-cache -f -v

### install oh-my-zsh
echo "STEP 4.1: 💾 Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### install powerlevel10k
echo "STEP 4.2: 💾 Installing powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

### install oh-my-zsh PLUGINS
echo "STEP 4.3: 💾 Installing oh-my-zsh PLUGINS"
#### zsh-autosuggestions:
echo "STEP 4.4: 💾 Installing zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#### zsh-syntax-highlighting:
echo "STEP 4.5: 💾 Installing zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


### node version manager
echo "STEP 5.1: 💾 Installing node version manager(nvm)"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# RUN nvm install default versions
echo "STEP 5.2: 💾 Installing nvm default versions"
NVM_DIR="/home/${USER}/.nvm"
. "$NVM_DIR/nvm.sh" && nvm install v10.16.3
. "$NVM_DIR/nvm.sh" && nvm install v12.22.1
. "$NVM_DIR/nvm.sh" && nvm install v16.14.2

# Set nvm default version
echo "STEP 5.3: 💾 Settings nvm defaul version to v16.14.2"
. "$NVM_DIR/nvm.sh" && nvm use v16.14.2
. "$NVM_DIR/nvm.sh" && nvm alias default v16.14.2
