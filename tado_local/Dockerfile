ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-python:latest
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install tzdata (Python is already included in base-python image)
RUN \
    apk add --no-cache \
        tzdata

# Install tado_local from GitHub (auto-mode-schedule branch)
# Download source tarball directly and install via pip (no git needed)
RUN \
    pip3 install --no-cache-dir --break-system-packages \
        https://github.com/rajeevan/TadoLocal/archive/refs/heads/auto-mode-schedule.tar.gz

# Copy run script
COPY run.sh /
RUN chmod a+x /run.sh

# Run the startup script
CMD ["/run.sh"]
