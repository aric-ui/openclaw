#!/bin/sh
# Auto-generate a gateway token for PaaS deployments if none is provided.
# This satisfies the auth requirement when binding to lan (0.0.0.0).
if [ -z "$OPENCLAW_GATEWAY_TOKEN" ] && [ -z "$OPENCLAW_GATEWAY_PASSWORD" ]; then
  export OPENCLAW_GATEWAY_TOKEN=$(node -e "process.stdout.write(require('crypto').randomBytes(24).toString('hex'))")
  echo "Auto-generated OPENCLAW_GATEWAY_TOKEN for PaaS deployment"
fi
exec "$@"
