ARG GITHUB_PERSONAL_ACCESS_TOKEN
# Download github-mcp-server binary directly from GitHub releases
FROM python:3.12-slim

# Install curl for downloading
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Download the latest github-mcp-server binary for linux/amd64
RUN curl -fsSL https://github.com/github/github-mcp-server/releases/latest/download/github-mcp-server_Linux_x86_64.tar.gz \
    | tar -xz -C /usr/local/bin github-mcp-server \
    && chmod +x /usr/local/bin/github-mcp-server

# Install mcp-proxy
RUN pip install --no-cache-dir mcp-proxy==0.12.0

ENV PORT=8080

EXPOSE 8080

CMD mcp-proxy \
    --port $PORT \
    --host 0.0.0.0 \
    --allow-origin "*" \
    -- \
    /usr/local/bin/github-mcp-server stdio
