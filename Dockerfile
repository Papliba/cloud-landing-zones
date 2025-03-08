# Base image with Ubuntu and minimal dependencies
FROM ubuntu:latest

# Set non-interactive mode to prevent installation prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update system and install necessary packages
RUN apt update && apt install -y \
    curl \
    git \
    unzip \
    ripgrep \
    neovim \
    zsh \
    fzf \
    build-essential \
    gnupg \
    software-properties-common \
    tmux \
    && rm -rf /var/lib/apt/lists/*

# Install Terraform
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
    && apt update && apt install -y terraform

# Verify Terraform installation
RUN terraform --version

# Install Oh My Zsh and plugins
RUN git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions

# Clone your dotfiles (includes .zshrc and .tmux.conf)
RUN git clone https://github.com/sunnybharne/dotfiles.git ~/dotfiles \
    && ln -sf ~/dotfiles/.zshrc ~/.zshrc \
    && ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# Set Zsh as the default shell
RUN chsh -s $(which zsh)

# Clone your Neovim configuration
RUN git clone https://github.com/sunnybharne/nvim.git /root/.config/nvim

# Set Neovim as the default editor
ENV EDITOR="nvim"

# Run Neovim once to install plugins
RUN nvim --headless "+Lazy! sync" +qa

# Set the working directory inside the container
WORKDIR /workspace
RUN mkdir -p /workspace

# Default command when container starts
CMD ["zsh"]
