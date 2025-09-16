# Use the official Node.js image
FROM node:20

# Set the working directory
WORKDIR /workspace

# Install useful tools and Terraform
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    && wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip \
    && unzip terraform_1.6.0_linux_amd64.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform_1.6.0_linux_amd64.zip \
    && rm -rf /var/lib/apt/lists/*

# Install TypeScript, CDKTF, and Azure provider globally
RUN npm install -g typescript cdktf-cli @cdktf/provider-azurerm

# Keep the container running
CMD ["sleep", "infinity"]
