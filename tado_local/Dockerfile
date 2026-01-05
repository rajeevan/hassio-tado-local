ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Python and pip
RUN \
    apk add --no-cache \
        python3 \
        py3-pip \
        py3-setuptools \
    && \
    python3 -m ensurepip --upgrade

# Install tado_local from GitHub (auto-mode-schedule branch)
RUN pip3 install --no-cache-dir \
    git+https://github.com/rajeevan/TadoLocal.git@auto-mode-schedule

# Copy run script
COPY run.sh /
RUN chmod a+x /run.sh

# Run the startup script
CMD ["/run.sh"]
