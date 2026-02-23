```bash
#!/bin/bash

# ----------------------------------------
# Lab 17 – Multi-Container Application
# ----------------------------------------

# Verify installations
podman --version
podman-compose --version

# ----------------------------------------
# Task 1 – Setup Project
# ----------------------------------------

mkdir -p multi-container-lab
cd multi-container-lab

# Create docker-compose.yml
cat <<EOF > docker-compose.yml
version: '3.8'

services:
  web:
    image: docker.io/python:3.9
    command: python -m http.server 8000
    ports:
      - "8000:8000"
    volumes:
      - ./app:/app
    depends_on:
      - redis
      - db
    networks:
      - app-network

  redis:
    image: docker.io/redis:alpine
    ports:
      - "6379:6379"
    volumes:
      - redis-data:/data
    networks:
      - app-network

  db:
    image: docker.io/postgres:13-alpine
    environment:
      POSTGRES_PASSWORD: example
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - app-network

volumes:
  redis-data:
  postgres-data:

networks:
  app-network:
    driver: bridge
EOF

# Deploy stack
podman-compose up -d
podman ps

curl http://localhost:8000

# ----------------------------------------
# Task 2 – Secrets
# ----------------------------------------

echo "supersecret" | podman secret create db_password -

podman-compose down
podman-compose up -d

# ----------------------------------------
# Task 3 – Generate Kubernetes YAML
# ----------------------------------------

podman kube generate --service -f k8s-deployment.yaml web redis db

podman play kube k8s-deployment.yaml

podman pod ps
podman ps

# ----------------------------------------
# Cleanup
# ----------------------------------------

podman-compose down
podman secret rm db_password
