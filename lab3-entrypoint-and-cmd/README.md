This lab explored how container startup behavior is controlled using the `ENTRYPOINT` and `CMD` instructions inside a Containerfile (Dockerfile-compatible).

The goal was to understand how these two directives interact, how they can be overridden at runtime, and why the exec form is preferred in production environments.

This lab was built and tested using Podman.

I demonstrated the ability to:

- Understand the difference between ENTRYPOINT and CMD
- Combine ENTRYPOINT and CMD effectively
- Override default container commands at runtime
- Replace ENTRYPOINT entirely using runtime flags
- Understand shell form vs exec form behavior

Environment

- Podman (Docker-compatible CLI)
- Red Hat UBI 9 Minimal base image
- Linux terminal environment

Base image used:

registry.access.redhat.com/ubi9/ubi-minimal

Task 1 – Basic ENTRYPOINT and CMD

## Containerfile

dockerfile:
FROM registry.access.redhat.com/ubi9/ubi-minimal

ENTRYPOINT ["echo", "Entrypoint says:"]
CMD ["Default CMD message"]

//ENTRYPOINT defines the executable that always runs.
CMD provides default arguments to ENTRYPOINT.
Together they form:
echo "Entrypoint says:" "Default CMD message"

Build the Image:
podman build -t entrypoint-demo .

Run with Default Behavior:
podman run --rm entrypoint-demo

Expected output:
Entrypoint says: Default CMD message
Override CMD at Runtime
podman run --rm entrypoint-demo "Custom message"

Expected output:
Entrypoint says: Custom message

//Arguments provided after the image name replace the CMD instruction but NOT the ENTRYPOINT.

Task 2 – Script-Based ENTRYPOINT:

greet.sh

//#!/bin/sh
echo "Welcome to $1 from $2"
chmod +x greet.sh
Updated Containerfile
FROM registry.access.redhat.com/ubi9/ubi-minimal

COPY greet.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/greet.sh"]
CMD ["OpenShift Lab", "Red Hat"]//

Build Script-Based Image:
podman build -t greet-demo 

Run with Defaults:
podman run --rm greet-demo

Expected output:
Welcome to OpenShift Lab from Red Hat

Override Arguments:
podman run --rm greet-demo "Container Workshop" "Instructor"

Expected output:
Welcome to Container Workshop from Instructor

Task 3 – Overriding ENTRYPOINT

ENTRYPOINT can be replaced entirely using the --entrypoint flag.

podman run --rm --entrypoint echo greet-demo "This completely replaces the ENTRYPOINT"

Expected output:

This completely replaces the ENTRYPOINT

Task 4 – Shell Form vs Exec Form

Shell Form Example:
FROM registry.access.redhat.com/ubi9/ubi-minimal

ENTRYPOINT echo "Shell form ENTRYPOINT:
CMD echo "Shell form CMD"

Key Differences:
Exec Form (Recommended)	        Shell Form
JSON array syntax	              Plain command string
No shell invocation	            Runs through /bin/sh -c
Proper signal handling	        Can cause signal handling issues

//Exec form is preferred in production because it allows proper signal forwarding and graceful shutdown handling in container orchestration systems like Kubernetes.

//In real-world DevOps / AI Ops environments:
ENTRYPOINT is often used to launch application processes.
CMD provides flexible runtime parameters.
Script-based ENTRYPOINTs initialize environment variables, run migrations, or perform startup validation.
Proper exec form usage ensures Kubernetes can gracefully terminate containers.
