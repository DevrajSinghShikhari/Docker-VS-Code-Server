# Docker VS-Code Server

A containerized development environment that allows you to access VS Code via any web browser. This setup runs locally on your computer (Windows, macOS, or Linux) using Docker, ensuring an isolated, secure, and reproducible workspace.

## Features
- **Browser-based IDE:** Access full VS Code features from any standard browser.
- **Isolated Workspace:** All changes stay safely tracked within a dedicated directory.
- **Password Protection:** Controlled secure entry out of the box.
- **Cross-Platform:** Runs identically on Windows, Mac, and Linux.

---

## 1. Prerequisites (Dependency Installation)

Before downloading the repository, make sure your operating system has **Git** and **Docker** installed.

### 🌐 Windows
1. Download and install [Git for Windows](https://git-scm.com).
2. Download and install [Docker Desktop](https://docker.com). 
   > *Note: Make sure to enable the WSL 2 backend during installation if prompted.*

### 🍏 macOS
1. Open your terminal and install Git via Homebrew (`brew install git`) or install [Xcode Command Line Tools](https://apple.com).
2. Download and install [Docker Desktop for Mac](https://docker.com). Ensure you select the correct version for your chip (**Intel** or **Apple Silicon M1/M2/M3**).

### 🐧 Linux (Ubuntu/Debian example)
Open your terminal and run the following commands to install Git and Docker Engine:
```bash
# Update package list and install Git
sudo apt update
sudo apt install -y git curl

# Install Docker Engine
curl -fsSL https://docker.com -o get-docker.sh
sudo sh get-docker.sh

# Allow your user to run Docker commands without sudo (Optional but recommended)
sudo usermod -aG docker $USER
```
*(Log out and log back in for user group changes to take effect).*

---

## 2. Installation & Setup

Follow these steps to clone the project, configure your access, and launch your VS Code environment.

### Step 1: Clone the Repository
Open your command prompt or terminal and download the repository:
```bash
git clone https://github.com/DevrajSinghShikhari/Docker-VS-Code-Server.git
cd Docker-VS-Code-Server
```

### Step 2: Build the Docker Image
Compile the custom container image using the included Dockerfile:
```bash
docker build -t local-vscode .
```

### Step 3: Launch the Container
Run the container locally. You can customize your access port and secure password inline:

```bash
docker run -d \
  -p 8080:8080 \
  -e PORT=8080 \
  -e PASSWORD="YourSecurePasswordHere" \
  -v $(pwd)/project:/home/coder/project \
  --name my-vscode-server \
  local-vscode
```

> **Windows PowerShell Users:** If you are using PowerShell, replace `$(pwd)` with `${PWD}` to link your local workspace folder correctly:
> ```powershell
> docker run -d -p 8080:8080 -e PORT=8080 -e PASSWORD="YourSecurePasswordHere" -v ${PWD}/project:/home/coder/project --name my-vscode-server local-vscode
> ```

---

## 3. How to Access

1. Open any web browser on your computer.
2. Navigate to: `http://localhost:8080`
3. Enter the **PASSWORD** you declared in the startup command (`YourSecurePasswordHere`).
4. Any files you edit inside the `/project` folder will instantly save inside the `project/` directory on your local machine!

## Stopping and Restarting

- **To Stop the server:** `docker stop my-vscode-server`
- **To Start it again:** `docker start my-vscode-server`
- **To Remove it completely:** `docker rm -f my-vscode-server`
