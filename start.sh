#!/bin/bash
mkdir -p ~/.openclaw

# Create OpenClaw config with Telegram and CRM MCP server
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
}
CONFIGEND

# Replace environment variable in config
sed -i "s|\${CRM_MCP_API_KEY}|$CRM_MCP_API_KEY|g" ~/.openclaw/openclaw.json

# Start the gateway
node dist/index.js gateway --allow-unconfigured
