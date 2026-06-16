FROM ghcr.io/github/github-mcp-server:latest

RUN apk add --no-cache python3 py3-pip && pip3 install mcp-proxy --break-system-packages

EXPOSE 8080
CMD ["mcp-proxy", "--port", "8080", "--host", "0.0.0.0", "--allow-origin", "*", "--", "/github-mcp-server", "stdio"]
