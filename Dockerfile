FROM ubuntu:latest

RUN mkdir /dependencies

COPY ./dependencies/nix-2.16.1-x86_64-linux /dependencies/nix
COPY ./dependencies/nixpkgs /dependencies/nixpkgs

RUN mkdir -p /nix /etc/nix \
 && chmod a+rwx /nix \
 && mkdir -p ~/.config/nixpkgs

RUN adduser nix --home /home/nix --disabled-password --gecos "" --shell /bin/bash

COPY ./dependencies/nix.conf /nix/nix.conf
RUN chown nix /nix/nix.conf
ENV NIX_CONF_DIR /nix

USER nix
ENV USER nix
WORKDIR /home/nix

COPY ./dependencies/nixpkgs-config.nix /home/nix/.config/nixpkgs/config.nix

RUN touch .bash_profile \
 && /dependencies/nix/install --no-daemon

CMD /bin/bash -l
