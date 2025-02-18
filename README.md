# AWS DevOps Project – Automated Deployment with EKS, CI/CD and GitHub Actions
## Overview
This project demonstrates a **full DevOps pipeline** using **AWS EKS, Kubernetes, Docker, Terraform, and GitHub Actions** to deploy a **Node.js application** with security best practices and logging.
##Key Features
- **Automated CI/CD:** GitHub Actions deploys the app to AWS EKS.
- **Infrastructure as Code (IaC):** The EKS cluster is provisioned with AWS CloudFormation.
- **Containerized Deployment:** The application is containerized with Docker and stored in AWS ECR.
- **Scalability & Monitoring:** Kubernetes Autoscaling and AWS CloudWatch Logs for real-time monitoring.
- **Security Best Practices:**
  - **IAM Roles & Policies:** Follows the least privilege principle.
  - **AWS Secrets Manager:** Secures environment variables and sensitive data.
  - **CloudWatch & Grafana (Optional):** Logging and monitoring added to enhance security.

## Technologies Used
- **Cloud Provider:** AWS (EKS, ECR, IAM, CloudFormation, CloudWatch)
- **Container Orchestration:** Kubernetes (kubectl, eksctl)
- **CI/CD:** GitHub Actions
- **Infrastructure as Code (IaC):** CloudFormation
- **Containerization:** Docker
- **Programming Language:** Node.js
- **Monitoring & Logging:** AWS CloudWatch (Fluent Bit integration attempted but unsuccessful)
- **Security:** IAM roles, AWS Secrets Manager
  
## Prerequisites
Ensure you have installed the following before deploying this project
- **AWS CLI:** Configured with your IAM credentials
- **kubectl:** For interacting with Kubernetes clusters
- **eksctl:** For managing EKS clusters
- **Docker:** For containerizing applications
- **GitHub CLI (gh):** For managing repositories
- **Git:** For version control

## Deployment Steps
### 1. Clone the Repository
```
git clone https://github.com/cnart003/aws-devops-nodejs.git
cd aws-devops-nodejs
```
### 2. Authenticate with AWS CLI
Ensure AWS CLI is configured with credentials:
```
aws configure
```
### 3. Deploy Kubernetes Cluster
If the cluster isn’t created yet:
```
eksctl create cluster --name devops-eks-cluster --region us-east-2 --nodegroup-name nodejs-app-nodes --node-type t3.medium --nodes 2
```
### 4. Build and Push Docker Image
```
docker build -t <your-ecr-repo-url>:latest .
docker push <your-ecr-repo-url>:latest
```
### 5. Apply Kubernetes Configurations
```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```
### 6. Enable Logging & Monitoring (CloudWatch)
By default, Kubernetes captures logs using `kubectl logs`. 

#### **Fluent Bit Logging (Not Working)**
We attempted to integrate **Fluent Bit** for log forwarding to **AWS CloudWatch**, but encountered **IAM authorization failures (`sts:AssumeRoleWithWebIdentity` not authorized)**. 

As a result, **Fluent Bit log forwarding is not included** in this deployment. However, standard `kubectl logs` still provides access to pod logs.

## Security Considerations
### AWS IAM Roles & Policies
  - Configured to follow least privilege access principles.
  - Policies are attached to EKS nodes via IAM roles.
### Secrets Management
  - Environment variables & credentials are stored securely in AWS Secrets Manager.
  - Avoids hardcoding sensitive data in the repository.
### CI/CD Security
  - GitHub Actions secrets used to handle AWS credentials safely.
  - Docker image scanning before pushing to AWS ECR.
### Logging & Monitoring
  - AWS CloudWatch captures container logs using `kubectl logs`.
  - Grafana (optional) can be used for visualization.
  - **Fluent Bit was attempted but failed due to IAM issues.**

## **How to shutdown & rerun the application**
In order to avoid excess costs, follow these steps to **shut down** and **restart** the application.

### **Shutdown The Application**
#### 1. Scale Down the Node Group
```
aws eks update-nodegroup-config --cluster-name devops-eks-cluster --nodegroup-name NodeGroup-lzWVi0rlZxfX --scaling-config minSize=0,maxSize=1,desiredSize=0
```

#### 2. Verify the Node Status
```
kubectl get nodes
```
- You should see "SchedulingDisabled" on all nodes.

### **Run the Application**
#### 1. Scale Up the Node Group
```
aws eks update-nodegroup-config --cluster-name devops-eks-cluster --nodegroup-name NodeGroup-lzWVi0rlZxfX --scaling-config minSize=1,maxSize=2,desiredSize=1
```
This ensures that at least one node is running to host your application.

#### 2. Uncordon the Nodes (Allow Scheduling)
```
kubectl uncordon ip-192-168-30-221.us-east-2.compute.internal
kubectl uncordon ip-192-168-81-20.us-east-2.compute.internal
```

#### 3. Restart the Deployment
```
kubectl rollout restart deployment nodejs-app
```

#### 4. Verify Everything is Running
```
kubectl get nodes
kubectl get pods
kubectl get services
- Nodes should be "Ready" (no SchedulingDisabled).
- Pods should be "Running".
- Services should show your LoadBalancer EXTERNAL-IP.
```

### If you need to check your EKS Node Group, run:
```
aws eks describe-nodegroup --cluster-name devops-eks-cluster --nodegroup-name NodeGroup-lzWVi0rlZxfX
```

### If the website doesn't work after startup, check the EXTERNAL-IP of your service:**
```
- kubectl get services
```

## Known Issues
### Fluent Bit Logging (Failed)
- **Problem:** Fluent Bit could not assume the IAM role due to persistent **sts:AssumeRoleWithWebIdentity** authorization failures.
- **What I Tried:**
  - Verified IAM role permissions and policies.
  - Ensured the correct **OIDC provider association** in EKS.
  - Extracted and manually validated **JWT web identity tokens**.
  - Redeployed Fluent Bit multiple times with updated policies.
- **Current Status:** **Logging to AWS CloudWatch via Fluent Bit is NOT working.**
- **Alternative Logging Method:** Use `kubectl logs` to view pod logs manually.

## Maintainer
**Caleb Nartey**
- https://github.com/cnart003
- www.linkedin.com/in/calebnartey
- portfolio website coming soon!
