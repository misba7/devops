# Microservices Deployment Project

A simple microservices deployment using Docker, Kubernetes, Terraform, and GitHub Actions.

## Overview
- Python app containerized using Docker
- Deployed and exposed externally using Kubernetes 
- Terraform to deploy an AWS EKS Cluster 
- CI/CD using GitHub Actions to automate building and deploying to DockerHub

## Docker 
```bash
# Build the image
docker build -t microservice-app .

# Run locally
docker run -p 5000:5000 microservice-app
```

The app should be accessible at `http://IP-or-localhost:5000`. Test endpoints like `/products`.

## Terraform 
Terraform needs AWS permissions to deploy the EKS cluster:

```bash
# Option 1: AWS CLI. Simplest.
aws configure

# Option 2: Environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_REGION="us-east-1"
```

Deploy the cluster:
```bash
cd terraform
terraform init
terraform apply
```

## Kubernetes
Configure kubectl with the output command from Terraform:
```bash
aws eks update-kubeconfig --region us-east-1 --name microservice-cluster
```

Deploy the application:
```bash
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml

# Get the external URL
kubectl get service microservice-app -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
```

## GitHub Actions

Set up these repository secrets:
- `DOCKERHUB_USERNAME` - Your DockerHub username
- `DOCKERHUB_TOKEN` - Your DockerHub access token
- `AWS_ACCESS_KEY_ID` - AWS access key
- `AWS_SECRET_ACCESS_KEY` - AWS secret key

To get a DockerHub token:
1. Log in to DockerHub
2. Account Settings → Security → Access Tokens
3. Create a new token with "Read & Write" permissions
4. Copy the token (shown only once)

The workflow automatically builds the Docker image, pushes it to DockerHub, and deploys to your Kubernetes cluster.
It also outputs the external URL to test the application.