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
  },
  "mcpServers": {
    "crm": {
      "transport": "http",
      "url": "https://xydwuivujuutoigmqeaj.supabase.co/functions/v1/mcp-server",
      "headers": {
        "x-api-key": "${CRM_MCP_API_KEY}"
      }
    }
  }
}
CONFIGEND

# Replace environment variable in config
sed -i "s|\${CRM_MCP_API_KEY}|$CRM_MCP_API_KEY|g" ~/.openclaw/openclaw.json

# Start the gateway
node dist/index.js gateway --allow-unconfigured
