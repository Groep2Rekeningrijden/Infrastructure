# Kong

## Links

[Plugin hub](https://docs.konghq.com/hub/)

## Setup

Start the minikube and tunnel in. For further steps use a separate terminal as the tunnel has to keep running.

```shell
minikube start
minikube tunnel
```


Install Kong with Helm.

```shell
helm repo add kong https://charts.konghq.com
```

```shell
helm repo update
helm install -f Kong/helm-config.yaml kong/kong --generate-name --set ingressController.installCRDs=false -n kong --create-namespace 
```

Get the service name:

```shell
kubectl get service -n kong
```

Deploy a test app

```shell
kubectl apply -f https://bit.ly/echo-service
```

Apply configuration

> Warning: When testing the `host` section stopped the server from being reachable.


```shell
kubectl apply -f Kong/kong-ingress.yaml
```

