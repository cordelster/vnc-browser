# VNC Browser Add-on Documentation

## Configuration Options

### VNC Configuration

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `vnc_password` | password | `money4band` | Password required to access the VNC server |
| `vnc_resolution` | string | `1280x720` | Display resolution (format: WIDTHxHEIGHT) |

### Browser Configuration

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `starting_url` | url | `https://www.google.com` | Initial webpage to load when browser starts |
| `auto_start_browser` | bool | `true` | Automatically launch Firefox on startup |
| `browser_options` | string | `""` | Additional Firefox command-line options (e.g., `--kiosk` for fullscreen) |

### Display Configuration

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `auto_start_xterm` | bool | `true` | Automatically launch xterm terminal emulator |
| `auto_start_window_manager` | bool | `true` | Automatically launch Fluxbox window manager |

### Advanced VNC Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `auto_start_vnc` | bool | `true` | Automatically start x11vnc server (port 5900) |
| `auto_start_novnc` | bool | `true` | Automatically start noVNC for web access (port 6080) |
| `auto_start_xvfb` | bool | `true` | Automatically start Xvfb virtual display (required) |
| `x11vnc_options` | string | `""` | Additional x11vnc command-line options |
| `xvfb_options` | string | `""` | Additional Xvfb command-line options |
| `wm_options` | string | `""` | Additional Fluxbox command-line options |
| `novnc_options` | string | `""` | Additional noVNC/websockify options |
| `xterm_options` | string | `""` | Additional xterm command-line options |

### Customization

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `enable_customization` | bool | `false` | Enable execution of custom scripts from `/config/vnc_browser/scripts/` |

## Access Methods

### Web Browser (noVNC)
Access the VNC environment through your web browser:
- **Via Home Assistant UI**: Click "OPEN WEB UI" button
- **Direct Access**: `http://homeassistant.local:6080`

### VNC Client
Connect using a traditional VNC client application:
- **Host**: Your Home Assistant IP address
- **Port**: `5900`
- **Password**: Your configured VNC password

## Common Use Cases

### Isolated Web Browsing
Secure, containerized browser for accessing untrusted sites or testing:
```yaml
vnc_password: "secure_password"
vnc_resolution: "1920x1080"
starting_url: "https://www.google.com"
browser_options: "--private-window"
```

### Fullscreen Kiosk Display
Display external content in fullscreen mode:
```yaml
vnc_password: "secure_password"
vnc_resolution: "1920x1080"
starting_url: "https://example.com"
browser_options: "--kiosk"
auto_start_xterm: false
```

### Custom Automation
Run custom scripts on startup:
```yaml
enable_customization: true
```

Then place `.sh` or `.py` scripts in `/config/vnc_browser/scripts/`. Scripts execute in alphabetical order.

## Custom Scripts

When `enable_customization` is enabled:

1. **Create the scripts directory**:
   - Using File Editor addon or Samba, create folder: `/config/vnc_browser/scripts/`

2. **Add your scripts**:
   - Place `.sh` (bash) or `.py` (Python) files in this directory
   - Scripts must have proper shebang:
     - Bash: `#!/bin/bash`
     - Python: `#!/usr/bin/env python3`
   - Make scripts executable (if using SSH): `chmod +x /config/vnc_browser/scripts/script.sh`

3. **Execution**:
   - Scripts run in alphabetical order during addon startup
   - Check addon logs for script output and errors

**Example script** (`/config/vnc_browser/scripts/01-example.sh`):
```bash
#!/bin/bash
echo "Custom script running!"
# Your automation here
```

## Known Issues

### Ingress with TLS
When accessing the addon through Home Assistant Ingress on systems with TLS/HTTPS enabled, noVNC may display "Something went wrong, connection is closed" error.

**Workaround**: Access the addon directly via port 6080 instead of through Ingress:
- Direct URL: `http://homeassistant.local:6080` (or use your HA IP address)
- This bypasses the TLS/websocket issue with Ingress

**Root Cause**: WebSocket connection incompatibility between noVNC and Home Assistant Ingress over TLS. Direct port access uses unencrypted WebSocket which works correctly.

**Status**: Known issue, fix planned for future release.

## Troubleshooting

### Container won't start
Check addon logs via:
- **UI**: Settings → Add-ons → VNC Browser → Log tab
- **CLI**: `ha addons logs local_vnc_browser`

### Black screen in noVNC
Ensure all required services are enabled:
- `auto_start_xvfb: true` (required)
- `auto_start_vnc: true` (required)
- `auto_start_novnc: true` (required)

### Browser doesn't open
Check that:
- `auto_start_browser: true`
- `auto_start_window_manager: true` (provides window controls)

### Custom scripts not running
Verify:
- `enable_customization: true`
- Scripts are in `/config/vnc_browser/scripts/`
- Scripts have proper shebang (`#!/bin/bash` or `#!/usr/bin/env python3`)
- Scripts are executable (check permissions)
- Check addon logs for script execution errors

## Support

For issues, questions, or contributions:
- **Repository**: https://github.com/cordelster/vnc-browser
- **Issues**: https://github.com/cordelster/vnc-browser/issues

- **Credit/Upstream**: https://github.com/MRColorR/vnc-browser

## License

GPL 3.0 - See LICENSE file for details
