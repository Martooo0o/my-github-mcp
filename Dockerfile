# Stage 1: just used to extract the binary
FROM ghcr.io/github/github-mcp-server:latest AS mcp-source

# Stage 2: our actual runtime image
FROM python:3.12-slim

COPY --from=mcp-source /github-mcp-server /usr/local/bin/github-mcp-server
RUN chmod +x /usr/local/bin/github-mcp-server

RUN pip install --no-cache-dir mcp-proxy==0.12.0

ENV PORT=8080
ENV GITHUB_PERSONAL_ACCESS_TOKEN=""

EXPOSE 8080
CMD ["mcp-proxy", "--port", "8080", "--host", "0.0.0.0", "--allow-origin", "*", "--", "/usr/local/bin/github-mcp-server", "stdio"]
