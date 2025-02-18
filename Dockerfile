# Use lightweight Alpine as base
FROM alpine:latest

# Install dependencies: curl, unzip (for Vault), and rclone
RUN apk add --no-cache \
    curl \
    unzip \
    bash \
    ca-certificates

# Set Vault and Rclone versions
ARG VAULT_VERSION=1.17.6
ENV RCLONE_VERSION="1.69.0"

# Install Vault
RUN curl -fsSL -o /tmp/vault.zip "https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip" \
    && unzip /tmp/vault.zip -d /usr/local/bin/ \
    && chmod +x /usr/local/bin/vault \
    && rm -f /tmp/vault.zip

# Install Rclone
RUN curl -fsSL -o /tmp/rclone.zip "https://downloads.rclone.org/v${RCLONE_VERSION}/rclone-v${RCLONE_VERSION}-linux-amd64.zip" \
    && unzip /tmp/rclone.zip -d /tmp/ \
    && mv /tmp/rclone-*-linux-amd64/rclone /usr/local/bin/ \
    && chmod +x /usr/local/bin/rclone \
    && rm -rf /tmp/rclone*

# Default command: start a shell
CMD ["/bin/sh"]

