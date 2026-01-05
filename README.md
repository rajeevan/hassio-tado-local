# Home Assistant Add-on: Tado Local

[![GitHub Release][releases-shield]][releases]
[![License][license-shield]](LICENSE)

Home Assistant add-on repository for [TadoLocal](https://github.com/rajeevan/TadoLocal) - a local REST API for managing TADO devices via the HomeKit bridge.

## About

This repository provides a Home Assistant add-on that runs the TadoLocal project, enabling local control of TADO devices without cloud dependencies. The add-on communicates directly with your TADO bridge using the HomeKit protocol.

## Features

- 🏠 **Local Control**: No cloud dependency - all communication happens on your local network
- 🔌 **REST API**: Full REST API for integration with Home Assistant and other platforms
- 📊 **Real-time Updates**: Server-Sent Events (SSE) for real-time device state
- 🌐 **Web Interface**: Accessible via Home Assistant Ingress
- 💾 **Persistent Storage**: State stored in Home Assistant's config directory
- 🐳 **Multi-Architecture**: Supports both amd64 and arm64 platforms

## Installation

1. In Home Assistant, go to **Settings** > **Add-ons** > **Add-on Store**
2. Click the three dots (⋮) in the top right corner
3. Select **Repositories**
4. Add this repository URL: `https://github.com/rajeevan/hassio-tado-local`
5. Click **Add**
6. Find "Tado Local" in the Add-on Store and install it

## Configuration

The add-on requires two configuration options:

- **bridge_ip**: IP address of your TADO bridge on the local network
- **pin**: HomeKit pairing PIN (format: XXX-XX-XXX, found on the bottom of your bridge)

## Usage

### Web Interface

Access the web interface via Home Assistant Ingress:
- Click **Open Web UI** in the add-on panel
- Or use the **Ingress** link

The web interface provides:
- Device status and control
- Interactive API documentation at `/docs`
- Real-time event stream at `/events`

### REST API

The add-on exposes a REST API accessible via Ingress. Key endpoints:

- `GET /api/v1/zones` - List all zones
- `GET /api/v1/zones/{zone_id}` - Get zone details
- `POST /api/v1/zones/{zone_id}/set_temperature` - Set temperature
- `GET /api/v1/status` - Get system status

See the interactive API documentation at `/docs` for complete endpoint details.

## Architecture

```
┌─────────────────┐
│  Tado Bridge    │ ←─── HomeKit Protocol (local)
│  (HomeKit)      │
└────────┬────────┘
         │
         ↓
┌─────────────────┐
│  Tado Local     │ ←─── This Add-on
│  (REST API)     │
└────────┬────────┘
         │
         ├──→ Home Assistant Ingress (port 4407)
         └──→ SQLite Database (/config/tado_local/tado-local.db)
```

## Development

### Building

The add-on uses GitHub Actions to automatically build and push Docker images for both amd64 and arm64 architectures.

Images are pushed to Docker Hub:
- `rjeevan/tado_local:latest` - Latest build from main branch
- `rjeevan/tado_local:{version}` - Tagged releases (e.g., v1.0.0)

### Local Testing

To test the add-on locally:

1. Clone this repository
2. Build the Docker image:
   ```bash
   docker build -t tado_local:test -f tado_local/Dockerfile --build-arg BUILD_FROM=ghcr.io/home-assistant/amd64-base-python:latest tado_local/
   ```
3. Run the container with proper volume mounts

## Repository Structure

```
hassio-tado-local/
├── .github/
│   └── workflows/
│       └── build.yml          # CI/CD pipeline
├── tado_local/
│   ├── config.json            # Add-on configuration
│   ├── Dockerfile             # Docker image definition
│   ├── run.sh                 # Startup script
│   └── README.md              # Add-on documentation
├── repository.json            # Repository metadata
└── README.md                  # This file
```

## Requirements

- Home Assistant (Supervised, OS, or Container installation)
- TADO bridge device on your local network
- HomeKit pairing PIN from your TADO bridge

## Support

- **Issues**: [GitHub Issues](https://github.com/rajeevan/hassio-tado-local/issues)
- **TadoLocal Project**: [GitHub Repository](https://github.com/rajeevan/TadoLocal)

## License

Apache License 2.0 - see [LICENSE](LICENSE) file for details.

[releases-shield]: https://img.shields.io/github/release/rajeevan/hassio-tado-local.svg
[releases]: https://github.com/rajeevan/hassio-tado-local/releases
[license-shield]: https://img.shields.io/github/license/rajeevan/hassio-tado-local.svg
