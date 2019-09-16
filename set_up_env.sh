### CSG Environment Set Up Script
# TODO:
# 1. Add keys to the full installation
# 2. Add other packages to the full installation
# 3. Order apt-installs lexicographically
# 4. Include zsh configuration
# 5. Can I add my key remaps here?
# - Next/before/play/pause/volume
# - CAPS LOCK -> Ctrl
# 6. Choose default terminal emulator
# 7. If directory already exists, pull
# 8. Add server mode

# Check if full installation
if [[ $* == *--full* ]];
then
    sudo apt update
    sudo apt install \
        chromium \
        xsel
    sudo snap install \
        slack \
        spotify \
        telegram-desktop
fi

## If you want to update and do not have git installed you are dumb
if [[ $* == *--update* ]];
then
    if [ -d "~/config_files" ];
    then
        cd "~/config_files"
        git pull origin master
        exit 0
    else
        echo "Update but no config_files dir!"
        exit 1
    fi
fi

## General package installation
sudo apt-get update
sudo apt-get install \
    ctags \
    curl \
    git \
    python-dev \
    pyton-pip \
    python3-dev \
    pyton3-pip \
    ssh \
    sudo \
    tmux

## Neovim configuration

# Install Neovim
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim

# Installl Neovim with python support
sudo apt-get install
pip2 install user neovim
pip3 install user neovim

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Clone the repo with the config files
cd ~
git clone https://github.com/csegarragonz/config_files

# Setting up nvim
mkdir -p .config/nvim/
ln -s ~/config_files/init.vim ~/.config/nvim/init.vim
ln -s ~/config_files/after ~/.config/nvim/
ln -s ~/config_files/syntax ~/.config/nvim/
nvim +PlugInstall +qa
nvim +PlugUpdate +qa


## Tmux configuration
# Setting up tmux
if [ -f '~/.tmux.conf'];
then
    echo "There already exists a tmux configuration file. Replace it?"
    # TODO: ask Y/N
else
    ln -s ~/config_files/.tmux.conf ~/.tmux.conf
    ln -s ~/config_files/.tmux ~/.tmux
    # Install TPM and the plugins contained in the conf file
    git clone https://github.com/tmux-plugins/tpm ~/config_files/.tmux/plugins/tpm
    tmux source ~/.tmux.conf
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi
