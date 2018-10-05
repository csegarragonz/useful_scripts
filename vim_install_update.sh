#!/bin/bash
# This script sets all my vim plugins and set up. It installs pathogen vim, a plugin manager,
# and copies my vimrc to a config_files folder and softlinks it to root. It does the
# same thing with the .bashrc.
# Props to https://gist.github.com/gmhawash/5095015 who I took inspiration from
# Works well on Linux Mint

DOTVIM="$HOME/.vim"

if [ ! -e `which git` ]
then
  echo "No git found. Run sudo apt-get install git"
  exit 0
fi

if [ ! -d $DOTVIM ]
then
  mkdir $DOTVIM
fi

echo "Creating the necessary directory for Pathogen Vim"
mkdir -p $DOTVIM/{autoload,bundle,backup}
cd $DOTVIM/bundle/

get_repo() {
    gh_user=$1
    repo=$2
    echo "Checking $repo"
    if [ -d "$DOTVIM/bundle/$repo/" ]
    then
        echo "Pulling latest from $repo"
        cd $DOTVIM/bundle/$repo
        git pull origin master
        cd ..
    else
        echo "Cloning repo for $repo"
        git clone git://github.com/$gh_user/$repo.git
    fi
}

get_repo "scrooloose" "nerdtree"
get_repo "tmhedberg" "SimpylFold"
get_repo "vim-airline" "vim-airline"
get_repo "vim-airline" "vim-airline-themes"
get_repo "altercation" "vim-colors-solarized"
get_repo "vim-latex" "vim-latex"
# This package requires quite a lot of work
#get_repo "Valoric" "YouCompleteMe"
#cd $DOTVIM/autoload/bundle/YouCompleteMe
#git submodule update --init --recursive

cd $DOTVIM/autoload
echo "Fetching latest pathogen.vim"
rm pathogen.vim
curl https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim -o ~/.vim/autoload/pathogen.vim

echo "Cloning to the config-files folder. Cloning is done over SSH so remember to add your PKeys to Github."
cd $HOME
git clone git@github.com:csegarragonz/config_files.git

cd $HOME/config_files
echo "We create softlinks for the .bashrc and .vimrc files"
if [ ! -f .vimrc ]
then
  echo "No .vimrc file found, something went wrong! Exitting..."
  exit 0
else
  if [ ! -f $HOME/.vimrc ]
  then
    ln -s $HOME/config_files/.vimrc $HOME/.vimrc
  fi
fi
if [ ! -f .bashrc ]
then
  echo "No .bashrc file found, something went wrong! Exitting..."
  exit 0
else
  if [ ! -f $HOME/.bashrc ]
  then
    ln -s $HOME/config_files/.bashrc $HOME/.bashrc
  fi
fi
