#!/bin/bash
mkdir -p ~/.openclaw
echo '{"channels":{"telegram":{"enabled":true,"dmPolicy":"open","allowFrom":["*"]}}}' > ~/.openclaw/openclaw.json
node dist/index.js gateway --allow-unconfigured
