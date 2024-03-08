#!/bin/bash

CONFIG_JSON='
{
  "auths": {
          "https://index.docker.io/v1/": {}
  },
  "credStore": "osxkeychain"
}
'

export HOMEBREW_NO_AUTO_UPDATE=1

throw_error() {
   echo "[ERROR]: An error has ocurred on '$1'"
}

confirm() {
    read -r -p "${1:-Are you sure?} [Y/n]: " response
    case "$response" in
        [nN][oO]|[nN])
          echo ;
          return 1;;
        *)
          echo ;
          return 0;;
    esac
}

check_jq_installed() {
  if ! command -v jq &> /dev/null; then
    echo >&2 "jq is not installed!"
    if confirm "Do you want install jq?"; then
      brew install jq
    fi
  fi
}

check_pcregrep_installed() {
  if ! command -v pcregrep &> /dev/null; then
    echo >&2 "pcregrep is not installed!"
    if confirm "Do you want install pcregrep?"; then
      brew install pcre
    fi
  fi
}

install_podman() {
  echo "1 - Installing podman with brew..."
  brew install podman > /dev/null
  if [ $? -ne 0 ]; then
    throw_error 'installing podman'
  fi
}

initialize_podman_machine() {
  echo "2 - Initialize a podman machine..."
  podman machine init > /dev/null
  if [ $? -ne 0 ]; then
    throw_error 'initialize podman machine'
  fi
}

installing_podman_mac_helper() {
  echo "3 - Installing a podman-mac-helper..."
  PODMAN_VERSION=$(podman -v | sed s/"podman version "//g)
  sudo /opt/homebrew/Cellar/podman/$PODMAN_VERSION/bin/podman-mac-helper install > /dev/null
  if [ $? -ne 0 ]; then
    throw_error 'installing podman-mac-helper'
  fi
}

set_podman_sock() {
  echo "4 - Set podman sock to default machine"
  PODMAN_SOCK_PORT=$(podman system connection list | pcregrep -o1 ":([0-9]*)" | grep -m 1 "[0-9]*")
  PODMAN_SOCK_USER=$(podman system connection list | pcregrep -o1 "/run/user/([0-9]*)" | grep -m 1 ".*")
  echo $(ssh -fnNT -L/tmp/podman.sock:/run/user/$PODMAN_SOCK_USER/podman/podman.sock -i ~/.ssh/podman-machine-default ssh://core@localhost:$PODMAN_SOCK_PORT -o StreamLocalBindUnlink=yes) > /dev/null
}

add_podman_sock_to_the_env() {
  echo "4.1 - Adding a podman sock to the environment..."
  PODMAN_CONNECTION_SOCK='
PODMAN_SOCK_PORT=$(podman system connection list | pcregrep -o1 ":([0-9]*)" | grep -m 1 "[0-9]*")\n
PODMAN_SOCK_USER=$(podman system connection list | pcregrep -o1 "/run/user/([0-9]*)" | grep -m 1 ".*")\n
echo $(ssh -fnNT -L/tmp/podman.sock:/run/user/$PODMAN_SOCK_USER/podman/podman.sock -i ~/.ssh/podman-machine-default ssh://core@localhost:$PODMAN_SOCK_PORT -o StreamLocalBindUnlink=yes)
'  
PODMAN_SOCK="export DOCKER_HOST='unix:///tmp/podman.sock'"
  if [[ -n "$(cat ~/.zshrc)" ]]; then
    echo $PODMAN_CONNECTION_SOCK >> ~/.zshrc
    echo $PODMAN_SOCK >> ~/.zshrc
  elif [[ -n "$(cat ~/.bashrc)" ]]; then
    echo $PODMAN_CONNECTION_SOCK >> ~/.bashrc
    echo $PODMAN_SOCK >> ~/.bashrc
    source ~/.bashrc
  else
    echo $PODMAN_CONNECTION_SOCK >> ~/.bash_profile
    echo $PODMAN_SOCK >> ~/.bash_profile
    source ~/.bash_profile
  fi
  if [ $? -ne 0 ]; then
    throw_error 'add podman sock to the env'
  fi
}

reboot_podman() {
  echo "5 - Reboot podman machine..."
  DOCKER_HOST='unix:///tmp/podman.sock'
  podman machine stop > /dev/null
  podman machine start > /dev/null
  if [ $? -ne 0 ]; then
    throw_error 'reboot podman'
  fi
}

install_podman_desktop() {
  echo "6 - Installing podman-desktop..."
  brew install podman-desktop > /dev/null
  if [ $? -ne 0 ]; then
    throw_error 'install podman-desktop'
  fi
}

update_docker_config() {
  echo "7 - Updating ~/.docker/config.json to use podman compose..."
  if [[ -n "$(jq --version)" ]]; then
    echo $CONFIG_JSON | jq | tee ~/.docker/config.json
  else
    echo $CONFIG_JSON | tee ~/.docker/config.json
  fi
  if [ $? -ne 0 ]; then
    throw_error 'update ~/.docker/config.json'
  fi
}

create_docker_alias() {
  ALIAS="alias docker="podman""
  echo "8 - Create alias to use 'docker' instead 'podman' to run commands..."
  if [[ -n "$(cat ~/.zshrc)" ]]; then
    echo $ALIAS >> ~/.zshrc
  elif [[ -n "$(cat ~/.bashrc)" ]]; then
    echo $ALIAS >> ~/.bashrc
    source ~/.bashrc
  else
    echo $ALIAS >> ~/.bash_profile
    source ~/.bash_profile
  fi
  if [ $? -ne 0 ]; then
    throw_error 'add podman sock to the env'
  else
    echo "[INFO] Use docker run normally instead podman run"
  fi
}

check_jq_installed
check_pcregrep_installed
install_podman
initialize_podman_machine
installing_podman_mac_helper
set_podman_sock
add_podman_sock_to_the_env
reboot_podman
install_podman_desktop
update_docker_config

if confirm "Create an docker alias to podman?"; then
  create_docker_alias
fi

if [[ -n "$(cat ~/.zshrc)" ]]; then
  echo "[INFO] Run 'source ~/.zshrc' to complete installation"
fi
