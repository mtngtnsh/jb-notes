# Kubernetes

## How to install Kubernetes(kubeadm, kubectl & kubelet)?

### Installation(Ubuntu 20.04)

```sh
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
```

```sh
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get install -y kubelet kubeadm kubectl
```

```sh
apt-mark hold kubelet kubeadm kubectl
```

Ref: [Installing kubeadm, kubelet and kubectl](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl)

## Delete namespace

```
kubectl delete namespace {ns_name}
```

## Terminating namespace couldn't be deleted?

### Solution#1

- In one terminal:

```
kubectl proxy
```

- In another terminal:

BTW, you need install `jq`.

```
kubectl get ns delete-me -o json | \
  jq '.spec.finalizers=[]' | \
  curl -X PUT http://localhost:8001/api/v1/namespaces/delete-me/finalize -H "Content-Type: application/json" --data @-
```

### Solution#2

```
kubectl patch ns <your_namespace> -p '{"metadata":{"finalizers":null}}'
```

### Reference

- Ref#1: [kubectl proxy & curl](https://stackoverflow.com/a/63066925)
- Ref#2: [kubectl patch](https://stackoverflow.com/a/66118514)
