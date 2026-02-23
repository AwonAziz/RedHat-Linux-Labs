```bash
#!/bin/bash

# -----------------------------------
# Setup
# -----------------------------------

mkdir -p entrypoint-cmd-lab
cd entrypoint-cmd-lab

# -----------------------------------
# Task 1 – Basic ENTRYPOINT + CMD
# -----------------------------------

cat <<EOF > Containerfile
FROM registry.access.redhat.com/ubi9/ubi-minimal
ENTRYPOINT ["echo", "Entrypoint says:"]
CMD ["Default CMD message"]
EOF

podman build -t entrypoint-demo .

podman run --rm entrypoint-demo
podman run --rm entrypoint-demo "Custom message"

# -----------------------------------
# Task 2 – Script-based ENTRYPOINT
# -----------------------------------

cat <<EOF > greet.sh
#!/bin/sh
echo "Welcome to \$1 from \$2"
EOF

chmod +x greet.sh

cat <<EOF > Containerfile
FROM registry.access.redhat.com/ubi9/ubi-minimal
COPY greet.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/greet.sh"]
CMD ["OpenShift Lab", "Red Hat"]
EOF

podman build -t greet-demo .

podman run --rm greet-demo
podman run --rm greet-demo "Container Workshop" "Instructor"

# -----------------------------------
# Task 3 – Override ENTRYPOINT
# -----------------------------------

podman run --rm --entrypoint echo greet-demo "This completely replaces the ENTRYPOINT"

# -----------------------------------
# Cleanup
# -----------------------------------

podman rmi entrypoint-demo greet-demo
