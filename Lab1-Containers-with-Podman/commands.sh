```bash
#!/bin/bash

Verify Podman installation
podman --version

Pull Nginx image
podman pull docker.io/library/nginx:alpine

# ----------------------------
# Task 1 – Detached Mode
# ----------------------------
podman run -d docker.io/library/nginx:alpine
podman ps

# ----------------------------
# Task 2 – Port Mapping
# ----------------------------
podman stop $(podman ps -q)
podman run -d -p 8080:80 docker.io/library/nginx:alpine
podman ps
curl http://localhost:8080

# ----------------------------
# Task 3 – Volume Mounts
# ----------------------------
mkdir -p ~/nginx-content
echo "Hello from host!" > ~/nginx-content/index.html

podman run -d -p 8081:80 \
  -v ~/nginx-content:/usr/share/nginx/html:Z \
  docker.io/library/nginx:alpine

curl http://localhost:8081

# ----------------------------
# Task 4 – Custom Container Name
# ----------------------------
podman run -d --name my-nginx -p 8082:80 docker.io/library/nginx:alpine
podman inspect my-nginx | grep -i status
podman stop my-nginx
