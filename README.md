# AWS DevOps Project – Automated Deployment with EKS, CI/CD and GitHub Actions
## Overview
This project demonstrates a **full DevOps pipeline** using **AWS EKS, Kubernetes, Docker, Terraform, and GitHub Actions** to deploy a **Node.js application** with security best practices and logging.
##Key Features
- Automated CI/CD: GitHub Actions deploys the app to AWS EKS.
- Infrastructure as Code (IaC): The EKS cluster is provisioned with AWS CloudFormation.
- Containerized Deployment: The application is containerized with Docker and stored in AWS ECR.
- Scalability & Monitoring: Kubernetes Autoscaling and AWS CloudWatch Logs for real-time monitoring.
- Security Best Practices:
  - IAM Roles & Policies: Follows the least privilege principle.
  - AWS Secrets Manager: Secures environment variables and sensitive data.
  - CloudWatch & Grafana (Optional): Logging and monitoring added to enhance security.

## Technologies Used
- Cloud Provider: AWS (EKS, ECR, IAM, CloudFormation, CloudWatch)
- Container Orchestration: Kubernetes (kubectl, eksctl)
- CI/CD: GitHub Actions
- Infrastructure as Code (IaC): CloudFormation
- Containerization: Docker
- Programming Language: Node.js
- Monitoring & Logging: AWS CloudWatch, Fluent Bit (optional)
- Security: IAM roles, AWS Secrets Manager
  
## Prerequisites
Ensure you have installed the following before deploying this project
- **AWS CLI** (Configured with your IAM credentials)
- **kubectl** (For interacting with Kubernetes clusters)
- **eksctl** (For managing EKS clusters)
- **Docker** (For containerizing applications)
- **GitHub CLI (gh)** (For managing repositories)
- **Git** (For version control)

## Deployment Steps
1. Clone the Repository

## Security Considerations
1. **AWS IAM Roles & Policies**
  - Configured to follow least privilege access principles.
  - Policies are attached to EKS nodes via IAM roles.
3. **Secrets Management**
  - Environment variables & credentials are stored securely in AWS Secrets Manager.
  - Avoids hardcoding sensitive data in the repository.
4. **CI/CD Security**
  - GitHub Actions secrets used to handle AWS credentials safely.
  - Docker image scanning before pushing to AWS ECR.
5. **Logging & Monitoring**
  - AWS CloudWatch captures container logs.
  - Grafana (optional) can be used for visualization.

## How to shutdown & rerun the application
In order to avoid excess costs, it's important to scale down the application when not in use.

**Shutdown The Application**

1. Scale Down the Node Group
- aws eks update-nodegroup-config --cluster-name devops-eks-cluster --nodegroup-name NodeGroup-lzWVi0rlZxfX --scaling-config minSize=0,maxSize=1,desiredSize=0

2. Verify the Node Status
- kubectl get nodes
  - You should see "SchedulingDisabled" on all nodes.

**Run the Application**
1. Scale Up the Node Group
- aws eks update-nodegroup-config --cluster-name devops-eks-cluster --nodegroup-name NodeGroup-lzWVi0rlZxfX --scaling-config minSize=1,maxSize=2,desiredSize=1
  - This ensures that at least one node is running to host your application.

2. Uncordon the Nodes (Allow Scheduling)
- kubectl uncordon ip-192-168-30-221.us-east-2.compute.internal
- kubectl uncordon ip-192-168-81-20.us-east-2.compute.internal

3. Restart the Deployment
- kubectl rollout restart deployment nodejs-app

4. Verify Everything is Running
- kubectl get nodes
- kubectl get pods
- kubectl get services
  - Nodes should be "Ready" (no SchedulingDisabled).
  - Pods should be "Running".
  - Services should show your LoadBalancer EXTERNAL-IP.

If you need to check your EKS Node Group, run:
- aws eks describe-nodegroup --cluster-name devops-eks-cluster --nodegroup-name NodeGroup-lzWVi0rlZxfX

If the website doesn't work after startup, check the EXTERNAL-IP of your service:
- kubectl get services
