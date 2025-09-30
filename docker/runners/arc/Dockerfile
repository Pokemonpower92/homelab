FROM ghcr.io/actions-runner-controller/actions-runner-controller/actions-runner-dind:v2.328.0-ubuntu-20.04-0e006bb

USER root

RUN curl -sSL -o /usr/local/bin/kubectl "https://dl.k8s.io/release/$(curl -sSL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x /usr/local/bin/kubectl

RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash && \
    mv kustomize /usr/local/bin/kustomize && \
    chmod +x /usr/local/bin/kustomize

RUN apt-get update && apt-get install -y \
    git \
    curl \
    jq \
    unzip \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN kubectl version --client && echo "Runner DinD image ready"

USER runner

RUN mkdir -p /home/runner/.kube

