#!/usr/bin/with-contenv bashio
# Home Assistant Add-on Run Script
# Maps Home Assistant addon options to environment variables

set -e

bashio::log.info "Starting VNC Browser addon..."

# Read configuration from Home Assistant options
if bashio::config.exists 'vnc_password'; then
    export VNC_PASSWORD=$(bashio::config 'vnc_password')
fi

if bashio::config.exists 'vnc_resolution'; then
    export VNC_RESOLUTION=$(bashio::config 'vnc_resolution')
fi

if bashio::config.exists 'starting_url'; then
    export STARTING_WEBSITE_URL=$(bashio::config 'starting_url')
fi

if bashio::config.exists 'auto_start_browser'; then
    export AUTO_START_BROWSER=$(bashio::config 'auto_start_browser')
fi

if bashio::config.exists 'browser_options'; then
    export BROWSER_OPTIONS=$(bashio::config 'browser_options')
fi

if bashio::config.exists 'auto_start_xterm'; then
    export AUTO_START_XTERM=$(bashio::config 'auto_start_xterm')
fi

if bashio::config.exists 'auto_start_window_manager'; then
    export AUTO_START_WM=$(bashio::config 'auto_start_window_manager')
fi

if bashio::config.exists 'auto_start_vnc'; then
    export AUTO_START_X11VNC=$(bashio::config 'auto_start_vnc')
fi

if bashio::config.exists 'auto_start_novnc'; then
    export AUTO_START_NOVNC=$(bashio::config 'auto_start_novnc')
fi

if bashio::config.exists 'auto_start_xvfb'; then
    export AUTO_START_XVFB=$(bashio::config 'auto_start_xvfb')
fi

if bashio::config.exists 'x11vnc_options'; then
    export X11VNC_OPTIONS=$(bashio::config 'x11vnc_options')
fi

if bashio::config.exists 'xvfb_options'; then
    export XVFB_OPTIONS=$(bashio::config 'xvfb_options')
fi

if bashio::config.exists 'wm_options'; then
    export WM_OPTIONS=$(bashio::config 'wm_options')
fi

if bashio::config.exists 'novnc_options'; then
    export NOVNC_OPTIONS=$(bashio::config 'novnc_options')
fi

if bashio::config.exists 'xterm_options'; then
    export XTERM_OPTIONS=$(bashio::config 'xterm_options')
fi

if bashio::config.exists 'enable_customization'; then
    export CUSTOMIZE=$(bashio::config 'enable_customization')
fi

# Map custom scripts directory to /config/vnc_browser/scripts
if [ -d "/config/vnc_browser/scripts" ]; then
    export CUSTOM_ENTRYPOINTS_DIR="/config/vnc_browser/scripts"
    echo "Custom scripts directory found: ${CUSTOM_ENTRYPOINTS_DIR}"
fi

bashio::log.info "Configuration loaded successfully"

# Execute the customizable entrypoint
exec /usr/local/bin/customizable_entrypoint.sh
