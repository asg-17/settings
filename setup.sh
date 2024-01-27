#!/usr/bin/env bash


execute() {
  cmd=$1
  msg=$2

  eval "${cmd}"
  if [[ $? ]]; then
    # Print output in green.
    printf "\e[0;32m  [✔] %s\e[0m\n" "${msg}"
  else
    # Print output in red.
    printf "\e[0;31m  [✖] %s\e[0m\n" "${msg}"
  fi
}

link_file() {
  local source=$1
  local target=$2

  # We've already symlinked, do nothing.
  if [[ "$(readlink "${target}")" == "${source}" ]]; then
    return
  fi

  # If the target location exists and it's not our target symlink, we create a backup.
  if [[ -e "${target}" ]]; then
    epoch=$(date +%s)
    execute "mv ${target} ${target}.${epoch}.bak" "Backing up ${target} → ${target}.${epoch}.bak"
  fi

  # Symlink the dotfile.
  execute "ln -fs ${source} ${target}" "Linking ${target} → ${source}"
}

install_ohmyzsh() {
  ZSH=${HOME}/.oh-my-zsh
  ZSH_CUSTOM="${ZSH_CUSTOM:-${ZSH}/custom}"

  # Clone or update Oh My Zsh.
  if [[ ! -d "${ZSH}" ]]; then
    git clone --quiet --filter=blob:none https://github.com/robbyrussell/oh-my-zsh "${ZSH}"
  else
    git -C "${ZSH}" pull --quiet
  fi

  # Install or update custom oh-my-zsh plugins.
  CUSTOM_PLUGIN_REPOS=(
    "https://github.com/popstas/zsh-command-time"
    "https://github.com/Aloxaf/fzf-tab"
    "https://github.com/zdharma-continuum/fast-syntax-highlighting"
    "https://github.com/zsh-users/zsh-autosuggestions"
    "https://github.com/zsh-users/zsh-completions"
  )

  for REPO_URL in "${CUSTOM_PLUGIN_REPOS[@]}"; do
    PLUGIN_PATH="${ZSH_CUSTOM}/plugins/${REPO_URL##*/}"
    if [[ ! -d "${PLUGIN_PATH}" ]]; then
      git clone --quiet --filter=blob:none "${REPO_URL}" "${PLUGIN_PATH}"
    else
      git -C "${PLUGIN_PATH}" pull --quiet
    fi
  done

  # Because zsh-command-time is the worst
  execute "mv ${ZSH_CUSTOM}/plugins/zsh-command-time ${ZSH_CUSTOM}/plugins/command-time"
}

install_fzf() {
  FZF=${HOME}/.fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git "${FZF}"
  ${FZF}/install
}

install_tpm() {
  git clone --quiet --filter=blob:none https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm
}

main() {

  #Symlink dotfiles
  DOTFILES=($(find dotfiles -type f))
  for dotfile in "${DOTFILES[@]}"; do
    srcfile="$(pwd)/${dotfile}"
    destfile="${HOME}/.$(basename "${dotfile}")"

    echo $srcfile $destfile

    link_file "$srcfile" "$destfile"
  done

  install_ohmyzsh

  install_fzf

  install_tpm
}

main "$0"

