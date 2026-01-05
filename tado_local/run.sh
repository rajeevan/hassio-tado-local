#!/usr/bin/with-contenv bashio

# ==============================================================================
# Home Assistant Add-on: Tado Local
# ==============================================================================

set -e

bashio::log.info "Tado Local starting..."

# Get configuration options
BRIDGE_IP=$(bashio::config 'bridge_ip')
PIN=$(bashio::config 'pin')

# Validate required configuration
if [ -z "$BRIDGE_IP" ]; then
    bashio::log.error "bridge_ip is required but not set"
    exit 1
fi

if [ -z "$PIN" ]; then
    bashio::log.error "pin is required but not set"
    exit 1
fi

# Ensure config directory and tado_local subdirectory exist
mkdir -p /config/tado_local

# Log configuration
bashio::log.info "Starting Tado Local..."
bashio::log.info "Bridge IP: ${BRIDGE_IP}"
bashio::log.info "Database: /config/tado-local.db"

# Start tado_local with unbuffered output for real-time logs
# PYTHONUNBUFFERED=1 ensures logs appear immediately in Home Assistant
exec python3 -u -m tado_local \
    --state /config/tado-local.db \
    --bridge-ip "${BRIDGE_IP}" \
    --pin "${PIN}"
