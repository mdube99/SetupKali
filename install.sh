#!/bin/bash

APT_PACKAGES="./programs/packages.list"
HOMEDIR="/home/$(logname)"

apt update && apt upgrade

setup_custom_scripts() {
  echo -e "\n Setting up dotfiles"
  # Download dotfiles
  git clone https://github.com/mdube99/dotfiles.git
  # Setup zsh settings
  echo "source $HOMEDIR/dotfiles/zsh/zshrc.sh" >> $HOME/.zshrc
  echo "source-file /home/mark/dotfiles/tmux/tmux.conf" >> $HOME/.tmux.conf
  # Check for development folder, make it if it's not there
  if [ -z "$HOMEDIR/development"]; then
    mkdir $HOMEDIR/development/
  fi
  # Download scripts into development folder
  git clone https://github.com/mdube99/scripts.git 
}

install_apt_applications() {
  echo -e "\n Installing Apt Applications"
  for l in $(cat $APT_PACKAGES); do
    echo "$l"
  done
}

install_python_applications() {
  echo -e "\n Installing Python Applications"
  pip install git+https://github.com/blacklanternsecurity/trevorproxy
  pip3 install updog
  pip install bloodhound
}

install_go_applications() {
  echo -e "\n Installing Go Applications"
  go install github.com/ffuf/ffuf@latest
}

install_opt_programs() {
  git clone 
  mkdir /opt/namemash
  curl "https://gist.githubusercontent.com/superkojiman/11076951/raw/74f3de7740acb197ecfa8340d07d3926a95e5d46/namemash.py" >> /opt/namemash/namemash.py
  mkdir /opt/procdump
  wget "https://download.sysinternals.com/files/Procdump.zip" /opt/procdump
}

setup_custom_scripts
install_apt_applications
install_python_applications
install_opt_programs
