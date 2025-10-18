# Rotas Logistics App - Azure DevOps Module 6 Project

## 📋 Project Overview
This project demonstrates **Docker-based deployment** for Rotas Inc., a logistics company that needs to scale their website based on traffic load. The application is built using ASP.NET Core and containerized with Docker for scalable deployment.

## ✅ What We've Completed

### 1. **ASP.NET Core Application**
- ✅ Created `RotasLogisticsApp` using ASP.NET Core 9.0
- ✅ Web application with Pages, Controllers, and Views
- ✅ Responsive design with Bootstrap
- ✅ Local testing at `http://localhost:5000`

### 2. **Docker Support**
- ✅ Added `Dockerfile` for multi-stage containerization
- ✅ Created `.dockerignore` to exclude unnecessary files
- ✅ Docker image builds successfully: `rotas-logistics-app:latest`
- ✅ Container runs and listens on port 80

### 3. **GitHub Repository**
- ✅ Code pushed to: `https://github.com/patilprem21/rotas-logistics-app`
- ✅ All files committed with proper Git history
- ✅ Repository includes Docker files and documentation

### 4. **Docker Containerization**
- ✅ **Docker Build**: `docker build -t rotas-logistics-app:latest .`
- ✅ **Docker Run**: `docker run -p 8080:80 rotas-logistics-app:latest`
- ✅ **Container Status**: Successfully running with port mapping
- ✅ **Multi-stage build**: Optimized for production deployment

## 🚧 What's Not Completed (Requires Azure Subscription)

### 1. **Azure Container Registry (ACR)**
- ❌ **Reason**: No active Azure subscription
- ❌ **What's needed**: Azure subscription to create ACR
- ❌ **Alternative**: Can use Docker Hub (free) for container registry

### 2. **Azure DevOps Pipeline**
- ❌ **Reason**: No Azure subscription for Azure DevOps
- ❌ **What's needed**: Azure subscription to create pipelines
- ❌ **Alternative**: GitHub Actions (free) for CI/CD

## 🛠️ How to Complete the Full Assignment

### **Prerequisites**
1. **Azure Subscription** (Free tier available)
2. **Azure CLI** installed locally
3. **Docker Desktop** (if running locally)

### **Step 1: Create Azure Container Registry**
```bash
# Login to Azure
az login

# Create resource group
az group create --name rotas-logistics-rg --location eastus

# Create Azure Container Registry
az acr create --resource-group rotas-logistics-rg --name rotaslogisticsregistry --sku Basic --admin-enabled true

# Login to ACR
az acr login --name rotaslogisticsregistry
```

### **Step 2: Build and Push to ACR**
```bash
# Build image for ACR
docker build -t rotaslogisticsregistry.azurecr.io/rotas-logistics-app:latest .

# Push to ACR
docker push rotaslogisticsregistry.azurecr.io/rotas-logistics-app:latest
```

### **Step 3: Create Azure DevOps Pipeline**
1. **Go to Azure DevOps**: `https://dev.azure.com`
2. **Create new project**: "Rotas-Logistics"
3. **Create pipeline**:
   - Source: GitHub repository
   - Template: ASP.NET Core with Docker
   - Configure for Azure Container Registry

### **Step 4: Pipeline YAML Configuration**
```yaml
trigger:
- main

pool:
  vmImage: 'ubuntu-latest'

variables:
  containerRegistry: 'rotaslogisticsregistry.azurecr.io'
  dockerRepository: 'rotas-logistics-app'
  dockerImageTag: '$(Build.BuildId)'

stages:
- stage: Build
  displayName: Build and push stage
  jobs:
  - job: Build
    displayName: Build
    steps:
    - task: Docker@2
      displayName: Build and push an image to container registry
      inputs:
        command: buildAndPush
        repository: $(dockerRepository)
        dockerfile: '**/Dockerfile'
        containerRegistry: $(dockerRegistryServiceConnection)
        tags: |
          $(dockerImageTag)
          latest
```

## 🐳 Docker Commands Reference

### **Build Commands**
```bash
# Build Docker image
docker build -t rotas-logistics-app:latest .

# Build for specific platform
docker build --platform linux/amd64 -t rotas-logistics-app:latest .
```

### **Run Commands**
```bash
# Run container locally
docker run -p 8080:80 rotas-logistics-app:latest

# Run in background
docker run -d -p 8080:80 --name rotas-app rotas-logistics-app:latest

# Stop container
docker stop rotas-app
```

### **Container Management**
```bash
# List running containers
docker ps

# List all containers
docker ps -a

# View container logs
docker logs <container-id>

# Remove container
docker rm <container-id>

# Remove image
docker rmi rotas-logistics-app:latest
```

## 📁 Project Structure
```
RotasLogisticsApp/
├── Pages/                    # Razor Pages
│   ├── Index.cshtml         # Home page
│   ├── Privacy.cshtml      # Privacy page
│   └── Shared/             # Shared layouts
├── wwwroot/                 # Static files
│   ├── css/                # Stylesheets
│   ├── js/                 # JavaScript
│   └── lib/                # Third-party libraries
├── Properties/              # Configuration
│   └── launchSettings.json
├── Dockerfile              # Docker configuration
├── .dockerignore           # Docker ignore file
├── Program.cs              # Application entry point
├── RotasLogisticsApp.csproj # Project file
└── README.md               # This file
```

## 🎯 Assignment Requirements Status

| Requirement | Status | Notes |
|-------------|--------|-------|
| Create ASP.NET Core app | ✅ Complete | RotasLogisticsApp created |
| Enable Docker support | ✅ Complete | Dockerfile and .dockerignore added |
| Create Azure Container Registry | ❌ Pending | Requires Azure subscription |
| Check in to Azure Repos | ✅ Complete | Pushed to GitHub |
| Create Azure Pipeline | ❌ Pending | Requires Azure subscription |

## 🚀 Next Steps for Full Completion

1. **Get Azure Subscription**: Sign up for free Azure account
2. **Create ACR**: Follow Step 1 commands above
3. **Push to ACR**: Follow Step 2 commands above
4. **Create Pipeline**: Follow Step 3 and 4 above
5. **Test Deployment**: Verify end-to-end deployment

## 📞 Support

For questions about this project:
- **GitHub Issues**: Create issue in repository
- **Documentation**: Check Azure DevOps documentation
- **Docker**: Refer to Docker official documentation

---

**Project Created**: January 2025  
**Technology Stack**: ASP.NET Core 9.0, Docker, Azure DevOps  
**Assignment**: Azure DevOps Module 6 - Implementing Deployment Models and Services
