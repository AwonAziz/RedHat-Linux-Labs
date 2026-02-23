```bash
#!/bin/bash

# -----------------------------
# Task 1 – Create YAML Manifest
# -----------------------------

cat <<EOF > simple-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
  - name: nginx-container
    image: nginx:latest
    ports:
    - containerPort: 80
EOF

# -----------------------------
# Task 2 – Deploy Pod
# -----------------------------

kubectl apply -f simple-pod.yaml

kubectl get pods

# -----------------------------
# Task 3 – Inspect Pod
# -----------------------------

kubectl describe pod nginx-pod

kubectl logs nginx-pod

# -----------------------------
# Task 4 – Port Forward
# -----------------------------

kubectl port-forward nginx-pod 8080:80
