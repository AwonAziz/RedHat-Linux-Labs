This lab focused on fundamental container runtime operations using Podman.  
The objective was to understand how to run, manage, and configure containers in a Linux environment without relying on Docker.

Podman is a daemonless container engine that provides a secure and production-ready alternative to Docker.

Here i learned to:
- Run containers in detached (background) mode
- Map container ports to host machine ports
- Mount host directories as container volumes
- Assign custom names to containers for easier management

Environment:

- Podman version 3.x+
- Linux-based system
- Nginx (Alpine image)

Image used:

docker.io/library/nginx:alpine

Task 1 – Running a Container in Detached Mode

Goal:
Run an Nginx container in the background.

Command Used

bash:
podman run -d docker.io/library/nginx:alpine

Verification:
podman ps

//Detached mode is critical in production environments where services must run continuously without blocking the shell session.

Task 2 – Port Mapping

Goal:
Expose container services to the host system.

Stop Existing Containers:
podman stop $(podman ps -q)

Run with Port Mapping:
podman run -d -p 8080:80 docker.io/library/nginx:alpine

Verification:
podman port <container_id>
curl http://localhost:8080

//Port mapping is essential for exposing microservices in containerized architectures.

Task 3 – Volume Mounts

Goal:
Persist data by mounting host directories into the container.

Create Host Directory:
mkdir ~/nginx-content
echo "Hello from host!" > ~/nginx-content/index.html

Run with Volume Mount:
podman run -d -p 8081:80 -v ~/nginx-content:/usr/share/nginx/html:Z docker.io/library/nginx:alpine

Verification:
curl http://localhost:8081

//Volume mounts enable persistent storage and configuration management in containerized applications.

Task 4 – Assigning Custom Names

Goal:
Improve container management using custom names.

Run Named Container:
podman run -d --name my-nginx -p 8082:80 docker.io/library/nginx:alpine

Verify Status:
podman inspect my-nginx | grep -i status

Stop Container:
podman stop my-nginx

//Naming containers improves automation, monitoring, and scripting in DevOps workflows.
//These concepts form the foundation for containerized deployments in production environments and AI Ops pipelines.
