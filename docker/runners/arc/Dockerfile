# DinD-enabled ARC runner base image (includes dockerd + runner wiring)
FROM ghcr.io/actions/actions-runner-controller/actions-runner-dind:latest

USER root

# Install kubectl
RUN curl -sSL -o /usr/local/bin/kubectl "https://dl.k8s.io/release/$(curl -sSL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x /usr/local/bin/kubectl

# Useful tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    jq \
    unzip \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Verify installs (no argocd)
RUN kubectl version --client && echo "Runner DinD image ready"

USER runner

# Prepare kube dir if you mount kubeconfig secrets for jobs
RUN mkdir -p /home/runner/.kube
