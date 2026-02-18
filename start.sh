#!/bin/bash
mkdir -p ~/.openclaw

# Create OpenClaw config with Telegram
cat > ~/.openclaw/openclaw.json << 'CONFIGEND'
{
  "channels": {
    "telegram": {
      "enabled": true,
      "dmPolicy": "open",
      "allowFrom": ["*"]
    }
  }
}
CONFIGEND

# Start the gateway
node dist/index.js gateway --allow-unconfigured
