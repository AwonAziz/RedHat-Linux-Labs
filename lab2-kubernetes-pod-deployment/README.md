This lab focused on deploying and managing a basic Pod in Kubernetes.  
The objective was to understand the structure of a Pod YAML manifest, deploy it to a cluster, and perform troubleshooting using built-in Kubernetes tools.

This lab was performed on a local Kubernetes cluster (Minikube/Kind/OpenShift Local).

here i learned to:
- Understand the structure of a Kubernetes Pod YAML manifest
- Deploy a Pod using `kubectl apply`
- Inspect Pod status and debug using logs and describe commands
- Use port forwarding to access a running Pod


Environment

- Kubernetes cluster (Minikube / Kind / OpenShift Local)
- kubectl CLI
- YAML manifest configuration
- Nginx container image

Task 1 – Writing a Pod YAML Manifest

## Manifest File: simple-pod.yaml

yaml
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
   
Key Components Explained:

apiVersion – Specifies the Kubernetes API version.
kind – Defines the resource type (Pod).
metadata – Identifies the Pod (name, labels).
spec – Defines the container configuration.
image – Specifies the container image.
containerPort – Declares the container’s exposed port.

#Task 2 – Deploying the Pod

Apply the Manifest:
kubectl apply -f simple-pod.yaml

Expected output:
pod/nginx-pod created

Verify Deployment:
kubectl get pods

Expected status:

NAME        READY   STATUS    RESTARTS   AGE
nginx-pod   1/1     Running   0          10s

#Task 3 – Inspecting and Troubleshooting

Describe Pod:
kubectl describe pod nginx-pod

View Logs:
kubectl logs nginx-pod

#Task 4 – Accessing the Pod

Port Forward:
kubectl port-forward nginx-pod 8080:80

Then open:
http://localhost:8080

You should see the Nginx welcome page.

//In real-world AI Ops / DevOps environments:
Pods are managed through Deployments for scalability
Monitoring is handled via Prometheus + Grafana
Logs are aggregated using ELK or similar stacks
CI/CD pipelines automate Kubernetes deployments
