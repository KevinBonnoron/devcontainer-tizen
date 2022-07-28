# 18-bullseye, 16-bullseye, 14-bullseye, 18-buster, 16-buster, 14-buster
ARG VARIANT=16-bullseye
ARG KEYRING_PASSWORD=password
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:${VARIANT}

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
 && apt-get install -y dbus-x11 gnome-keyring \
 && rm -rf /var/lib/apt/lists/*

RUN dbus-launch --sh-syntax \
 && mkdir -p ~/.cache \
 && mkdir -p ~/.local/share/keyrings \
 && dbus-run-session -- bash \
 && echo "${KEYRING_PASSWORD}" | gnome-keyring-daemon --unlock

USER node
RUN wget -O web-cli.bin https://download.tizen.org/sdk/Installer/tizen-studio_4.6/web-cli_Tizen_Studio_4.6_ubuntu-64.bin \
 && chmod +x web-cli.bin \
 && ./web-cli.bin --accept-license /home/node/tizen-studio
