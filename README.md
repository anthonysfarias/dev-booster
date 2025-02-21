# 🚀 Instalação Automática de Ferramentas Dev

Este script instala automaticamente as ferramentas de desenvolvimento essenciais na versão mais recente disponível. Ele garante que todas as dependências sejam baixadas diretamente das fontes oficiais.

## 📌 Tecnologias Instaladas

- **Pacotes básicos**: `curl`, `wget`, `git`, `unzip`, `build-essential`, `software-properties-common`
- **Node.js e npm** (versão mais recente)
- **Docker e Docker Compose** (versão mais recente do GitHub)
- **MongoDB** (versão mais recente do repositório oficial)
- **Visual Studio Code** (versão mais recente do repositório oficial da Microsoft)
- **DBeaver** (versão mais recente do site oficial)
- **MongoDB Compass** (versão mais recente do site oficial)

## 🔧 Como Usar

### 1️⃣ Baixe o Script

Salve o seguinte script como `install-dev.sh`:

```bash
wget -O install-dev.sh https://raw.githubusercontent.com/seu-repo/install-dev/main/install-dev.sh
```

### 2️⃣ Conceda Permissão de Execução

```bash
chmod +x install-dev.sh
```

### 3️⃣ Execute o Script

```bash
./install-dev.sh
```

## 🚨 Possíveis Problemas e Soluções

### ❌ Erro: "Could not get lock /var/lib/dpkg/lock-frontend"

Esse erro ocorre quando outro processo está usando o `apt`. Para resolver:

```bash
sudo lsof /var/lib/dpkg/lock-frontend  # Verifique o processo que está segurando o lock
sudo kill -9 <PID_DO_PROCESSO>        # Substitua <PID_DO_PROCESSO> pelo número mostrado
sudo rm /var/lib/dpkg/lock-frontend    # Remova o arquivo de lock
sudo dpkg --configure -a               # Reconfigure pacotes pendentes
```

Em seguida, rode o script novamente.

## 🛠️ Personalização

Se precisar adicionar ou remover pacotes, edite o arquivo `install-dev.sh` e modifique os comandos conforme necessário.

## 📜 Licença

Este projeto está licenciado sob a **MIT License** - sinta-se livre para modificar e compartilhar! 🎉


