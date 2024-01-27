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
  locales \
  nodejs \
  ripgrep \
  sudo \
  tmux \
  tree \
  vim \
  wget \
  zsh

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en

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
