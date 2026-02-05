FROM node:22-bookworm

# Install Bun (required for build scripts)
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:${PATH}"

RUN corepack enable

WORKDIR /app

ARG OPENCLAW_DOCKER_APT_PACKAGES=""
RUN if [ -n "$OPENCLAW_DOCKER_APT_PACKAGES" ]; then \
      apt-get update && \
      DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends $OPENCLAW_DOCKER_APT_PACKAGES && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*; \
    fi

COPY package.json pnpm-lock.yaml pnpm-workspace.yaml .npmrc ./
COPY ui/package.json ./ui/package.json
COPY patches ./patches
COPY scripts ./scripts

RUN pnpm install --frozen-lockfile

COPY . .
RUN OPENCLAW_A2UI_SKIP_MISSING=1 pnpm build
# Force pnpm for UI build (Bun may fail on ARM/Synology architectures)
ENV OPENCLAW_PREFER_PNPM=1
RUN pnpm ui:build

ENV NODE_ENV=production

# Entrypoint: auto-generates gateway token for PaaS if not provided.
RUN chmod +x /app/docker-entrypoint.sh

# Allow non-root user to write temp files during runtime/tests.
RUN chown -R node:node /app

# Security hardening: Run as non-root user
# The node:22-bookworm image includes a 'node' user (uid 1000)
# This reduces the attack surface by preventing container escape via root privileges
USER node

# Point to workspace config (e.g. workspace/818 deployment).
# Can be overridden via OPENCLAW_CONFIG_PATH env var at runtime.
ENV OPENCLAW_CONFIG_PATH="/app/workspace/818/clawdbot.json"

ENTRYPOINT ["/app/docker-entrypoint.sh"]

# Start gateway server with default config.
# PaaS environments (Railway, Render) are auto-detected via PORT env var:
# bind defaults to lan (0.0.0.0) and port to $PORT.
CMD ["node", "dist/index.js", "gateway", "--allow-unconfigured"]
