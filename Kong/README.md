# Kong

## Links

[Plugin hub](https://docs.konghq.com/hub/)

## Setup

Start the minikube and tunnel in. For further steps use a separate terminal as the tunnel has to keep running.

```shell
minikube start
minikube tunnel
```


Install Kong with Helm

```shell
helm repo add kong https://charts.konghq.com
helm repo update
helm install -f Kong/helm-config.yaml kong/kong --generate-name --set ingressController.installCRDs=false -n kong --create-namespace 
```

Get the service name:

```shell
kubectl get service -n kong
```

Export the service's IP, replacing the number in the service name with the one y

```shell
export PROXY_IP=$(kubectl get -o jsonpath="{.status.loadBalancer.ingress[0].ip}" service -n kong-1681903656-kong-proxy )
```

Deploy a test app

```shell
kubectl apply -f https://bit.ly/echo-service
```

Apply configuration

```shell
kubectl apply -f Kong/kong-ingress.yaml
```

> Warning: When testing the `host` section stopped the server from being reachable.

Test connection

```shell
curl -i http://kong.example/echo --resolve kong.example:80:$PROXY_IP
```

