FROM ubuntu:latest

# https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#in-a-container
RUN apt update 
RUN apt -y install curl xz-utils sudo git vim

RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux \
  --extra-conf "sandbox = false" \
  --init none \
  --no-confirm
ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"

RUN git config --global --add safe.directory /code
