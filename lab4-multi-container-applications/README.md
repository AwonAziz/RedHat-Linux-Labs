This lab focused on deploying and managing a multi-container application using `podman-compose`, configuring persistent storage and networking, implementing secrets management, and generating Kubernetes YAML for deployment using `podman play kube`.

The application stack consisted of:

- A Python web service
- A Redis cache
- A PostgreSQL database

This lab demonstrates foundational orchestration skills required in DevOps and AI Ops environments.

I demonstrated the ability to:

- Define multi-container applications using docker-compose.yml
- Configure volumes, networks, and inter-service dependencies
- Implement container secrets securely
- Deploy and manage stacks using podman-compose
- Generate Kubernetes YAML using Podman
- Deploy containers using podman play kube

Environment

- Podman 3.x+
- podman-compose
- Linux-based system
- YAML configuration

Task 1 – Deploy Multi-Container Application

## Project Setup

bash
mkdir multi-container-lab && cd multi-container-lab

Deploy the Stack:
podman-compose up -d

Verify containers:
podman ps

Test web service:
curl http://localhost:8000

Key Concepts:
depends_on ensures startup order
Volumes persist database and Redis data
Networks allow container-to-container communication
-d runs services in detached mode

Task 2 – Secrets Management

Create a Secret:
echo "supersecret" | podman secret create db_password -

Update Compose File for Secret Usage:
db:
  image: docker.io/postgres:13-alpine
  secrets:
    - db_password
  environment:
    POSTGRES_PASSWORD_FILE: /run/secrets/db_password

secrets:
  db_password:
    external: true

Redeploy:
podman-compose down
podman-compose up -d

//Using secrets instead of environment variables improves security and aligns with best practices in Kubernetes and OpenShift environments.

Task 3 – Deploy with Kubernetes YAML

Generate Kubernetes YAML:
podman kube generate --service -f k8s-deployment.yaml web redis db

Inspect the generated file:
cat k8s-deployment.yaml

Deploy Using podman play kube:
podman play kube k8s-deployment.yaml

Verify deployment:
podman pod ps
podman ps

//podman kube generate bridges container-compose workflows into Kubernetes-native YAML definitions.

In real-world DevOps / AI Ops environments:

Multi-container applications are orchestrated using Kubernetes Deployments

Secrets are managed via Kubernetes Secrets or Vault

Persistent volumes are provisioned dynamically

CI/CD pipelines deploy YAML manifests automatically

Observability tools monitor container health and logs
