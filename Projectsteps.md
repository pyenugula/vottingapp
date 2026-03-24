# 🚀 End-to-End CI/CD for Microservices on AKS with Azure DevOps & GitOps

![Azure DevOps](https://img.shields.io/badge/Azure%20DevOps-Pipelines-blue?logo=azuredevops)
![Terraform](https://img.shields.io/badge/Terraform-Infrastructure%20as%20Code-orange?logo=terraform)
![Docker](https://img.shields.io/badge/Docker-Containers-lightblue?logo=docker)
![AKS](https://img.shields.io/badge/AKS-Kubernetes-green?logo=kubernetes)
![Argo CD](https://img.shields.io/badge/Argo%20CD-GitOps-red?logo=argoproj)

---

## **Project Title**
**Automated CI/CD for Microservices on Azure Kubernetes Service (AKS) Using Azure DevOps and Argo CD**

---

## **Problem Statement**
Manual deployments for microservices were:

- Error-prone and inconsistent  
- Slowing delivery cycles  
- Difficult to scale  

This project implements a **fully automated CI/CD and GitOps workflow**, ensuring reliable, repeatable, and scalable deployments on **AKS**.

---

## **Solution Overview**
This project demonstrates the complete CI/CD lifecycle:

### **1️⃣ Azure DevOps Organisation & Project**
- Created organisation `MyCompanyOrg` and project `VotingAppProject`  
- Configured **Azure Repos** and imported [example-voting-app](https://github.com/dockersamples/example-voting-app)

### **2️⃣ CI Pipelines for Microservices**
- Microservices: `vote`, `worker`, `results`  
- Pipelines build Docker images, tag them with build numbers, and push to **Azure Container Registry (ACR)**  
- Optional **self-hosted agents** for faster builds  

### **3️⃣ Terraform AKS Pipeline**
- Provisioned **AKS cluster** using Terraform  
- Stored Azure credentials securely in pipeline variables  
- Infrastructure is **repeatable and scalable**

### **4️⃣ GitOps Deployment via Argo CD**
- Installed Argo CD on AKS  
- CI pipelines update Kubernetes manifests automatically with new Docker image tags  
- Argo CD automatically deploys changes to AKS  

### **5️⃣ Automated Triggers**
- CI pipelines trigger on code changes  
- GitOps pipelines deploy automatically when manifests are updated  

---

**Workflow Summary:**  

1. Developers commit code to **Azure Repos**  
2. CI pipelines build Docker images → push to **ACR**  
3. Terraform provisions **AKS cluster**  
4. Deployment stage updates Kubernetes manifests with new image tags  
5. Argo CD synchronises changes automatically to AKS  

---

## **Pipeline Prerequisites & Variables**
Before running pipelines, configure the following **variables and secrets**:

| Variable / Secret | Value / Example | Scope / Purpose | Type |
|------------------|----------------|----------------|------|
| `dockerRegistryServiceConnection` | `acr-service-connection` | Connects Azure DevOps pipeline to ACR for pushing Docker images | Service Connection |
| `imageRepository` | `vote` / `worker` / `results` | Docker repository name per microservice | Pipeline Variable |
| `dockerfilePath` | `vote/Dockerfile` / `worker/Dockerfile` / `results/Dockerfile` | Path to Dockerfile for building the image | Pipeline Variable |
| `tag` | `$(Build.BuildId)` | Unique build number for tagging Docker images | Pipeline Variable |
| `k8sNamespace` | `default` | Kubernetes namespace where the microservice will be deployed | Pipeline Variable |
| `argoCDServer` | `<ARGOCD_SERVER_URL>` | Argo CD API server URL for syncing applications | Pipeline Variable |
| `argoCDUsername` | `admin` | Username for Argo CD login | Pipeline Variable / Secret |
| `argoCDPassword` | `<your-secret>` | Password for Argo CD login | Secret |
| `terraformServiceConnection` | `azure-rm-service-connection` | Azure subscription connection for Terraform provisioning AKS | Service Connection |
| `acr-secret` (K8s) | `<docker credentials>` | Kubernetes secret for AKS to pull Docker images from ACR | Kubernetes Secret |

**Implementation Notes:**
1. Use **Variable Groups** in Azure DevOps to manage these variables for all pipelines.  
2. Keep sensitive variables (`argoCDPassword`, ACR credentials) as **secrets**.  
3. Ensure AKS can pull Docker images using `acr-secret`:

```yaml
spec:
  template:
    spec:
      imagePullSecrets:
        - name: acr-secret

