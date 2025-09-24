# Use the official Node.js image
FROM node:20

# Set the working directory
WORKDIR /workspace

# Install useful tools and dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    ca-certificates \
    gnupg \
    lsb-release \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user
ARG USERNAME=node
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Add sudo support for the node user
RUN echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Switch to node user for installations
USER $USERNAME

# Install Terraform
RUN sudo wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip \
    && sudo unzip terraform_1.6.0_linux_amd64.zip \
    && sudo mv terraform /usr/local/bin/ \
    && sudo rm terraform_1.6.0_linux_amd64.zip

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Bicep CLI
RUN sudo curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64 \
    && sudo chmod +x ./bicep \
    && sudo mv ./bicep /usr/local/bin/bicep

# Install TypeScript, CDKTF, and Azure provider globally
RUN sudo npm install -g typescript cdktf-cli @cdktf/provider-azurerm

# Ensure proper ownership of the workspace
RUN sudo chown -R $USERNAME:$USERNAME /workspace

# Keep the container running
CMD ["sleep", "infinity"]
