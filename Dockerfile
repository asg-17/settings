# syntax=docker/dockerfile:1
FROM ubuntu:latest

RUN apt update && apt install -y \
  bat \
  build-essential \
  cscope \
  curl \
  exuberant-ctags \
  fd-find \
  git \
  gpg \
  nodejs \
  ripgrep \
  sudo \
  tmux \
  tree \
  vim \
  wget \
  zsh

# Create a user with sudo privileges.
ARG USER=anish
RUN useradd -rm -d /home/${USER} -s $(which zsh) -g root -G sudo ${USER}
RUN chown -R ${USER} /home/${USER}
RUN echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER}

COPY . /home/${USER}/.asg-17
RUN chown -R ${USER} /home/${USER}
USER ${USER}

# Install the dotfiles.
WORKDIR /home/${USER}/.asg-17
RUN ./setup.sh

WORKDIR /home/${USER}
ENTRYPOINT zsh
