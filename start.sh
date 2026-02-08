#!/bin/bash

# Create config directory
mkdir -p ~/.openclaw

# Create config file with open Telegram access
cat > ~/.openclaw/openclaw.json << 'EOF'
{
  "channels": {
      "telegram": {
            "enabled": true,
                  "dmPolicy": "open",
                        "allowFrom": ["*"]
                            }
                              }
                              }
                              EOF

                              # Start the gateway
                              node dist/index.js gateway
