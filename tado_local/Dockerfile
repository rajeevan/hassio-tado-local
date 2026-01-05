ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:latest
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Python, pip, and git
RUN \
    apk add --no-cache \
        python3 \
        py3-pip \
        py3-setuptools \
        git \
        tzdata

# Install tado_local from GitHub (auto-mode-schedule branch)
RUN pip3 install --no-cache-dir --break-system-packages \
    git+https://github.com/rajeevan/TadoLocal.git@auto-mode-schedule

# Copy run script
COPY run.sh /
RUN chmod a+x /run.sh

# Run the startup script
CMD ["/run.sh"]
