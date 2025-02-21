#!/bin/bash

# Definição de cores
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
MAGENTA='\e[35m'
CYAN='\e[36m'
RESET='\e[0m'

echo -e "${CYAN}🔄 Atualizando pacotes do sistema...${RESET}"
sudo apt update && sudo apt upgrade -y

echo -e "${GREEN}🛠️ Instalando pacotes básicos...${RESET}"
sudo apt install -y curl wget git unzip build-essential software-properties-common

echo -e "${YELLOW}📦 Instalando Node.js e npm (última versão)...${RESET}"
if [ ! -f /etc/apt/sources.list.d/nodesource.list ]; then
    curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
else
    echo -e "${BLUE}Arquivo de lista do Node.js já existe. Pulando criação do arquivo...${RESET}"
fi
sudo apt install -y nodejs

echo -e "${CYAN}🐳 Instalando Docker e Docker Compose (última versão)...${RESET}"
if [ ! -f /etc/apt/sources.list.d/docker.list ]; then
    curl -fsSL https://get.docker.com | sudo bash
else
    echo -e "${BLUE}Arquivo de lista do Docker já existe. Pulando criação do arquivo...${RESET}"
fi
sudo usermod -aG docker $USER
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K[^"]+')
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo -e "${MAGENTA}🍃 Instalando MongoDB 8.0 Community Edition...${RESET}"
sudo apt-get install -y gnupg curl
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor
if [ ! -f /etc/apt/sources.list.d/mongodb-org-8.0.list ]; then
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
else
    echo -e "${BLUE}Arquivo de lista do MongoDB já existe. Pulando criação do arquivo...${RESET}"
fi
sudo apt-get update
sudo apt-get install -y mongodb-org

echo -e "${GREEN}📝 Instalando VS Code (última versão)...${RESET}"
if [ ! -f /etc/apt/sources.list.d/vscode.list ]; then
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
else
    echo -e "${BLUE}Arquivo de lista do VS Code já existe. Pulando criação do arquivo...${RESET}"
fi
sudo apt update
sudo apt install -y code

echo -e "${CYAN}🐧 Instalando DBeaver (última versão via snap)...${RESET}"
sudo snap install dbeaver-ce

echo -e "${MAGENTA}🟢 Instalando MongoDB Compass (última versão)...${RESET}"
COMPASS_URL=$(curl -s https://www.mongodb.com/try/download/compass | grep -oP 'https://downloads.mongodb.com/compass/mongodb-compass_.*?_amd64.deb' | head -1)
wget -O mongodb-compass.deb "$COMPASS_URL"
sudo chmod 644 mongodb-compass.deb
sudo chown _apt:root mongodb-compass.deb
sudo apt install -y ./mongodb-compass.deb
rm mongodb-compass.deb

echo -e "${GREEN}✅ Instalação concluída com sucesso!${RESET}"
