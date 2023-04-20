# Metallb

Metallb is a baremetal load balancer, which is needed if we deploy to minikube to provide external IPs.

## Installation

Prepare the minikube deployment by setting `strictARP` to `true` 

```shell
kubectl edit configmap -n kube-system kube-proxy
```

```yaml
apiVersion: kubeproxy.config.k8s.io/v1alpha1
kind: KubeProxyConfiguration
mode: "ipvs"
ipvs:
  strictARP: true
```

Install via Helm

```shell
helm repo add metallb https://metallb.github.io/metallb
helm install metallb metallb/metallb -f Metallb/metallb-config.yaml
```