#!/bin/bash

# Definição de cores
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

echo -e "${YELLOW}🧹 Removendo pacotes do sistema...${RESET}"

# Atualiza a lista de pacotes
sudo apt update

# Verificando se o Node.js está instalado
if dpkg -l | grep -q nodejs; then
    echo -e "${RED}🚀 Removendo Node.js...${RESET}"
    sudo apt-get remove --purge -y nodejs
else
    echo -e "${YELLOW}Node.js não encontrado. Pulando remoção.${RESET}"
fi

# Verificando se o Docker e o Docker Compose estão instalados
if dpkg -l | grep -q docker; then
    echo -e "${RED}🐳 Removendo Docker...${RESET}"
    sudo apt-get remove --purge -y docker docker-engine docker.io docker-compose
    sudo apt-get autoremove -y
else
    echo -e "${YELLOW}Docker não encontrado. Pulando remoção.${RESET}"
fi

# Verificando se o MongoDB está instalado
if dpkg -l | grep -q mongodb-org; then
    echo -e "${RED}🌳 Removendo MongoDB...${RESET}"
    sudo apt-get remove --purge -y mongodb-org
    sudo apt-get autoremove -y
else
    echo -e "${YELLOW}MongoDB não encontrado. Pulando remoção.${RESET}"
fi

# Removendo arquivos de lista do MongoDB se existirem
if [ -f /etc/apt/sources.list.d/mongodb-org-8.0.list ]; then
    echo -e "${RED}Removendo lista de repositórios do MongoDB...${RESET}"
    sudo rm /etc/apt/sources.list.d/mongodb-org-8.0.list
else
    echo -e "${YELLOW}Arquivo de lista do MongoDB não encontrado. Pulando remoção.${RESET}"
fi

# Verificando se o VS Code está instalado
if dpkg -l | grep -q code; then
    echo -e "${RED}📝 Removendo VS Code...${RESET}"
    sudo apt-get remove --purge -y code
else
    echo -e "${YELLOW}VS Code não encontrado. Pulando remoção.${RESET}"
fi

# Verificando se o DBeaver está instalado (versão snap)
if snap list | grep -q dbeaver-ce; then
    echo -e "${RED}🐉 Removendo DBeaver...${RESET}"
    sudo snap remove dbeaver-ce
else
    echo -e "${YELLOW}DBeaver não encontrado. Pulando remoção.${RESET}"
fi

# Verificando se o MongoDB Compass está instalado
if dpkg -l | grep -q mongodb-compass; then
    echo -e "${RED}🟢 Removendo MongoDB Compass...${RESET}"
    sudo apt-get remove --purge -y mongodb-compass
else
    echo -e "${YELLOW}MongoDB Compass não encontrado. Pulando remoção.${RESET}"
fi

# Removendo pacotes adicionais
echo -e "${YELLOW}🧹 Limpando pacotes não necessários...${RESET}"
sudo apt-get autoremove -y
sudo apt-get clean

echo -e "${GREEN}✅ Remoção concluída com sucesso!${RESET}"

