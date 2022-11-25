#!/bin/bash

APT_PACKAGES="./SetupKali/programs/packages.list"
HOMEDIR="/home/$(logname)"

setup_custom_scripts() {
  echo -e "\n Setting up dotfiles"
  # Download dotfiles
  git clone https://github.com/mdube99/dotfiles.git ~/dotfiles
  # Setup zsh settings
  echo "source $HOME/dotfiles/zsh/zshrc.sh" >> $HOME/.zshrc
  echo "source-file $HOME/dotfiles/tmux/tmux.conf" >> $HOME/.tmux.conf
  # Check for development folder, make it if it's not there
  if [[ -z "$HOMEDIR/development"]]; then
    mkdir $HOMEDIR/development/
  fi
  # Download scripts into development folder
  git clone https://github.com/mdube99/scripts.git ~/development/scripts
  # Restart zsh
  exec zsh
}

install_apt_applications() {
  echo -e "\n Installing Apt Applications"
  for l in $(cat $APT_PACKAGES); do
    sudo apt install -y $l
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
  sudo mkdir /opt/namemash
  sudo wget -O /opt/namemash/namemash.py "https://gist.githubusercontent.com/superkojiman/11076951/raw/74f3de7740acb197ecfa8340d07d3926a95e5d46/namemash.py"
  sudo mkdir /opt/procdump
  sudo wget -O /opt/procdump/Procdump.zip "https://download.sysinternals.com/files/Procdump.zip"
  sudo unzip /opt/procdump/Procdump.zip
}

setup_i3() {
  sudo apt install -y i3
  sudo cp ./plasma-i3.desktop /usr/share/xsessions/.
  sudo cp ./i3-config $HOME/.config/i3/config
  hotkeysRC="$XDG_CONFIG_HOME/kglobalshortcutsrc"
  # Remove application launching shortcuts.
  sed -i 's/_launch=[^,]*/_launch=none/g' $hotkeysRC
  # Remove other global shortcuts.
  sed -i 's/^\([^_].*\)=[^,]*/\1=none/g' $hotkeysRC
  # Reload hotkeys.
  kquitapp5 kglobalaccel && sleep 2s && kglobalaccel5 &  
  kwriteconfig5 --file startkderc --group General --key systemdBoot false
}

setup_custom_scripts
install_apt_applications
install_python_applications
install_opt_programs
setup_i3
