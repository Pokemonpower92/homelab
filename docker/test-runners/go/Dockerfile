FROM golang:1.24

# Install common test tooling as root
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy test runner script
COPY run_test.shs.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run_test.shs.sh

# Set working directory
WORKDIR /workspace

# Switch to non-root user (golang image provides 'nobody' or create one)
USER 65534:65534

ENTRYPOINT ["run_test.shs.sh"]