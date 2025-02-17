# AWS DevOps Project – Automated Deployment with EKS, CI/CD and GitHub Actions
## Overview
This project demonstrates a **full DevOps pipeline** using **AWS EKS, Kubernetes, Docker, Terraform, and GitHub Actions** to deploy a **Node.js application**
- Automated CI/CD: GitHub Actions deploys the app on EKS
- Infrastructure as Code (IaC): EKS cluster is provisioned with AWS CloudFormation.
- Containerized Deployment: The app runs in Docker, stored in AWS ECR
- Scalability & Monitoring: Uses Kubernetes Autoscaling & CloudWatch Logs
- Security Best Practices: Secrets are stored securely in AWS Secrets Manager

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
