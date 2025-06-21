# Dockerfile for custom GitHub Actions runner with K8s tools
FROM summerwind/actions-runner:latest

USER root

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl

# Install argocd CLI
RUN curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64 && \
    chmod +x /usr/local/bin/argocd

# Install additional useful tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    jq \
    unzip \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Verify installations
RUN kubectl version --client && \
    argocd version --client && \
    echo "Tools installed successfully"

# Switch back to runner user
USER runner

# Set up kubeconfig directory
RUN mkdir -p /home/runner/.kube
