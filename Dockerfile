ARG STACK="typescript-node"
ARG VERSION="20"
# buster = Debian 10 | bullseye = Debian 11 | bookworm = Debian 12 | sid = Debian Unstable
ARG DEBIAN="bookworm"
FROM mcr.microsoft.com/devcontainers/${STACK}:1-${VERSION}-${DEBIAN}

ARG USERNAME=bruno
RUN useradd -ms /bin/bash $USERNAME && \
    echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME && \
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    apt-get update && apt-get install -y sudo && \
    mkdir /commandhistory && \
    touch /commandhistory/.bash_history && \
    chown -R $USERNAME /commandhistory && \
    chmod 0440 /etc/sudoers.d/$USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

COPY install_packages.sh .
RUN bash install_packages.sh && rm install_packages.sh
