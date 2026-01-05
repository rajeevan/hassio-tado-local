ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base-python:3.14-alpine3.23
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install tzdata and wget for downloading (Python is already included in base-python image)
RUN \
    apk add --no-cache \
        tzdata \
        wget \
        tar

# Download tado_local source tarball from GitHub (auto-mode-schedule branch)
RUN \
    wget -q -O /tmp/tado_local.tar.gz \
        https://github.com/rajeevan/TadoLocal/archive/refs/heads/auto-mode-schedule.tar.gz && \
    tar -xzf /tmp/tado_local.tar.gz -C /tmp && \
    rm /tmp/tado_local.tar.gz

# Install dependencies first (if requirements.txt exists, install it separately for better caching)
RUN \
    if [ -f /tmp/TadoLocal-auto-mode-schedule/requirements.txt ]; then \
        pip3 install --no-cache-dir --break-system-packages \
            -r /tmp/TadoLocal-auto-mode-schedule/requirements.txt; \
    fi

# Install tado_local package from extracted source
RUN \
    pip3 install --no-cache-dir --break-system-packages \
        /tmp/TadoLocal-auto-mode-schedule && \
    rm -rf /tmp/TadoLocal-auto-mode-schedule

# Copy run script
COPY run.sh /
RUN chmod a+x /run.sh

# Run the startup script
CMD ["/run.sh"]
