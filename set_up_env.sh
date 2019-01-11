# Check if full installation
if [[ $* == *--full* ]]; then
    sudo apt update
    sudo apt install \
        chromium \
        ssh \
        sudo
    sudo snap install \
        spotify \
        telegram-desktop

## Neovim configuration

# Install Neovim
sudo apt-get install software-properties-common
sudo apt-add-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim python-dev python-pip python3-dev python3-pip curl git

# Installl Neovim with python support
sudo apt-get install python-pip python3-pip ctags
pip2 install user neovim
pip3 install user neovim

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Clone the repo with the config files
cd ~
git clone https://github.com/csegarragonz/config_files

mkdir -p .config/nvim/
ln -s ~/config_files/init.vim ~/.config/nvim/init.vim
nvim +PlugInstall +qa
nvim +PlugUpdate +qa
